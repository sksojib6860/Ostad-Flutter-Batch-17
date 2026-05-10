import 'package:flutter/material.dart';

import '../../../../core/entities/app_string.dart';

class BioDataWidget extends StatelessWidget {
  const BioDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Center(
        child: Text(
          AppString.biodata,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.grey[600],
            height: 1.5,
          ),
        ),
      ),
    );
  }
}
