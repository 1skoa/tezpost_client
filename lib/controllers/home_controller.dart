import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '../models/order_model.dart';
import '../models/price_model.dart';
import '../models/address_model.dart';

class HomeController extends ChangeNotifier {
  final trackCodeController = TextEditingController();

  OrderModel? order;
  bool isOrderLoading = false;
  bool hasSearched = false;

  int selectedShippingId = 1;
  bool isPricesLoading = false;

  final Map<int, List<PriceModel>> _cachedPrices = {};
  final Map<int, List<AddressModel>> _cachedAddresses = {};

  final directions = {
    1: 'Урумчи',
    2: 'Иву',
    3: 'Гуанджоу',
  };

  List<PriceModel> get prices => _cachedPrices[selectedShippingId] ?? [];
  List<AddressModel> get addresses => _cachedAddresses[selectedShippingId] ?? [];

  Future<void> loadAllData() async {
    if (isPricesLoading) return;

    isPricesLoading = true;
    notifyListeners();

    try {
      await Future.wait([
        _loadShippingData(1),
        _loadShippingData(2),
      ]);
    } catch (e) {
      debugPrint('Ошибка загрузки данных: $e');
    }

    isPricesLoading = false;
    notifyListeners();
  }

  Future<void> _loadShippingData(int shippingId) async {
    if (_cachedPrices.containsKey(shippingId) &&
        _cachedAddresses.containsKey(shippingId)) {
      return;
    }

    final prices = await ApiService.fetchPrices(shippingId);
    final addresses = await ApiService.fetchAddressesByShippingId(shippingId);

    _cachedPrices[shippingId] = prices;
    _cachedAddresses[shippingId] = addresses;
  }

  void changeShipping(int id) {
    if (selectedShippingId == id) return;
    selectedShippingId = id;
    notifyListeners();
  }

  Future<void> searchOrder(BuildContext context) async {
    final trackCode = trackCodeController.text.trim();
    if (trackCode.isEmpty) return;

    isOrderLoading = true;
    hasSearched = true;
    notifyListeners();

    try {
      order = await ApiService.fetchOrderByTrackCode(trackCode);
    } catch (e) {
      order = null;
      debugPrint('Ошибка при поиске заказа: $e');
    }

    isOrderLoading = false;
    notifyListeners();
  }

  List<PriceModel> getPricesByDirection(int directionId) =>
      prices.where((p) => p.directionId == directionId).toList();

  List<AddressModel> getAddressesByDirection(int directionId) =>
      addresses.where((a) => a.directionId == directionId).toList();

  @override
  void dispose() {
    trackCodeController.dispose();
    super.dispose();
  }
}
