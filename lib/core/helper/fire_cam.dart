import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:smart_home/core/theming/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:getwidget/getwidget.dart';

class FireCam extends StatefulWidget {
  const FireCam({super.key});

  @override
  State<FireCam> createState() => _FireCamState();
}

class _FireCamState extends State<FireCam> {
  late final WebViewController _controller;
  var loadingPercentage = 0;
  String? streamUrl;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() => loadingPercentage = 0);
          },
          onProgress: (progress) {
            setState(() => loadingPercentage = progress);
          },
          onPageFinished: (url) {
            setState(() => loadingPercentage = 100);
          },
        ),
      );

    fetchStreamUrl();
  }

  Future<void> fetchStreamUrl() async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref(
        'stream/camera1/url',
      );
      DatabaseEvent event = await ref.once();

      final url = event.snapshot.value?.toString();
      if (url != null && url.isNotEmpty) {
        setState(() {
          streamUrl = url;
        });
        _controller.loadRequest(Uri.parse(url));
      }
    } catch (e) {
      debugPrint("Failed to fetch stream URL: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load video stream.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fire Camera"),
        backgroundColor: Colors.transparent,
      ),
      body: streamUrl == null
          ? const Center(
              child: GFLoader(
                type: GFLoaderType.circle,
                loaderColorOne: mainColor,
                loaderColorTwo: mainColor,
                loaderColorThree: mainColor,
                loaderstrokeWidth: 2.0,
              ),
            )
          : Stack(
              children: [
                WebViewWidget(controller: _controller),
                if (loadingPercentage < 100)
                  LinearProgressIndicator(
                    value: loadingPercentage / 100,
                    color: mainColor,
                  ),
              ],
            ),
    );
  }
}
