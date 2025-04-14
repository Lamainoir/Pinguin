import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final double balance = 2500.00;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: Text('Account Balance'),
                subtitle: Text('\$${balance.toStringAsFixed(2)}'),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.send),
              label: Text('Send Money'),
              onPressed: () => Navigator.pushNamed(context, '/send'),
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.history),
              label: Text('Transaction History'),
              onPressed: () => Navigator.pushNamed(context, '/history'),
            ),
          ],
        ),
      ),
    );
  }
}
