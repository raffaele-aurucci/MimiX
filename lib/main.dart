import 'dart:convert';
import 'dart:developer';

import 'package:app_web_detection/models.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';

// Import for Android and iOS/macOS features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

void main() async {
  // If Flutter needs to call native code before calling runApp (Permission.camera),
  // this method makes sure that you have an instance of the WidgetsBinding,
  // which is required to use platform channels to call the native code.
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.camera.request();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  // controls a WebView provided by the host platform.
  late final WebViewController _controller;
  FaceDetectionResult? result;

  @override
  void initState() {
    late final PlatformWebViewControllerCreationParams params;

    // This configuration allows the WebView on iOS/macOS to automatically play
    // media (audio and video) inline, without exiting the WebView or requiring
    // any user action to start playback.
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    // If the web content in the WebView requests a permission (use the camera),
    // request.grant() automatically grants access to the camera without asking
    // the user to manually confirm.
    //
    // ATTENTION: If the camera permission is denied at the system level
    // (via Permission.camera.request()), the WebView will not be able to access
    // the camera, even if it tries to do so through JavaScript.
    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(
          params,
          onPermissionRequest: (WebViewPermissionRequest request) {
            request.grant();
            },
        );

    // Configures the WebView to:
    // - allow JavaScript
    // - load an HTML file (face_mesh.html) from the app's assets.
    // - add JavaScript channel called 'FaceDetection'
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

    // Configures the WebView on Android to enable debugging (log JS, etc.)
    // and allow media (like audio and video) to play automatically without
    // requiring the user to perform an action
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
              result != null && result!.faceDetected
                  ?
                    ListView.builder(
                      itemCount: result?.faceBlendshapes?.categories?.length ?? 0,
                      itemBuilder: (context, index) {
                        final Category category = result!.faceBlendshapes!.categories![index];
                        return ListTile(
                          title: Text(category.categoryName ?? 'UNKNOWN'),
                          subtitle: Text((category.score ?? 0).roundDecimal(precision: 1).toString()),);
                      },)
                  : const Center(
                      child: Text(
                        "None face detected",
                        style: TextStyle(fontSize: 18, color: Colors.red),
                      ),
                    ),
              ),
          Positioned( // in bottom-right is visible the WebView
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

// add method roundDecimal to class double
extension RoundDecimal on double {
  double roundDecimal({int precision = 2}) =>
  double.parse('$this'.substring(0, '$this'.indexOf('.') + precision + 1));
}

