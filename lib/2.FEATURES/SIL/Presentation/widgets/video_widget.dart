import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoWidget extends StatefulWidget {
  final String videoId;

  const VideoWidget({
    super.key,
    required this.videoId,
  });

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> with WidgetsBindingObserver {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    // Escuchar eventos de la app (como minimizar o cambiar de pantalla)
    WidgetsBinding.instance.addObserver(this);

    // Inicializa el controlador del video
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        disableDragSeek: true,
        hideControls: false,
        hideThumbnail: false,
        controlsVisibleAtStart: true,
        enableCaption: false, // ❌ Sin subtítulos
        forceHD: true,
        showLiveFullscreenButton: true,
        useHybridComposition: true,
        loop: false,
      ),
    );
  }

  @override
  void dispose() {
    // Siempre pausamos al destruir el widget
    _controller.pause();
    _controller.dispose();

    // Quitamos el observador
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // Detecta cambios en el estado de la app
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      // Si la app está minimizada o pierde foco: pausamos
      _controller.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: const Color(0xff53B175),
        progressColors: const ProgressBarColors(
          playedColor: Color(0xff53B175),
          handleColor: Color(0xff53B175),
          backgroundColor: Colors.grey,
          bufferedColor: Colors.lightGreen,
        ),
        liveUIColor: const Color(0xff53B175),
        bottomActions: [
          const SizedBox(width: 8),
          CurrentPosition(),
          const SizedBox(width: 8),
          ProgressBar(isExpanded: true),
          const SizedBox(width: 8),
          RemainingDuration(),
          const SizedBox(width: 8),
          FullScreenButton(),
        ],
      ),
      builder: (context, player) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: player,
          ),
        );
      },
    );
  }
}
