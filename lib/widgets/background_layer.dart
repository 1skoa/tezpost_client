import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tezpost_client/controllers/home_controller.dart';

class BackgroundLayer extends StatelessWidget {
  const BackgroundLayer({super.key});

  @override
  Widget build(BuildContext context) {
    final shippingId = context.select<HomeController, int>((c) => c.selectedShippingId);
    final imagePath = shippingId == 1
        ? 'assets/images/avia_bg.jpg'
        : 'assets/images/auto_bg.jpg';

    precacheImage(AssetImage(imagePath), context);

    return _StaticBackground(imagePath: imagePath);
  }
}

class _StaticBackground extends StatelessWidget {
  final String imagePath;
  const _StaticBackground({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: RepaintBoundary(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.low,
              cacheHeight: 720,
              cacheWidth: 480,
            ),
            Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ],
        ),
      ),
    );
  }
}
