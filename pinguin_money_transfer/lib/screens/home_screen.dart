import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pinguin_money_transfer/providers/auth_provider.dart';
import 'package:pinguin_money_transfer/screens/send_money_screen.dart';
import 'package:pinguin_money_transfer/screens/pay_bill_screen.dart';
import 'package:pinguin_money_transfer/screens/transaction_screen.dart';
import 'package:pinguin_money_transfer/screens/profile_screen.dart';
import 'package:pinguin_money_transfer/screens/settings_screen.dart';
import 'package:pinguin_money_transfer/screens/help_screen.dart';
import 'package:pinguin_money_transfer/utils/responsive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    final user = Provider.of<AuthProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pinguin Money Transfer',
          style: TextStyle(
            fontSize: Responsive.getResponsiveFontSize(18),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
          IconButton(
            icon: const Icon(Icons.help),
            onPressed: () => Navigator.pushNamed(context, '/help'),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: Responsive.getPadding(horizontal: 4, vertical: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section
              Container(
                width: double.infinity,
                padding: Responsive.getPadding(horizontal: 4, vertical: 3),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: Responsive.getBorderRadius(radius: 3),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome, ${user?.name ?? 'User'}!',
                      style: TextStyle(
                        fontSize: Responsive.getResponsiveFontSize(24),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: Responsive.blockSizeVertical),
                    Text(
                      'Available Balance',
                      style: TextStyle(
                        fontSize: Responsive.getResponsiveFontSize(16),
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      '\$${user?.balance.toStringAsFixed(2) ?? '0.00'}',
                      style: TextStyle(
                        fontSize: Responsive.getResponsiveFontSize(32),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Responsive.blockSizeVertical * 3),

              // Menu Grid
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: Responsive.isMobile(context) ? 2 : 4,
                mainAxisSpacing: Responsive.blockSizeVertical * 2,
                crossAxisSpacing: Responsive.blockSizeHorizontal * 2,
                children: [
                  _buildMenuCard(
                    context,
                    'Send Money',
                    Icons.send,
                    () => Navigator.pushNamed(context, '/send-money'),
                  ),
                  _buildMenuCard(
                    context,
                    'Pay Bill',
                    Icons.receipt,
                    () => Navigator.pushNamed(context, '/pay-bill'),
                  ),
                  _buildMenuCard(
                    context,
                    'Transactions',
                    Icons.history,
                    () => Navigator.pushNamed(context, '/transactions'),
                  ),
                  _buildMenuCard(
                    context,
                    'Profile',
                    Icons.person,
                    () => Navigator.pushNamed(context, '/profile'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: Responsive.getBorderRadius(radius: 2),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: Responsive.getBorderRadius(radius: 2),
        child: Padding(
          padding: Responsive.getPadding(horizontal: 2, vertical: 3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: Responsive.getResponsiveFontSize(32),
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(height: Responsive.blockSizeVertical),
              Text(
                title,
                style: TextStyle(
                  fontSize: Responsive.getResponsiveFontSize(14),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
} 