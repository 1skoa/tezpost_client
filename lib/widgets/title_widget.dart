import 'package:flutter/material.dart';
import 'package:tezpost_client/theme/app_theme.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'TEZPOST',
      style: Theme.of(context)
          .textTheme
          .displayLarge
          ?.copyWith(color: AppTheme.appBarColor),
    );
  }
}
