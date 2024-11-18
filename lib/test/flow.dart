import 'dart:convert';
import 'dart:developer';
import 'dart:async';

import 'package:mimix_app/test/models.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';

// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS/macOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.camera.request();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mimix',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const FaceDetection(),
    );
  }
}

class FaceDetection extends StatefulWidget {
  const FaceDetection({super.key});

  @override
  State<FaceDetection> createState() => _FaceDetectionState();
}

class _FaceDetectionState extends State<FaceDetection> {
  late final WebViewController _controller;
  FaceDetectionResult? result;

  static List<String> words = ["mouthPucker", "jawOpen"];
  Timer? wordCycleTimer;
  Timer? checkActionTimer;
  static int index = 0;

  bool flagAction = false;

  int points = 0;

  void startWordCycle() {
    wordCycleTimer = Timer.periodic(Duration(seconds: 5), (Timer t) {
      advanceToNextWord();
    });
  }

  void advanceToNextWord() {
    setState(() {
      // Se l'azione non è stata eseguita (flagAction è ancora false), Game Over
      if (!flagAction) {
        showGameOver();
        wordCycleTimer?.cancel();
        checkActionTimer?.cancel();
        points = 0;
        return;
      }

      // Reset flagAction e passa alla prossima parola
      flagAction = false;
      index = (index + 1) % words.length;
    });
  }

  void showGameOver() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Game Over"),
          content: const Text("Non hai eseguito l'azione richiesta in tempo!"),
          actions: [
            TextButton(
              child: const Text("Restart"),
              onPressed: () {
                Navigator.of(context).pop();
                restartGame();
              },
            ),
          ],
        );
      },
    );
  }

  void restartGame() {
    setState(() {
      flagAction = false;
      index = 0;
    });
    startWordCycle();
    checkActionCycle();
  }

  void checkActionCycle() {
    checkActionTimer = Timer.periodic(const Duration(milliseconds: 100), (Timer t) {
      if (result != null && result!.faceDetected) {
        if (!flagAction) {
          var score = checkAction(result!, words[index]);

          if (score > 0.5) {
            flagAction = true;
            setState(() {
              points+=1;
            });
            wordCycleTimer?.cancel();
            advanceToNextWord();
            startWordCycle();
          }
        }
      }
    });
  }

  @override
  void initState() {
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
    WebViewController.fromPlatformCreationParams(
      params,
      onPermissionRequest: (WebViewPermissionRequest request) {
        request.grant();
      },
    );

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadFlutterAsset('assets/face_mesh.html')
      ..addJavaScriptChannel(
        'FaceDetection',
        onMessageReceived: (JavaScriptMessage message) {
          try {
            final _output = jsonDecode(message.message);
            setState(() {
              result = FaceDetectionResult.fromJson(_output);
            });
          } catch (error) {
            log('ERROR', error: error);
          }
        },
      );

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    _controller = controller;
    startWordCycle();
    checkActionCycle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FACE"),
      ),
      body: Stack(
        children: [
          Positioned.fill(
              child: Column(children: [
                Center(
                  child: Text(
                    words[index],
                    style: const TextStyle(fontSize: 30, color: Colors.red),
                  ),
                ),
                Center(
                    child: Text(
                      'Points: $points',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ])),
          Positioned(
              width: 100,
              height: 100,
              right: 16,
              bottom: 16,
              child: WebViewWidget(controller: _controller))
        ],
      ),
    );
  }
}

double checkAction(FaceDetectionResult result, String wordAction) {
  var category = result.faceBlendshapes?.categories?.firstWhere(
        (category) => category.categoryName == wordAction,
    orElse: () => Category(categoryName: 'UNKNOWN', score: 0.0),
  );

  var score = category?.score ?? 0.0;
  return score;
}


