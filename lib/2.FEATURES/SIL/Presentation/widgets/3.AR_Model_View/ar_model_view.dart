import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ARModelViewer extends StatelessWidget {
  final String modelUrl;
  final String? title;

  const ARModelViewer({super.key, required this.modelUrl, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modelo 3D "$title"'),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: ModelViewer(
          backgroundColor: Colors.white,
          src: modelUrl,
          // src: "assets/mi_modelo.glb",
          // src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb',

          alt: 'Modelo 3D de prueba',
          ar: true, // Solo funciona en Android (WebXR compatible)
          autoRotate: true,
          cameraControls: true,
          disableZoom: false,
        ),
      ),
    );
  }
}
