import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tezpost_client/controllers/home_controller.dart';
import 'order_card_widget.dart';

class OrderResult extends StatelessWidget {
  const OrderResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<HomeController, (bool, bool, dynamic)>(
      selector: (_, c) => (c.isOrderLoading, c.hasSearched, c.order),
      builder: (_, tuple, __) {
        final (isLoading, hasSearched, order) = tuple;

        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (order != null) {
          return OrderCard(order: order);
        }

        final text = hasSearched
            ? 'Ничего не найдено'
            : 'Введите трек-код и нажмите поиск';

        return Center(
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.white),
          ),
        );
      },
    );
  }
}