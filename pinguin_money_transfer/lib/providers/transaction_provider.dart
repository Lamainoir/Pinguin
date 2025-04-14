import 'package:flutter/foundation.dart';
import '../models/transaction.dart';
import '../services/transaction_service.dart';
import 'auth_provider.dart';

class TransactionProvider with ChangeNotifier {
  List<Transaction> _transactions = [];
  final TransactionService _transactionService;
  bool _isLoading = false;

  TransactionProvider(this._transactionService);

  List<Transaction> get transactions => _transactions;
  bool get isLoading => _isLoading;

  Future<void> loadTransactions() async {
    _isLoading = true;
    notifyListeners();

    try {
      _transactions = await _transactionService.getTransactions();
    } catch (e) {
      print('Error loading transactions: $e');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> sendMoney(String recipientPhone, double amount, String pin) async {
    _isLoading = true;
    notifyListeners();

    try {
      final transaction = await _transactionService.sendMoney(recipientPhone, amount, pin);
      _transactions.insert(0, transaction);
      notifyListeners();
    } catch (e) {
      print('Error sending money: $e');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> payBill(String billType, String customerNumber, double amount, String pin) async {
    _isLoading = true;
    notifyListeners();

    try {
      final transaction = await _transactionService.payBill(billType, customerNumber, amount, pin);
      _transactions.insert(0, transaction);
      notifyListeners();
    } catch (e) {
      print('Error paying bill: $e');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
} 