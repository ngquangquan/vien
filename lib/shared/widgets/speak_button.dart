import 'package:flutter/material.dart';
import '../../core/tts/tts_service.dart';

class SpeakButton extends StatefulWidget {
  final String text;
  final TtsAccent accent;
  final double iconSize;
  final Color? color;
  final String? tooltip;
  final EdgeInsetsGeometry padding;

  const SpeakButton({
    super.key,
    required this.text,
    this.accent = TtsAccent.us,
    this.iconSize = 22,
    this.color,
    this.tooltip,
    this.padding = const EdgeInsets.all(4),
  });

  @override
  State<SpeakButton> createState() => _SpeakButtonState();
}

class _SpeakButtonState extends State<SpeakButton> {
  bool _isPlaying = false;

  Future<void> _speak() async {
    if (widget.text.trim().isEmpty) return;
    setState(() => _isPlaying = true);

    await TtsService().speak(
      widget.text,
      accent: widget.accent,
    );

    if (mounted) {
      // Cho hiệu ứng icon nhấp nháy nhẹ khi phát
      Future.delayed(const Duration(milliseconds: 600), () {
        if (mounted) setState(() => _isPlaying = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveColor = widget.color ?? theme.colorScheme.primary;

    return IconButton(
      iconSize: widget.iconSize,
      padding: widget.padding,
      constraints: const BoxConstraints(),
      tooltip: widget.tooltip ?? 'Phát âm (${widget.accent.label})',
      icon: AnimatedScale(
        scale: _isPlaying ? 1.2 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: Icon(
          Icons.volume_up_rounded,
          color: _isPlaying ? theme.colorScheme.tertiary : effectiveColor,
        ),
      ),
      onPressed: _speak,
    );
  }
}
