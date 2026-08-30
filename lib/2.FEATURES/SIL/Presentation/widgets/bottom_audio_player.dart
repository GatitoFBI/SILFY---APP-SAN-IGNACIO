import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class BottomTTSPlayer extends StatefulWidget {
  final void Function() onFinished;
  final String text;

  const BottomTTSPlayer({
    super.key,
    required this.text,
    required this.onFinished,
  });

  @override
  State<BottomTTSPlayer> createState() => _BottomTTSPlayerState();
}

class _BottomTTSPlayerState extends State<BottomTTSPlayer> {
  final FlutterTts _tts = FlutterTts();
  bool isPlaying = true;
  int currentIndex = 0;
  List<String> parts = [];

  @override
  void initState() {
    super.initState();
    _tts.setLanguage("es-ES");
    _tts.setPitch(1);
    _tts.setSpeechRate(0.9);

    parts = _splitText(widget.text);
    _speakCurrentPart();

    _tts.setCompletionHandler(() {
      _handleCompletion();
    });
  }

  List<String> _splitText(String text) {
    final rawParts = text.split(RegExp(r'[.,;]'));
    return rawParts.where((p) => p.trim().isNotEmpty).toList();
  }

  void _speakCurrentPart() {
    _tts.speak(parts[currentIndex]);
    setState(() => isPlaying = true);
  }

  void _pause() {
    _tts.stop();
    setState(() => isPlaying = false);
  }

  void _resume() {
    _speakCurrentPart();
  }

  void _handleCompletion() {
    if (currentIndex < parts.length - 1) {
      currentIndex++;
      _speakCurrentPart();
    } else {
      widget.onFinished(); // Llama al callback cuando finaliza
    }
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill),
            iconSize: 40,
            onPressed: isPlaying ? _pause : _resume,
          ),
          const SizedBox(width: 8),
          const Text("Reproduciendo...", style: TextStyle(fontSize: 16)),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              _tts.stop();
              widget.onFinished();
            },
          ),
        ],
      ),
    );
  }
}
