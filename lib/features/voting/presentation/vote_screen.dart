import 'package:flutter/material.dart';
import 'package:livepoll_politics/core/constants/countries.dart';
import 'package:livepoll_politics/core/models/poll_option.dart';
import 'package:livepoll_politics/core/theme/app_theme.dart';

/// Placeholder Vote screen.
/// Real implementation (with daily limit check + Firebase write) comes in Phase 3.
class VoteScreen extends StatelessWidget {
  final Country country;

  const VoteScreen({super.key, required this.country});

  Color _buttonColorForOption(String id) {
    switch (id) {
      case 'rep':
        return AppTheme.republicanRed;
      case 'dem':
        return AppTheme.democratBlue;
      default:
        return AppTheme.surfaceVariant;
    }
  }

  Color _textColorForOption(String id) {
    switch (id) {
      case 'rep':
      case 'dem':
        return Colors.white;
      default:
        return AppTheme.textPrimary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final poll = country.poll;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cast Your Vote'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Midterm Pulse Check',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              poll.question,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(height: 1.35),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),

            ..._orderedVoteOptions(poll.options).map((option) {
              final bg = _buttonColorForOption(option.id);
              final fg = _textColorForOption(option.id);

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Voting will be enabled once we connect real authentication.'),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: bg,
                    foregroundColor: fg,
                    side: bg == AppTheme.surfaceVariant
                        ? const BorderSide(color: AppTheme.surfaceVariant, width: 1.5)
                        : BorderSide.none,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                  ),
                  child: Text(
                    option.label,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: fg,
                    ),
                  ),
                ),
              );
            }),

            const Spacer(),
            Text(
              'You can vote once per day.\nYour vote is private and final.',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// Republicans first (current government)
  List<PollOption> _orderedVoteOptions(List<PollOption> options) {
    final rep = options.where((o) => o.id == 'rep').toList();
    final dem = options.where((o) => o.id == 'dem').toList();
    final others = options.where((o) => o.id != 'rep' && o.id != 'dem').toList();
    return [...rep, ...dem, ...others];
  }
}
