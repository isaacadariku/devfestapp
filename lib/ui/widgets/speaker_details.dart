import 'dart:html' as html;

import 'package:devfestapp/constants/app_constants.dart';
import 'package:devfestapp/extensions/build_context_extension.dart';
import 'package:devfestapp/model/speaker_model.dart';
import 'package:devfestapp/ui/widgets/social_button.dart';
import 'package:flutter/material.dart';

part 'speaker_image.dart';
part 'speaker_social_buttons.dart';

class SpeakerDetails extends StatefulWidget {
  const SpeakerDetails(this.speaker, {super.key});
  final Speaker speaker;

  @override
  State<SpeakerDetails> createState() => _SpeakerDetailsState();
}

class _SpeakerDetailsState extends State<SpeakerDetails> {
  bool _isHovered = false;

  void _isMouseRegion(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (e) => _isMouseRegion(true),
      onExit: (e) => _isMouseRegion(false),
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 1, end: _isHovered ? 1.08 : 1),
        duration: kDuration,
        builder: (context, scale, child) => Transform.scale(
          scale: scale,
          child: child,
        ),
        child: _SpeakerImage(
          widget.speaker,
          isHovered: _isHovered,
        ),
      ),
    );
  }
}
