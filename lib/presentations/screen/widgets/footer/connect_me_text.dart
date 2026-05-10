import 'package:flutter/material.dart';

import '../../../../core/entities/app_string.dart';

class ConnectMeText extends StatelessWidget {
  const ConnectMeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppString.connectWithMe,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Colors.black,
        fontSize: 15,
        fontWeight: .bold,
      ),
    );
  }
}
