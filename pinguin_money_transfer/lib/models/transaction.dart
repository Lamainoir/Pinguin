class Transaction {
  final int id;
  final String type;
  final double amount;
  final String? recipientPhone;
  final String? merchantName;
  final String? merchantType;
  final DateTime createdAt;
  final String status;
  final String description;

  Transaction({
    required this.id,
    required this.type,
    required this.amount,
    this.recipientPhone,
    this.merchantName,
    this.merchantType,
    required this.createdAt,
    required this.status,
    required this.description,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] ?? 0,
      type: json['type'] ?? '',
      amount: (json['amount'] is num) ? (json['amount'] as num).toDouble() : 0.0,
      recipientPhone: json['recipientPhone'],
      merchantName: json['Merchant']?['name'],
      merchantType: json['Merchant']?['type'],
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      status: json['status'] ?? 'pending',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'amount': amount,
      'recipientPhone': recipientPhone,
      'merchantName': merchantName,
      'merchantType': merchantType,
      'createdAt': createdAt.toIso8601String(),
      'status': status,
      'description': description,
    };
  }
} 