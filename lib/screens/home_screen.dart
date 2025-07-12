import 'package:flutter/material.dart';
import 'package:tezpost_client/widgets/content_layer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: ContentLayer(),
      ),
    );
  }
}