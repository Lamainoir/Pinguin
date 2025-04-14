import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              title: 'Frequently Asked Questions',
              children: [
                _buildFAQItem(
                  question: 'How do I send money?',
                  answer:
                      'To send money, go to the Send Money screen, enter the recipient\'s phone number, amount, and your PIN. Confirm the transaction to complete.',
                ),
                _buildFAQItem(
                  question: 'How do I pay bills?',
                  answer:
                      'To pay bills, go to the Pay Bill screen, select the bill type, enter the customer number, amount, and your PIN. Confirm the payment to complete.',
                ),
                _buildFAQItem(
                  question: 'What should I do if I forget my PIN?',
                  answer:
                      'If you forget your PIN, you can reset it by going to the Reset PIN screen and following the instructions.',
                ),
                _buildFAQItem(
                  question: 'How do I view my transaction history?',
                  answer:
                      'You can view your transaction history by going to the Transactions screen. All your past transactions will be listed there.',
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Contact Us',
              children: [
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: const Text('Call Us'),
                  subtitle: const Text('+1 234 567 8900'),
                  onTap: () => _launchUrl('tel:+12345678900'),
                ),
                ListTile(
                  leading: const Icon(Icons.email),
                  title: const Text('Email Us'),
                  subtitle: const Text('support@pinguin.com'),
                  onTap: () => _launchUrl('mailto:support@pinguin.com'),
                ),
                ListTile(
                  leading: const Icon(Icons.chat),
                  title: const Text('Live Chat'),
                  subtitle: const Text('Available 24/7'),
                  onTap: () {
                    // TODO: Implement live chat
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Documentation',
              children: [
                ListTile(
                  leading: const Icon(Icons.book),
                  title: const Text('User Guide'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // TODO: Show user guide
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.security),
                  title: const Text('Security Tips'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // TODO: Show security tips
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildFAQItem({
    required String question,
    required String answer,
  }) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Text(answer),
        ),
      ],
    );
  }
} 