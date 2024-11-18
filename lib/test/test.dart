import 'dart:convert';
import 'dart:developer';

import 'package:app_web_detection/test/models.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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

  // List of allowed category names
  final List<String> allowedCategories = [
    'jawOpen',
    'browDownLeft',
    'browDownRight',
    'browOuterUpLeft',
    'browOuterUpRight',
    'mouthSmileLeft',
    'mouthSmileRight',
    'mouthPucker',
    'mouthShrugLower',
  ];

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
            log(_output.toString());
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
            child:
            result != null && result!.faceDetected
                ?
                ListView.builder(
                  itemCount: result?.faceBlendshapes?.categories
                      ?.where((category) =>
                      allowedCategories.contains(category.categoryName))
                      .length ??
                      0,
                  itemBuilder: (context, index) {
                    // Filtering categories based on allowed categories
                    final filteredCategories = result?.faceBlendshapes?.categories
                        ?.where((category) =>
                        allowedCategories.contains(category.categoryName))
                        .toList() ??
                        [];

                    final Category category = filteredCategories[index];
                    return ListTile(
                      title: Text(category.categoryName ?? 'UNKNOWN'),
                      subtitle: Text((category.score ?? 0).roundDecimal().toString()),
                    );
                  },
            ) : const Center(
                child: Text(
                "None face detected",
                style: TextStyle(fontSize: 18, color: Colors.red),
                ),
                ),
          ),
          Positioned(
            width: 100,
            height: 100,
            right: 16,
            bottom: 16,
            child: WebViewWidget(controller: _controller),
          ),
        ],
      ),
    );
  }
}

extension RoundDecimal on double {
  double roundDecimal({int precision = 2}) =>
      double.parse('$this'.substring(0, '$this'.indexOf('.') + precision + 1));
}
