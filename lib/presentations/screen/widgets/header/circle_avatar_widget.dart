import 'package:flutter/material.dart';

import '../../../../core/entities/app_color.dart';
import '../../../../core/entities/app_string.dart';

class CircleAvatarWidget extends StatelessWidget {
  const CircleAvatarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.circleAvColor.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(150),
        ),
        padding: EdgeInsets.all(4),
        child: CircleAvatar(
          radius: 70,
          backgroundImage: NetworkImage(AppString.url),
        ),
      ),
    );
  }
}