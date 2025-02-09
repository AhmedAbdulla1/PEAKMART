import 'package:flutter/material.dart';

class AdditionalDetails extends StatelessWidget {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _bankController = TextEditingController();
  final TextEditingController _ibanController = TextEditingController();

  AdditionalDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _idController,
              decoration: InputDecoration(labelText: 'ID Number'),
            ),
            TextField(
              controller: _bankController,
              decoration: InputDecoration(labelText: 'Bank Name'),
            ),
            TextField(
              controller: _ibanController,
              decoration: InputDecoration(labelText: 'IBAN of your account'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle ID photo upload
              },
              child: Text('Drag and drop your ID photo'),
            ),
          ],
        ),
    );
  }
}
