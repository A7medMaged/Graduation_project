import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:smart_home/core/theming/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:getwidget/getwidget.dart';

class FaceCam extends StatefulWidget {
  const FaceCam({super.key});

  @override
  State<FaceCam> createState() => _FaceCamState();
}

class _FaceCamState extends State<FaceCam> {
  late final WebViewController _controller;
  var loadingPercentage = 0;
  String? streamUrl;
  String? faceName;
  StreamSubscription<DatabaseEvent>? nameSubscription;

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
    listenToNameChanges();
  }

  Future<void> fetchStreamUrl() async {
    try {
      DatabaseReference urlRef = FirebaseDatabase.instance.ref(
        'stream/camera2/url',
      );
      DatabaseEvent urlEvent = await urlRef.once();
      final url = urlEvent.snapshot.value?.toString();

      if (mounted && url != null && url.isNotEmpty) {
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

  void listenToNameChanges() {
    final nameRef = FirebaseDatabase.instance.ref('faces/log/faces/0');

    nameSubscription = nameRef.onValue.listen((event) {
      final name = event.snapshot.value?.toString();
      if (mounted) {
        setState(() {
          faceName = name;
        });
      }
    });
  }

  @override
  void dispose() {
    nameSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Face Recognition${faceName != null ? " - $faceName" : ""}",
        ),
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
