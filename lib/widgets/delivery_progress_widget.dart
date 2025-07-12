import 'package:flutter/material.dart';

class DeliveryProgressWidget extends StatelessWidget {
  final String currentStatusName;

  const DeliveryProgressWidget({super.key, required this.currentStatusName});

  static const steps = [
    {'name': 'Прием заказа', 'label': 'Прием'},
    {'name': 'Готов к отправке', 'label': 'Упакован'},
    {'name': 'В пути', 'label': 'В пути'},
    {'name': 'В ожидании выдачи', 'label': 'Заберите'},
    {'name': 'Оплачен', 'label': 'Оплачен'},
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = steps.indexWhere((step) => step['name'] == currentStatusName);

    return Column(
      children: [
        Row(
          children: List.generate(steps.length * 2 - 1, (i) {
            if (i.isEven) {
              final index = i ~/ 2;
              final isLast = index == steps.length - 1;
              final isCompleted = index < currentIndex || (isLast && currentIndex == index);
              final isActive = index == currentIndex && !isLast;

              return Expanded(
                child: Column(
                  children: [
                    AnimatedDot(
                      isActive: isActive,
                      isCompleted: isCompleted,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      steps[index]['label']!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        color: isCompleted || isActive ? Colors.green : Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              final index = (i - 1) ~/ 2;
              final isLineActive = index < currentIndex;
              return Container(
                height: 2,
                width: 16,
                color: isLineActive ? Colors.green : Colors.grey.shade400,
              );
            }
          }),
        ),

      ],
    );
  }
}

class AnimatedDot extends StatefulWidget {
  final bool isActive;
  final bool isCompleted;

  const AnimatedDot({super.key, required this.isActive, required this.isCompleted});

  @override
  State<AnimatedDot> createState() => _AnimatedDotState();
}

class _AnimatedDotState extends State<AnimatedDot> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    if (widget.isActive) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedDot oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isActive && !_controller.isAnimating) {
      _controller.repeat(reverse: true);
    } else if (!widget.isActive && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dotContent = Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        color: widget.isActive || widget.isCompleted ? Colors.green : Colors.grey,
        shape: BoxShape.circle,
        boxShadow: widget.isActive
            ? [BoxShadow(color: Colors.green.withOpacity(0.6), blurRadius: 6)]
            : [],
      ),
      child: widget.isCompleted && !widget.isActive
          ? const Icon(Icons.check, size: 12, color: Colors.white)
          : null,
    );

    if (!widget.isActive) return dotContent;

    return ScaleTransition(
      scale: Tween(begin: 1.0, end: 1.3).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      )),
      child: dotContent,
    );
  }
}
