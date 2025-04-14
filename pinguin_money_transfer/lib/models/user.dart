class User {
  final int id;
  final String name;
  final String email;
  final String phoneNumber;
  final double balance;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.balance,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    print('Creating User from JSON: $json');
    
    // Vérification des types
    final id = json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '0') ?? 0;
    final name = json['name']?.toString() ?? '';
    final email = json['email']?.toString() ?? '';
    final phone = json['phone']?.toString() ?? '';
    
    // Gestion spéciale pour le solde
    double balance;
    if (json['balance'] is num) {
      balance = (json['balance'] as num).toDouble();
    } else {
      balance = double.tryParse(json['balance']?.toString() ?? '0.00') ?? 0.0;
    }

    return User(
      id: id,
      name: name,
      email: email,
      phoneNumber: phone,
      balance: balance,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'balance': balance,
    };
  }
} 