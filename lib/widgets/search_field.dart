import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tezpost_client/controllers/home_controller.dart';
import 'package:tezpost_client/theme/app_theme.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<HomeController>();
    final colorScheme = Theme.of(context).colorScheme;

    return TextField(
      controller: controller.trackCodeController,
      textInputAction: TextInputAction.search,
      style: TextStyle(color: colorScheme.onSurface),
      onSubmitted: (_) => controller.searchOrder(context),
      decoration: InputDecoration(
        labelText: 'Введите трек-код',
        labelStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.7)),
        suffixIcon: IconButton(
          icon: Icon(Icons.search, color: colorScheme.primary),
          onPressed: () => controller.searchOrder(context),
        ),
        filled: true,
        fillColor: colorScheme.surface.withOpacity(0.9),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.radius),
          borderSide: BorderSide(color: colorScheme.outlineVariant ?? Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.radius),
          borderSide: BorderSide(color: colorScheme.outlineVariant ?? Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.radius),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
      ),
    );
  }
}