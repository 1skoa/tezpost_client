import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tezpost_client/controllers/home_controller.dart';
import 'package:tezpost_client/models/menu_item.dart';
import 'package:tezpost_client/screens/prices_screen.dart';
import 'package:tezpost_client/screens/warehouse_address_screen.dart';
import 'package:tezpost_client/screens/warehousetj_address_screen.dart';
import 'package:tezpost_client/theme/app_theme.dart';
import 'package:tezpost_client/widgets/menu_card.dart';
import 'package:tezpost_client/widgets/order_result.dart';
import 'package:tezpost_client/widgets/search_field.dart';
import 'package:tezpost_client/widgets/title_widget.dart';

class ContentLayer extends StatelessWidget {
  const ContentLayer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final menuItems = [
      MenuItem(
        title: 'Адреса складов (Китай)',
        imageAsset: 'assets/images/addresses.png',
        lightColor: const Color(0xFFD0E8FF),
        darkColor: const Color(0xFF1A2E44),
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => const WarehouseAddressScreen(),
          );
        },
      ),
      MenuItem(
        title: 'Адреса складов (Таджикистан)',
        imageAsset: 'assets/images/addresses-tj.png',
        lightColor: const Color(0xFFFFD7D0),
        darkColor: const Color(0xFF3E2723),
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => const WarehouseTjAddressScreen(),
          );
        },
      ),
      MenuItem(
        title: 'Цены',
        imageAsset: 'assets/images/price.png',
        lightColor: const Color(0xFFD3FFBD),
        darkColor: const Color(0xFF1B3E1B),
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => const PricesScreen(isDark: false),
          );
        },
      ),
      MenuItem(
        title: 'Операторы',
        imageAsset: 'assets/images/operator.png',

        lightColor: const Color(0xFFFFF6C1),
        darkColor: const Color(0xFF3E3E1E),
        onTap: () {},
      ),
      MenuItem(
        title: 'VIP заказ',
        imageAsset: 'assets/images/vip.png',
        lightColor: const Color(0xFFC1FFFD),
        darkColor: const Color(0xFF004D40),
        onTap: () {},
      ),
      MenuItem(
        title: 'Доставка',
        imageAsset: 'assets/images/delivery.png',
        lightColor: const Color(0xFFFFE4D0),
        darkColor: const Color(0xFF4E342E),
        onTap: () {},
      ),
    ];

    return Selector<HomeController, bool>(
      selector: (_, c) => c.isPricesLoading,
      builder: (_, isLoading, __) {
        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.padding,
            vertical: 16,
          ),
          physics: const BouncingScrollPhysics(),
          children: [
            const TitleWidget(),
            const SizedBox(height: 24),
            const SearchField(),
            const SizedBox(height: 24),
            const OrderResult(),
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: menuItems.map((item) {
                return SizedBox(
                  width: (MediaQuery.of(context).size.width -
                      AppTheme.padding * 2 -
                      12) /
                      2,
                  child: MenuCard(
                    title: item.title,
                    imageAsset: item.imageAsset,
                    backgroundColor:
                    isDark ? item.darkColor : item.lightColor,
                    onTap: item.onTap,
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
