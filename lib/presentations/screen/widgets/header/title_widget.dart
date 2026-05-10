import 'package:flutter/material.dart';

import '../../../../core/entities/app_color.dart';
import '../../../../core/entities/app_string.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppString.designation,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColor.appBarColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
