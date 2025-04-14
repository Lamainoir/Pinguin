import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../models/transaction.dart';
import 'transaction_detail_screen.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    try {
      await Provider.of<TransactionProvider>(context, listen: false).loadTransactions();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final transactions = Provider.of<TransactionProvider>(context).transactions;
    final isLoading = Provider.of<TransactionProvider>(context).isLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
      ),
      body: RefreshIndicator(
        onRefresh: _loadTransactions,
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : transactions.isEmpty
                ? const Center(
                    child: Text('No transactions found'),
                  )
                : ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = transactions[index];
                      return _buildTransactionCard(transaction);
                    },
                  ),
      ),
    );
  }

  Widget _buildTransactionCard(Transaction transaction) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Icon(
          transaction.type == 'transfer' ? Icons.send : Icons.receipt,
          color: transaction.type == 'transfer' ? Colors.blue : Colors.green,
        ),
        title: Text(
          transaction.type == 'transfer'
              ? 'Transfer to ${transaction.recipientPhone}'
              : 'Payment to ${transaction.merchantName}',
        ),
        subtitle: Text(
          '${transaction.amount.toStringAsFixed(2)} USD\n${transaction.createdAt.toString()}',
        ),
        trailing: Text(
          transaction.status,
          style: TextStyle(
            color: transaction.status == 'completed' ? Colors.green : Colors.orange,
          ),
        ),
      ),
    );
  }
} 