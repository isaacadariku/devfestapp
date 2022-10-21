part of 'speaker_details.dart';

class _SpeakerImage extends StatelessWidget {
  const _SpeakerImage(this.speaker, {this.isHovered = false});
  final Speaker speaker;
  final bool isHovered;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            speaker.image,
            fit: BoxFit.cover,
            width: 220,
            height: 250,
          ),
        ),
        Container(
          height: 250,
          width: 220,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.5),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          right: 30,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableText(
                speaker.name,
                style: context.textTheme.caption!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              SelectableText(
                speaker.bio,
                // softWrap: true,
                style: context.textTheme.caption!.copyWith(
                  fontSize: 10,
                  color: Colors.white,
                ),
              ),
              if (isHovered) ...[
                const SizedBox(height: 5),
                _SpeakerSocialButtons(speaker),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
