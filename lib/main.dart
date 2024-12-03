import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CornerRadiusProvider(),
      child: MaterialApp(
        title: 'Rounded Container Config',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const RoundedContainerScreen(),
      ),
    );
  }
}

class RoundedContainerScreen extends StatelessWidget {
  const RoundedContainerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rounded Container Config')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Spacer(),
            // Віджет для контейнера
            BlueContainer(),
            SizedBox(height: 20),
            // Секція з слайдерами
            SliderSection(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class CornerRadiusProvider extends ChangeNotifier {
  double _topLeftRadius = 20.0;
  double _bottomRightRadius = 20.0;

  double get topLeftRadius => _topLeftRadius;
  double get bottomRightRadius => _bottomRightRadius;

  void updateTopLeftRadius(double value) {
    _topLeftRadius = value;
    notifyListeners();
  }

  void updateBottomRightRadius(double value) {
    _bottomRightRadius = value;
    notifyListeners();
  }
}

class BlueContainer extends StatelessWidget {
  const BlueContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final topLeftRadius = context.watch<CornerRadiusProvider>().topLeftRadius;
    final bottomRightRadius =
        context.watch<CornerRadiusProvider>().bottomRightRadius;

    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeftRadius),
          bottomRight: Radius.circular(bottomRightRadius),
        ),
      ),
    );
  }
}

class SliderSection extends StatelessWidget {
  const SliderSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<CornerRadiusProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Слайдер для верхнього лівого кута
        const Text('Top Left Radius'),
        Slider(
          value: context.watch<CornerRadiusProvider>().topLeftRadius,
          min: 0,
          max: 75,
          onChanged: (value) => provider.updateTopLeftRadius(value),
        ),
        // Слайдер для нижнього правого кута
        const Text('Bottom Right Radius'),
        Slider(
          value: context.watch<CornerRadiusProvider>().bottomRightRadius,
          min: 0,
          max: 75,
          onChanged: (value) => provider.updateBottomRightRadius(value),
        ),
      ],
    );
  }
}
