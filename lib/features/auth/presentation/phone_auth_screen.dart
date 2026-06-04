import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:livepoll_politics/core/theme/app_theme.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  String _phoneNumber = '';
  bool _codeSent = false;
  final TextEditingController _codeController = TextEditingController();
  final FocusNode _codeFocusNode = FocusNode();

  @override
  void dispose() {
    _codeController.dispose();
    _codeFocusNode.dispose();
    super.dispose();
  }

  void _sendCode() {
    if (_phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a phone number first')),
      );
      return;
    }

    setState(() {
      _codeSent = true;
      _codeController.clear();
    });

    // Show brief confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Code sent (demo)'),
        duration: Duration(seconds: 2),
      ),
    );

    // Auto-focus the code field after the rebuild
    Future.delayed(const Duration(milliseconds: 150), () {
      if (mounted) {
        _codeFocusNode.requestFocus();
      }
    });
  }

  void _verifyCode() {
    final code = _codeController.text.trim();

    if (code.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a 6-digit code')),
      );
      return;
    }

    // Demo: accept any 6-digit code
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Phone verified! You can now cast your vote.')),
    );

    // Send user to the SA vote screen (use push so back navigation works)
    context.push('/vote/sa');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Sign in to Vote')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
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

              if (!_codeSent) ...[
                // Step 1: Phone number
                IntlPhoneField(
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                  initialCountryCode: 'ZA',
                  onChanged: (phone) {
                    setState(() {
                      _phoneNumber = phone.completeNumber;
                    });
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _phoneNumber.isNotEmpty ? _sendCode : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.republicanRed,
                  ),
                  child: const Text('Send Verification Code'),
                ),
              ] else ...[
                // Step 2: Verification code - very obvious for demo
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        '✓ CODE SENT (DEMO)',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Verification code sent to $_phoneNumber',
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'For this demo, enter any 6 digits (example: 123456)',
                        style: TextStyle(color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                TextField(
                  controller: _codeController,
                  focusNode: _codeFocusNode,
                  decoration: const InputDecoration(
                    labelText: '6-digit code',
                    hintText: 'e.g. 123456',
                    border: OutlineInputBorder(),
                    counterText: '',
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 32, letterSpacing: 16, height: 1.1),
                ),
                const SizedBox(height: 8),
                const Text(
                  'DEMO: any 6 digits accepted — try 123456',
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 16),

                ElevatedButton(
                  onPressed: _verifyCode,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.republicanRed,
                  ),
                  child: const Text('Verify Code (demo)'),
                ),

                const SizedBox(height: 12),

                TextButton(
                  onPressed: () {
                    setState(() {
                      _codeSent = false;
                      _phoneNumber = '';
                      _codeController.clear();
                    });
                  },
                  child: const Text('Use a different number'),
                ),
              ],

              const SizedBox(height: 36),
              Text(
                'Secure • Private • One vote per verified number',
                style: theme.textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
