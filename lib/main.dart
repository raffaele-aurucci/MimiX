import 'dart:convert';
import 'dart:developer';

import 'package:app_web_detection/models.dart';
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
  @override
  void initState() {
    // #docregion platform_features
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
    // #enddocregion platform_features

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
          /* ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(output.toString())),
          ); */
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
          Positioned.fill(child: 
          ListView.builder(
            itemCount: result?.faceBlendshapes?.categories?.length ?? 0,
            itemBuilder: (context, index) {
            final Category category = result!.faceBlendshapes!.categories![index];
            return ListTile(
              title: Text(category.categoryName ?? 'UNKNOWN'),
              subtitle: Text((category.score ?? 0).roundDecimal(precision: 1).toString()),);
          },),
          ),
          Positioned(
            width: 100,
            height: 100,
            right: 16,
            bottom: 16,
            child: WebViewWidget(controller: _controller))
        ],
      
      ) ,
    );
  }
}

extension RoundDecimal on double {
  double roundDecimal({int precision = 2}) => 
  double.parse('$this'.substring(0, '$this'.indexOf('.') + precision + 1));
}

