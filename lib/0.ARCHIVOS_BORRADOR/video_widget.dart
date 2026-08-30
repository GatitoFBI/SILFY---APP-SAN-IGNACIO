// import 'package:flutter/material.dart';
// import 'package:youtube_player_iframe/youtube_player_iframe.dart';

// class VideoWidget extends StatefulWidget {
//   final String videoId;

//   const VideoWidget({
//     super.key,
//     required this.videoId,
//   });

//   @override
//   State<VideoWidget> createState() => _VideoWidgetState();
// }

// class _VideoWidgetState extends State<VideoWidget> with WidgetsBindingObserver {
//   late YoutubePlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);

//     _controller = YoutubePlayerController.fromVideoId(
//       videoId: widget.videoId.trim(),
//       autoPlay: false,
//       params: const YoutubePlayerParams(
//         showFullscreenButton: true,
//         showControls: true,
//         enableCaption: false, // ❌ sin subtítulos
//         strictRelatedVideos: false,
//         playsInline: true,
//         enableJavaScript: true,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.pauseVideo();
//     _controller.close();
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.paused ||
//         state == AppLifecycleState.inactive ||
//         state == AppLifecycleState.detached) {
//       _controller.pauseVideo();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return YoutubePlayerScaffold(
//       controller: _controller,
//       autoFullScreen: false, // ✅ evita rotación automática
//       builder: (context, player) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(20),
//             child: AspectRatio(
//               aspectRatio: 16 / 9,
//               child: player,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
