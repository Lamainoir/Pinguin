import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/transaction.dart';
import 'providers/auth_provider.dart';
import 'providers/transaction_provider.dart';
import 'services/auth_service.dart';
import 'services/transaction_service.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/send_money_screen.dart';
import 'screens/pay_bill_screen.dart';
import 'screens/transaction_screen.dart';
import 'screens/transaction_detail_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/help_screen.dart';
import 'screens/reset_pin_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({Key? key, required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(AuthService(prefs)),
        ),
        ChangeNotifierProvider(
          create: (_) => TransactionProvider(TransactionService(prefs)),
        ),
      ],
      child: MaterialApp(
        title: 'Pinguin Money Transfer',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
          fontFamily: 'Roboto',
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: const TextTheme(
            displayLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            displayMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            displaySmall: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            bodyLarge: TextStyle(fontSize: 16.0),
            bodyMedium: TextStyle(fontSize: 14.0),
            bodySmall: TextStyle(fontSize: 12.0),
          ),
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/home': (context) => const HomeScreen(),
          '/send-money': (context) => const SendMoneyScreen(),
          '/pay-bill': (context) => const PayBillScreen(),
          '/transactions': (context) => const TransactionScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/settings': (context) => const SettingsScreen(),
          '/help': (context) => const HelpScreen(),
          '/reset-pin': (context) => const ResetPinScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/transaction-detail') {
            final transaction = settings.arguments as Transaction;
            return MaterialPageRoute(
              builder: (context) => TransactionDetailScreen(
                transaction: transaction,
              ),
            );
          }
          return null;
        },
      ),
    );
  }
}
