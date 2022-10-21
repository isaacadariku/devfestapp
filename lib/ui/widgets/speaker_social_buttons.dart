part of 'speaker_details.dart';

class _SpeakerSocialButtons extends StatelessWidget {
  const _SpeakerSocialButtons(this.speaker);
  final Speaker speaker;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (speaker.twitter != null) ...[
          SocialButton(
            icon: 'assets/svg/twitter.svg',
            tooltip: 'Twitter',
            onPressed: () {
              html.window.open(speaker.twitter!, 'Twitter');
            },
          ),
          const SizedBox(width: 5),
        ],
        if (speaker.linkedin != null) ...[
          SocialButton(
            icon: 'assets/svg/linkedin.svg',
            tooltip: 'LinkedIn',
            onPressed: () {
              html.window.open(speaker.linkedin!, 'LinkedIn');
            },
          ),
          const SizedBox(width: 5),
        ],
        if (speaker.slideUrl != null) ...[
          SocialButton(
            icon: 'assets/svg/google-slides.svg',
            tooltip: 'Slides',
            onPressed: () {
              html.window.open(speaker.slideUrl!, 'Google Slides');
            },
          ),
          const SizedBox(width: 5),
        ],
      ],
    );
  }
}
