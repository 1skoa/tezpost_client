import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tezpost_client/api/api_service.dart';
import 'package:tezpost_client/models/operator_model.dart';

class OperatorsScreen extends StatefulWidget {
  const OperatorsScreen({super.key});

  @override
  State<OperatorsScreen> createState() => _OperatorsScreenState();
}

class _OperatorsScreenState extends State<OperatorsScreen> {
  static const platform = MethodChannel('tj.iskoa.tezpost_client/phone');

  late Future<List<OperatorModel>> _futureOperators;

  @override
  void initState() {
    super.initState();
    _futureOperators = ApiService.fetchOperators(1);
  }

  Future<void> _makePhoneCallWithChooser(String phoneNumber) async {
    try {
      await platform.invokeMethod('makePhoneCallChooser', '+992$phoneNumber');
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка вызова: ${e.message}')),
      );
    }
  }

  Future<void> _openWhatsApp(String phoneNumber) async {
    const platform = MethodChannel('tj.iskoa.tezpost_client/phone');
    final cleaned = phoneNumber.replaceAll(RegExp(r'\D'), '');

    try {
      await platform.invokeMethod('openWhatsApp', '992$cleaned');
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Не удалось открыть WhatsApp: ${e.message}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.8,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: colorScheme.background,
            borderRadius:
            const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.all(16),
          child: FutureBuilder<List<OperatorModel>>(
            future: _futureOperators,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Ошибка: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('Нет доступных операторов'));
              }

              final operators = snapshot.data!;

              return ListView.builder(
                controller: scrollController,
                itemCount: operators.length,
                itemBuilder: (context, index) {
                  final operator = operators[index];
                  return ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(operator.name),
                    subtitle: Text(operator.phone),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(FontAwesomeIcons.whatsapp, color: Colors.green),
                          onPressed: () {
                            _openWhatsApp(operator.phone);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.phone, color: Colors.green),
                          onPressed: () {
                            _makePhoneCallWithChooser(operator.phone);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
