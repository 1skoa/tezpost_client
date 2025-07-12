import 'package:flutter/material.dart';
import 'package:tezpost_client/widgets/title_widget.dart';
import 'package:tezpost_client/widgets/search_field.dart';
import 'package:tezpost_client/widgets/order_result.dart';
import 'package:tezpost_client/widgets/shipping_chips.dart';
import 'package:tezpost_client/widgets/direction_list.dart';
import 'package:tezpost_client/widgets/background_layer.dart';
import 'package:tezpost_client/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:tezpost_client/controllers/home_controller.dart';

class ContentLayer extends StatelessWidget {
  const ContentLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<HomeController, bool>(
      selector: (_, c) => c.isPricesLoading,
      builder: (_, isLoading, __) {
        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Stack(
          children: [
            BackgroundLayer(),
            ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.padding,
                vertical: 16,
              ),
              physics: const BouncingScrollPhysics(),
              children: const [
                TitleWidget(),
                SizedBox(height: 24),
                SearchField(),
                SizedBox(height: 24),
                OrderResult(),
                SizedBox(height: 24),
                ShippingChips(),
                SizedBox(height: 24),
                DirectionList(),
              ],
            ),
          ],
        );
      },
    );
  }
}