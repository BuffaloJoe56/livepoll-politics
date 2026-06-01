import 'package:flutter/material.dart';
import 'package:livepoll_politics/core/theme/app_theme.dart';

class PhoneAuthScreen extends StatelessWidget {
  const PhoneAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Sign in to Vote')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 32),
            Text(
              'One verified vote per day.',
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Your phone number is used only for verification.\nWe never share it or use it for anything else.',
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // Placeholder for real phone input (intl_phone_field will be added next)
            TextField(
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                hintText: '+1 (202) 555-0142',
                prefixIcon: Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () {
                // TODO: Implement real Firebase Phone Auth
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Phone auth coming in next phase')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.republicanRed,
              ),
              child: const Text('Send Verification Code'),
            ),

            const SizedBox(height: 36),
            Text(
              'Secure • Private • One vote per verified number',
              style: theme.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
