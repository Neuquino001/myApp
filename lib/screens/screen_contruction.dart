import 'package:flutter/material.dart';

class ScreenContruction extends StatelessWidget {
  final String? name;
  const ScreenContruction({Key? key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Text(
          'Screen $name\n\n In Contruction!',
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
