import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _controller;
  List<CameraDescription>? cameras;

  @override
  void initState() {
    super.initState();
    _setupCamera();
  }

  Future<void> _setupCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras == null || cameras!.isEmpty) {
        throw Exception("No camera found");
      }
      _controller = CameraController(cameras!.first, ResolutionPreset.high);
      await _controller!.initialize();
      setState(() {}); // SetState setelah inisialisasi selesai
    } catch (e) {
      print("Error initializing camera: $e");
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return Scaffold(
        appBar: AppBar(title: Text("Camera")),
        body: Center(child: CircularProgressIndicator()),
      );
    }
    
    return Scaffold(
      appBar: AppBar(title: Text("Camera")),
      body: CameraPreview(_controller!),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            if (!_controller!.value.isInitialized) return;
            final image = await _controller!.takePicture();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Photo saved to: ${image.path}")),
            );
          } catch (e) {
            print("Error taking picture: $e");
          }
        },
        child: Icon(Icons.camera),
      ),
    );
  }
}
