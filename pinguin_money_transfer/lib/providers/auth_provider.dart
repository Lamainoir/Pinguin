import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  final AuthService _authService;
  bool _isLoading = false;

  AuthProvider(this._authService);

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;

  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String pin,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      _user = await _authService.register(
        name: name,
        email: email,
        phone: phone,
        password: password,
        pin: pin,
      );
    } catch (e) {
      rethrow;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> login({
    required String phoneNumber,
    required String pin,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      print('Attempting login with phone: $phoneNumber');
      _user = await _authService.login(
        phoneNumber: phoneNumber,
        pin: pin,
      );
      print('Login successful, user: $_user');
      notifyListeners();
    } catch (e) {
      print('Login error in provider: $e');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    _user = null;
    notifyListeners();
  }

  Future<void> checkAuthStatus() async {
    try {
      final token = await _authService.getToken();
      if (token != null) {
        // TODO: Implement token validation and user data fetching
        // For now, we'll just set a dummy user
        _user = User(
          id: 1,
          name: 'Test User',
          email: 'test@example.com',
          phoneNumber: '+1234567890',
          balance: 1000.0,
        );
        notifyListeners();
      }
    } catch (e) {
      _user = null;
      notifyListeners();
    }
  }

  Future<void> updateProfile(String name, String email) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Implémenter la mise à jour du profil
      // _user = await _authService.updateProfile(name, email);
    } catch (e) {
      // Gérer l'erreur
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> changePin(String oldPin, String newPin) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Implémenter le changement de PIN
      // await _authService.changePin(oldPin, newPin);
    } catch (e) {
      // Gérer l'erreur
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> resetPin(String phoneNumber, String newPin) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Implémenter la réinitialisation du PIN
      // await _authService.resetPin(phoneNumber, newPin);
    } catch (e) {
      // Gérer l'erreur
    }

    _isLoading = false;
    notifyListeners();
  }
} 