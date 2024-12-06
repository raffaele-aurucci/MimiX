import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../beans/expression_scores.dart';

class WebView extends StatefulWidget {

  const WebView({
    Key? key,
    required this.onExpressionScoresUpdated, // update external expression scores
    required this.onCameraHiddenUpdated,     // update external hidden camera state
    required this.onFaceDetectedUpdated      // update external face detected state
  }) : super(key: key);

  final Function(ExpressionScores? expressionScores) onExpressionScoresUpdated;
  final Function(bool hidden) onCameraHiddenUpdated;
  final Function(bool detected) onFaceDetectedUpdated;

  @override
  State<StatefulWidget> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {

  final InAppLocalhostServer localhostServer = InAppLocalhostServer(documentRoot: 'assets/camera/');
  late final Future future;

  InAppWebViewSettings settings = InAppWebViewSettings(
      isInspectable: kDebugMode,
      mediaPlaybackRequiresUserGesture: false,
      allowsInlineMediaPlayback: true,
      iframeAllow: "camera; microphone",
      iframeAllowFullscreen: true,
      disableHorizontalScroll: true,
      disableVerticalScroll: true
  );

  @override
  void initState() {
    super.initState();
    future = localhostServer.start();
  }

  @override
  void dispose() {
    localhostServer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: InAppWebView(
              initialSettings: settings,
              initialUrlRequest: URLRequest(
                url: WebUri("http://localhost:8080/index.html"),
              ),
              onWebViewCreated: (controller) {
                controller.addWebMessageListener(
                  WebMessageListener(
                    jsObjectName: "FaceDetection",
                    onPostMessage: (message, sourceOrigin, isMainFrame, replyProxy) {

                      if (message?.data != null) {
                        Map<String, dynamic> object = jsonDecode(message!.data);
                        var data = object['data'];

                        // Callback for using expression scores data to external
                        if (data != null) {
                          ExpressionScores _expressionScores = ExpressionScores.fromJson(data);
                          widget.onExpressionScoresUpdated(_expressionScores);
                          widget.onFaceDetectedUpdated(true);
                        }

                        // Callback for handle overlay of progress indicator
                        var hidden = object['hidden'];
                        if (hidden != null) {
                          widget.onCameraHiddenUpdated(hidden);
                        }

                        // Callback for face blendshape detected (always false)
                        var detected = object['detected'];
                        if (detected != null) {
                          widget.onFaceDetectedUpdated(detected);
                        }

                      }
                    },
                  ),
                );
              },
              onPermissionRequest: (controller, request) async {
                return PermissionResponse(
                  resources: request.resources,
                  action: PermissionResponseAction.GRANT,
                );
              },
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}