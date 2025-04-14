import 'package:flutter/material.dart';

class SendMoneyScreen extends StatelessWidget {
  final phoneController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Send Money')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Recipient Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Send'),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Money Sent!')),
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
