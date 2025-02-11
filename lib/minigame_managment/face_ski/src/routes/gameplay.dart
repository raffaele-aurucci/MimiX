import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/sprite.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/widgets.dart';
import 'package:mimix_app/minigame_managment/face_ski/src/actors/snowman.dart';
import 'package:mimix_app/minigame_managment/face_ski/src/game.dart';
import 'package:mimix_app/minigame_managment/face_ski/src/hud.dart';
import 'package:mimix_app/minigame_managment/face_ski/src/actors/player.dart';
import 'package:mimix_app/minigame_managment/face_ski/src/globals.dart';

class Gameplay extends Component with HasGameReference<FaceSkiGame> {
  Gameplay({
        required this.onLevelCompleted,
        required this.onGameOver,
      });

  static const id = 'Gameplay';
  static const _timeScaleRate = 1;
  static const _bgmFadeRate = 1;
  static const _bgmMinVol = 0;
  static const _bgmMaxVol = 0.6;

  final ValueChanged<int> onLevelCompleted;
  final VoidCallback onGameOver;

  late final _resetTimer = Timer(1, autoStart: false, onTick: _resetPlayer);
  late final _cameraShake = MoveEffect.by(
    Vector2(0, 3),
    InfiniteEffectController(ZigzagEffectController(period: 0.2)),
  );

  late final World _world;
  late final CameraComponent _camera;
  late Player player;
  late final Vector2 _lastSafePosition;
  late final Hud _hud;
  late final SpriteSheet _spriteSheet;

  int _nLives = 3;

  int _nTrailTriggers = 0;
  bool get _isOffTrail => _nTrailTriggers == 0;

  bool _levelCompleted = false;
  bool _gameOver = false;

  AudioPlayer? _bgmPlayer;

  PlayerController playerController = PlayerController();

  @override
  Future<void> onLoad() async {
    final map = await TiledComponent.load(
      GlobalState.isPreviewPage ? 'MiniMape.tmx' : 'Level.tmx',
      Vector2.all(16),
    );

    await game.images.load('tilemap_packed.png');

    final tiles = game.images.fromCache('tilemap_packed.png');
    _spriteSheet = SpriteSheet(image: tiles, srcSize: Vector2.all(16));

    await _setupWorldAndCamera(map);
    await _handleSpawnPoints(map);
    await _handleTriggers(map);

    _hud = Hud(
      playerSprite: _spriteSheet.getSprite(5, 10),
    );

    await _camera.viewport.addAll([_hud]);
    await _camera.viewfinder.add(_cameraShake);
    _cameraShake.pause();
  }

  @override
  void update(double dt) {

    if (_levelCompleted || _gameOver) {
      player.timeScale = lerpDouble(
        player.timeScale,
        0,
        _timeScaleRate * dt,
      )!;
    } else {
      if (_isOffTrail && GlobalState.active) {
        _resetTimer.update(dt);

        if (!_resetTimer.isRunning()) {
          _resetTimer.start();
        }

        if (_cameraShake.isPaused) {
          _cameraShake.resume();
        }
      } else {
        if (_resetTimer.isRunning()) {
          _resetTimer.stop();
        }

        if (!_cameraShake.isPaused) {
          _cameraShake.pause();
        }
      }
    }

    if (_bgmPlayer != null) {
      if (_levelCompleted) {
        if (_bgmPlayer!.volume > _bgmMinVol) {
          _bgmPlayer!.setVolume(
            lerpDouble(_bgmPlayer!.volume, _bgmMinVol, _bgmFadeRate * dt)!,
          );
        }
      } else {
        if (_bgmPlayer!.volume < _bgmMaxVol) {
          _bgmPlayer!.setVolume(
            lerpDouble(_bgmPlayer!.volume, _bgmMaxVol, _bgmFadeRate * dt)!,
          );
        }
      }
    }
  }

  @override
  void onRemove() {
    _bgmPlayer?.dispose();
    super.onRemove();
  }

  Future<void> _setupWorldAndCamera(TiledComponent map) async {
    _world = World(children: [map]);
    await add(_world);

    // Ottieni la dimensione disponibile
    final screenSize = game.size;
    final aspectRatio = screenSize.x / screenSize.y;

    // Imposta la risoluzione in base alla dimensione del contenitore
    const height = 200.0;
    final width = height * aspectRatio;

    _camera = CameraComponent.withFixedResolution(
      width: width,
      height: height,
      world: _world,
    );

    await add(_camera);
  }

