import 'package:flutter/material.dart';

class NoSelectionPage extends StatelessWidget {
  const NoSelectionPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 96, bottom: 16),
              child: Icon(Icons.select_all, size: 80),
            ),
            ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 300),
                child: const Text(
                  'choose element first',
                  textAlign: TextAlign.center,
                ))
          ],
        ),
      ),
    );
  }
}
