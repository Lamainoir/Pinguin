import 'package:flutter/material.dart';

class TransactionHistoryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> transactions = [
    {'to': '1234567890', 'amount': 100.0, 'date': '2025-04-01'},
    {'to': '9876543210', 'amount': 50.0, 'date': '2025-04-05'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transaction History')),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final tx = transactions[index];
          return ListTile(
            leading: Icon(Icons.arrow_upward),
            title: Text('Sent \$${tx['amount']} to ${tx['to']}'),
            subtitle: Text(tx['date']),
          );
        },
      ),
    );
  }
}