  Future<void> _handleSpawnPoints(TiledComponent map) async {
    final spawnPointLayer = map.tileMap.getLayer<ObjectGroup>('SpawnPoint');
    final objects = spawnPointLayer?.objects;

    if (objects != null) {
      for (final object in objects) {
        switch (object.class_) {
          case 'Player':
            player = Player(
              position: Vector2(object.x, object.y),
              sprite: _spriteSheet.getSprite(5, 10),
              priority: 1,
            );

            if (GlobalState.isPlayerBlocked) {
              player.blockMovement(); // Metodo da creare nel Player per bloccare il movimento
            }

            await _world.add(player);
            _camera.follow(player);
            _lastSafePosition = Vector2(object.x, object.y);
            break;

          case 'Snowman':
            final snowman = Snowman(
              position: Vector2(object.x, object.y),
              sprite: _spriteSheet.getSprite(5, 9),
              onCollected: _onSnowmanCollected,
            );

            await _world.add(snowman);
            break;
        }
      }
    }
  }

  Future<void> _handleTriggers(TiledComponent map) async {
    final triggerLayer = map.tileMap.getLayer<ObjectGroup>('Trigger');
    final objects = triggerLayer?.objects;

    if (objects != null) {
      for (final object in objects) {
        switch (object.class_) {
          case 'Trail':
            final vertices = <Vector2>[];
            for (final point in object.polygon) {
              vertices.add(Vector2(point.x + object.x, point.y + object.y));
            }

            final hitbox = PolygonHitbox(
              vertices,
              collisionType: CollisionType.passive,
              isSolid: true,
            );

            hitbox.onCollisionStartCallback = (_, __) => _onTrailEnter();
            hitbox.onCollisionEndCallback = (_) => _onTrailExit();

            await map.add(hitbox);
            break;

          case 'Checkpoint':
            final checkpoint = RectangleHitbox(
              position: Vector2(object.x, object.y),
              size: Vector2(object.width, object.height),
              collisionType: CollisionType.passive,
            );

            checkpoint.onCollisionStartCallback =
                (_, __) => _onCheckpoint(checkpoint);

            await map.add(checkpoint);
            break;

          case 'Ramp':
            final ramp = RectangleHitbox(
              position: Vector2(object.x, object.y),
              size: Vector2(object.width, object.height),
              collisionType: CollisionType.passive,
            );

            ramp.onCollisionStartCallback = (_, __) => _onRamp();

            await map.add(ramp);
            break;

          case 'Start':
            final trailStart = RectangleHitbox(
              position: Vector2(object.x, object.y),
              size: Vector2(object.width, object.height),
              collisionType: CollisionType.passive,
            );

            trailStart.onCollisionStartCallback = (_, __) => _onTrailStart();

            await map.add(trailStart);
            break;

          case 'End':
            final trailEnd = RectangleHitbox(
              position: Vector2(object.x, object.y),
              size: Vector2(object.width, object.height),
              collisionType: CollisionType.passive,
            );

            trailEnd.onCollisionStartCallback = (_, __) => _onTrailEnd();

            await map.add(trailEnd);
            break;
        }
      }
    }
  }

  void _onTrailEnter() {
    ++_nTrailTriggers;
  }

  void _onTrailExit() {
    --_nTrailTriggers;
  }

  void _onCheckpoint(RectangleHitbox checkpoint) {
    _lastSafePosition.setFrom(checkpoint.absoluteCenter);
    game.score.value += 150;
    checkpoint.removeFromParent();
  }

  void _onRamp() {
    final jumpFactor = player.jump();
    final jumpScale = lerpDouble(1, 1.08, jumpFactor)!;
    final jumpDuration = lerpDouble(0, 0.8, jumpFactor)!;

    game.score.value += 50;

    _camera.viewfinder.add(
      ScaleEffect.by(
        Vector2.all(jumpScale),
        EffectController(
          duration: jumpDuration,
          alternate: true,
          curve: Curves.easeInOut,
        ),
      ),
    );
  }

  void _onTrailStart() {
    GlobalState.active = true;
    _lastSafePosition.setFrom(player.position);
  }

  void _onTrailEnd() {
    GlobalState.active = false;
    _levelCompleted = true;
  }

  void _onSnowmanCollected() {
    game.score.value += 100;
  }

  void _resetPlayer() {
    --_nLives;
    _hud.updateLifeCount(_nLives);

    if (_nLives > 0) {
      player.resetTo(_lastSafePosition);
    } else {
      _gameOver = true;
      onGameOver.call();
    }
  }

  void turnLeft() {
    playerController.turnLeft();
  }
  void turnRight() {
    playerController.turnRight();
  }
}
