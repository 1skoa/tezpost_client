import 'package:flutter/material.dart';
import 'package:tezpost_client/api/api_service.dart';
import 'package:tezpost_client/models/price_model.dart';
import 'package:tezpost_client/utils/constants.dart';
import 'package:tezpost_client/widgets/price_card_widget.dart';
import 'package:tezpost_client/widgets/shipping_chips.dart';

class PricesScreen extends StatefulWidget {

  const PricesScreen({super.key});

  @override
  State<PricesScreen> createState() => _PricesScreenState();
}

class _PricesScreenState extends State<PricesScreen> {
  int selectedId = 1;
  List<PriceModel> prices = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPrices();
  }

  Future<void> _fetchPrices() async {
    setState(() => isLoading = true);
    try {
      final fetchedPrices = await ApiService.fetchPrices(selectedId);
      setState(() {
        prices = fetchedPrices;
        isLoading = false;
      });
    } catch (e) {
      print('Ошибка при загрузке цен: $e');
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.85,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      builder: (_, scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: colorScheme.background,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              ShippingChips(
                selectedId: selectedId,
                onChanged: (id) {
                  setState(() => selectedId = id);
                  _fetchPrices();
                },
              ),
              const SizedBox(height: 12),
              Text(
                'Цены на доставку',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                  controller: scrollController,
                  itemCount: prices.length,
                  itemBuilder: (_, i) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: PriceCard(price: prices[i]),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
