import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/transaction.dart';
import '../models/user.dart';

class TransactionService {
  static const String baseUrl = 'http://localhost:3000/api/transactions';
  final SharedPreferences _prefs;

  TransactionService(this._prefs);

  Future<String?> getToken() async {
    return _prefs.getString('token');
  }

  Future<List<Transaction>> getTransactions() async {
    try {
      final token = await getToken();
      if (token == null) throw Exception('Not authenticated');

      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Transaction.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch transactions: ${response.body}');
      }
    } catch (e) {
      print('Error fetching transactions: $e');
      rethrow;
    }
  }

  Future<Transaction> sendMoney(String recipientPhone, double amount, String pin) async {
    try {
      final token = await getToken();
      if (token == null) throw Exception('Not authenticated');

      print('Sending money request:');
      print('recipientPhone: $recipientPhone');
      print('amount: $amount');
      print('pin: $pin');

      final response = await http.post(
        Uri.parse('$baseUrl/send'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({
          'recipientPhone': recipientPhone,
          'amount': amount,
          'pin': pin,
        }),
      );

      print('Send money response status: ${response.statusCode}');
      print('Send money response body: ${response.body}');

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['transaction'] == null) {
          throw Exception('Transaction data is null in response');
        }
        return Transaction.fromJson(data['transaction']);
      } else {
        throw Exception('Failed to send money: ${response.body}');
      }
    } catch (e) {
      print('Error sending money: $e');
      rethrow;
    }
  }

  Future<Transaction> payBill(String billType, String customerNumber, double amount, String pin) async {
    try {
      final token = await getToken();
      if (token == null) throw Exception('Not authenticated');

      print('Paying bill request:');
      print('billType: $billType');
      print('customerNumber: $customerNumber');
      print('amount: $amount');
      print('pin: $pin');

      final response = await http.post(
        Uri.parse('$baseUrl/pay-bill'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({
          'billType': billType,
          'customerNumber': customerNumber,
          'amount': amount,
          'pin': pin,
        }),
      );

      print('Pay bill response status: ${response.statusCode}');
      print('Pay bill response body: ${response.body}');

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['transaction'] == null) {
          throw Exception('Transaction data is null in response');
        }
        return Transaction.fromJson(data['transaction']);
      } else {
        throw Exception('Failed to pay bill: ${response.body}');
      }
    } catch (e) {
      print('Error paying bill: $e');
      rethrow;
    }
  }
} 