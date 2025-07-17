import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tezpost_client/controllers/home_controller.dart';
import 'home_screen.dart';
import 'orders_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  final int bottomNavIndex;
  const MainScreen({super.key, this.bottomNavIndex = 0});

  static final ValueNotifier<int> selectedIndexNotifier = ValueNotifier<int>(0);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final HomeController _homeController;
  late final List<Widget> _screens;
  late final VoidCallback _listener;
  @override
  void initState() {
    super.initState();

    _homeController = HomeController();
    _homeController.loadAllData();

    _listener = () {
      if (!mounted) return;
      setState(() {});
    };

    _screens = [
      ChangeNotifierProvider(
        create: (_) => _homeController,
        child: const HomeScreen(),
      ),
      const OrdersScreen(),
      const ProfileScreen(),
    ];

    MainScreen.selectedIndexNotifier.addListener(_listener);
  }

  @override
  void dispose() {
    MainScreen.selectedIndexNotifier.removeListener(_listener);
    super.dispose();
  }

  void onItemTapped(int index) {
    MainScreen.selectedIndexNotifier.value = index;
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = MainScreen.selectedIndexNotifier.value;

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onItemTapped,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Мои заказы'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Мой профиль'),
        ],
      ),
    );
  }
}