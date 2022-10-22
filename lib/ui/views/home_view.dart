import 'dart:html' as html;

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:devfestapp/constants/app_constants.dart';
import 'package:devfestapp/data/speakers_data.dart';
import 'package:devfestapp/extensions/build_context_extension.dart';
import 'package:devfestapp/ui/widgets/speaker_details.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 60,
        vertical: 30.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResponsiveGridRow(
            children: [
              ResponsiveGridCol(
                xs: 12,
                md: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedTextKit(
                      animatedTexts: [
                        ColorizeAnimatedText(
                          'DevFest Abuja 2022',
                          textStyle: context.textTheme.headline3!,
                          colors: colorizeColors,
                        ),
                      ],
                      repeatForever: true,
                      pause: const Duration(microseconds: 100),
                    ),
                    const SizedBox(height: 10),
                    SelectableText(
                      'GDG DevFest is a community-led, developer event happening all over the world.',
                      style: context.textTheme.headline6!,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            html.window.open(
                              'https://gdg.community.dev/accounts/login/?next=/gdg-abuja/',
                              'GDG DevFest Abuja 2022',
                            );
                          },
                          child: const Text('Join Us'),
                        ),
                        const SizedBox(width: 10),
                        OutlinedButton(
                          onPressed: () {
                            html.window.open(
                              'https://gdg.community.dev/gdg-abuja/',
                              'GDG DevFest Abuja 2022',
                            );
                          },
                          child: const Text('Watch Live'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SelectableText(
                      'Speakers at DevFest Abuja 2022',
                      style: context.textTheme.headline5,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            flex: context.isMobileDisplay ? 1 : 3,
            child: ResponsiveGridList(
              desiredItemWidth: context.isMobileDisplay ? 150 : 220,
              minSpacing: context.isMobileDisplay ? 15 : 25,
              shrinkWrap: true,
              children: [
                for (final speaker in shuffledSpeakers) SpeakerDetails(speaker),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
