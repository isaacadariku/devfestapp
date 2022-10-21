import 'package:devfestapp/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialButton extends StatefulWidget {
  const SocialButton({
    super.key,
    required this.icon,
    this.tooltip,
    this.onPressed,
  });

  final String icon;
  final String? tooltip;
  final VoidCallback? onPressed;

  @override
  State<SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  bool _isHovered = false;

  void onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Tooltip(
          message: widget.tooltip,
          child: AnimatedContainer(
            duration: kDuration,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _isHovered ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.asset(
              widget.icon,
              color: _isHovered ? Colors.black : Colors.white,
              width: 20,
              height: 20,
            ),
          ),
        ),
      ),
    );
  }
}
