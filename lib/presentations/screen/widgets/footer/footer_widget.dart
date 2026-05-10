import 'package:flutter/material.dart';

import '../../../../core/entities/app_string.dart';

class BottomWidget extends StatelessWidget {
  const BottomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .center,
      spacing: 30,
      children: [
        Column(
          spacing: 5,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(AppString.facebookLogoUrl),
            ),
            Text(
              'Facebook',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.black),
            ),
          ],
        ),
        Column(
          children: [
            CircleAvatar(backgroundImage: NetworkImage(AppString.gitLogoUrl)),
            Text(
              'GitHub',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.black),
            ),
          ],
        ),
        Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(AppString.instagramLogoUrl),
            ),
            Text(
              'Instagram',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.black),
            ),
          ],
        ),
      ],
    );
  }
}
