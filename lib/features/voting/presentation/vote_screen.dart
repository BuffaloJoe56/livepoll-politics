import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
      case 'anc':
        return const Color(0xFF000000); // ANC
      case 'da':
        return const Color(0xFF0047AB); // DA
      case 'mk':
        return const Color(0xFF006400); // MK
      case 'eff':
        return const Color(0xFFDC2626); // EFF
      case 'ifp':
        return const Color(0xFFFFD700); // IFP
      case 'pa':
        return const Color(0xFF8B0000); // PA
      case 'ffp':
        return const Color(0xFFFF6600); // VF+ / FF+ orange
      default:
        return AppTheme.surfaceVariant;
    }
  }

  Color _textColorForOption(String id) {
    switch (id) {
      case 'anc':
      case 'da':
      case 'mk':
      case 'eff':
      case 'ifp':
      case 'pa':
      case 'ffp':
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
              'National Pulse Check',
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
                padding: const EdgeInsets.only(bottom: 16),
                child: OutlinedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Vote Recorded (Demo)'),
                        content: Text(
                          'Thank you. In this early demo your choice has been noted.\n\n'
                          'When real verified voting launches, you will only be able to vote once per day.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // close dialog
                              context.go('/'); // always go back to main results page
                            },
                            child: const Text('Back to Results'),
                          ),
                        ],
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: bg,
                    foregroundColor: fg,
                    side: bg == AppTheme.surfaceVariant
                        ? const BorderSide(color: AppTheme.surfaceVariant, width: 1.5)
                        : BorderSide.none,
                    padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _abbrForOption(option.id),
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          color: fg,
                          height: 1.0,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        option.label,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: fg,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }),

            const Spacer(),
            Text(
              'This is a demo.\nReal one-vote-per-day verification coming soon.',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// ANC first, then top parties
  List<PollOption> _orderedVoteOptions(List<PollOption> options) {
    final order = ['anc', 'da', 'mk', 'eff', 'ifp', 'pa', 'ffp', 'other'];
    return order.map((id) => options.firstWhere((o) => o.id == id)).toList();
  }

  String _abbrForOption(String id) {
    switch (id) {
      case 'anc': return 'ANC';
      case 'da': return 'DA';
      case 'mk': return 'MK';
      case 'eff': return 'EFF';
      case 'ifp': return 'IFP';
      case 'pa': return 'PA';
      case 'ffp': return 'VF+';
      default: return 'OTHER';
    }
  }
}
