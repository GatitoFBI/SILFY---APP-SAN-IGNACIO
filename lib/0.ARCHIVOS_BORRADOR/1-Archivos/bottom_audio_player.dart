// import 'package:flutter/material.dart';

// import '../../../../1.CONFIG/Core/utils/tts_helper.dart';

// class BottomAudioPlayer extends StatefulWidget {
//   final String text;
//   const BottomAudioPlayer({super.key, required this.text});

//   @override
//   State<BottomAudioPlayer> createState() => _BottomAudioPlayerState();
// }

// class _BottomAudioPlayerState extends State<BottomAudioPlayer> {
//   bool isPlaying = true;

//   @override
//   void initState() {
//     super.initState();
//     TTSHelper.speak(widget.text);
//   }

//   void togglePlayback() {
//     setState(() {
//       isPlaying = !isPlaying;
//       if (isPlaying) {
//         TTSHelper.speak(widget.text);
//       } else {
//         TTSHelper.stop();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       child: Row(
//         children: [
//           IconButton(
//             icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
//             onPressed: togglePlayback,
//           ),
//           const Expanded(
//             child: Text(
//               'Reproduciendo...',
//               style: TextStyle(fontSize: 16),
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.close),
//             onPressed: () {
//               TTSHelper.stop();
//               Navigator.pop(context);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
