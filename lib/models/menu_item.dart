import 'dart:ui';

class MenuItem {
  final String title;
  final String imageAsset;
  final Color lightColor;
  final Color darkColor;
  final VoidCallback onTap;

  MenuItem({
    required this.title,
    required this.imageAsset,
    required this.lightColor,
    required this.darkColor,
    required this.onTap,
  });
}
