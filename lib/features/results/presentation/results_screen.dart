import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:livepoll_politics/core/constants/countries.dart';
import 'package:livepoll_politics/core/models/poll_option.dart';
import 'package:livepoll_politics/core/theme/app_theme.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('LivePoll SA'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        children: [
          const SizedBox(height: 12),

          // === SERIOUS POLLING HERO ===
          Container(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.surfaceVariant, width: 1),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: AppTheme.republicanRed,
                        shape: BoxShape.circle,
                      ),
                    ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(duration: 1400.ms),
                    const SizedBox(width: 8),
                    Text(
                      'LIVE  •  NATIONAL POLITICAL PULSE',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: AppTheme.republicanRed,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.4,
                        fontSize: 12.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // South Africa flag - prominent national symbol
                const Text('🇿🇦', style: TextStyle(fontSize: 48)),
                const SizedBox(height: 8),
                Text(
                  'A Daily Pulse of How South Africans Feel Right Now',
                  style: theme.textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  'Real-time participant results • One verified vote per day.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Transparency banner - honest about current state
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: AppTheme.surfaceVariant,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.surfaceVariant, width: 1),
            ),
            child: Column(
              children: [
                Text(
                  'Early Public Experiment',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppTheme.republicanRed,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  'Results shown are currently simulated to demonstrate how the platform will work. Real verified voting (one person, one vote per day) is coming soon.',
                  style: theme.textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // === PROMINENT LOGIN CTA (high contrast, hard to miss) ===
          SizedBox(
            height: 56,
            child: ElevatedButton.icon(
              onPressed: () => context.go('/login'),
              icon: const Icon(Icons.phone_iphone, size: 20),
              label: const Text('Log in with Phone to Vote'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.republicanRed,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Takes 30 seconds. Vote once per day.',
            style: theme.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 28),

          // Country Cards (tap to go to vote screen)
          for (final poll in activePolls) ...[
            _CountryPollCard(
              poll: poll,
              onTap: () => context.go('/vote/${poll.country.code}'),
            ),
            const SizedBox(height: 20),
          ],

          const SizedBox(height: 8),

          // Credibility footer
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: AppTheme.surfaceVariant.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text(
                  'Starting percentages reflect current South African polling averages (demo).',
                  style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 3),
                Text(
                  'Your verified votes will update the live pulse.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CountryPollCard extends StatelessWidget {
  final CountryPoll poll;
  final VoidCallback? onTap;

  const _CountryPollCard({required this.poll, this.onTap});

  double _fakePercentage(String optionId) {
    // Plausible placeholder distribution for current South African politics (demo only).
    switch (optionId) {
      case 'anc':
        return 0.35;
      case 'da':
        return 0.22;
      case 'mk':
        return 0.15;
      case 'eff':
        return 0.12;
      case 'ifp':
        return 0.05;
      case 'pa':
        return 0.04;
      case 'ffp':
        return 0.03;
      case 'other':
        return 0.04;
      default:
        return 0.10;
    }
  }

  Color _colorForOption(String optionId) {
    switch (optionId) {
      case 'anc':
        return const Color(0xFF000000); // ANC black
      case 'da':
        return const Color(0xFF0047AB); // DA blue
      case 'mk':
        return const Color(0xFF006400); // MK green
      case 'eff':
        return const Color(0xFFDC2626); // EFF red
      case 'ifp':
        return const Color(0xFFFFD700); // IFP yellow/gold
      case 'pa':
        return const Color(0xFF8B0000); // PA dark red
      case 'ffp':
        return const Color(0xFFFF6600); // VF+ / FF+ orange
      case 'other':
        return const Color(0xFF6B7280);
      default:
        return AppTheme.primary;
    }
  }

  /// Orders options with ANC first, then other top parties
  List<PollOption> _orderedOptions(List<PollOption> options) {
    final order = ['anc', 'da', 'mk', 'eff', 'ifp', 'pa', 'ffp', 'other'];
    return order.map((id) => options.firstWhere((o) => o.id == id)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header - Big centered national flag + text (much more prominent)
              Center(
                child: Column(
                  children: [
                    // Much larger flag - dynamic per country
                    Text(poll.country.flag, style: const TextStyle(fontSize: 64)),
                    const SizedBox(height: 10),
                    Text(
                      poll.country.displayName,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      poll.question,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textSecondary,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // Today's votes + swings (much more prominent, 4x bigger text, better mobile spacing)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Today's Votes",
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          '4,872',
                          style: const TextStyle(
                            fontSize: 96,
                            fontWeight: FontWeight.w900,
                            height: 1.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Yesterday: 4,350  (+12%)',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textMuted,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      '24h swings',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textMuted,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 20,
                      runSpacing: 4,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'ANC ',
                              style: theme.textTheme.bodyLarge?.copyWith(fontSize: 18),
                            ),
                            Text(
                              '↑ +1.8%',
                              style: const TextStyle(
                                color: Color(0xFF22C55E),
                                fontWeight: FontWeight.w900,
                                fontSize: 56,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'DA ',
                              style: theme.textTheme.bodyLarge?.copyWith(fontSize: 18),
                            ),
                            Text(
                              '↓ -0.9%',
                              style: const TextStyle(
                                color: Color(0xFFEF4444),
                                fontWeight: FontWeight.w900,
                                fontSize: 56,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // Results - ANC first, then other major parties
              // Using current South African polling averages as starting point (demo)
              ..._orderedOptions(poll.options).map((option) {
                final pct = _fakePercentage(option.id);
                final barColor = _colorForOption(option.id);
                final isMajorParty = ['anc', 'da', 'mk', 'eff', 'ifp', 'pa', 'ffp'].contains(option.id);

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 9),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (isMajorParty) ...[
                            Text(
                              '🇿🇦  ',
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                          Expanded(
                            child: Text(
                              option.label,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Text(
                            '${(pct * 100).round()}%',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w900,
                              color: barColor,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 7),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: LinearProgressIndicator(
                          value: pct,
                          backgroundColor: AppTheme.surfaceVariant,
                          color: barColor,
                          minHeight: 11,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ],
                  ),
                );
              }),

              const SizedBox(height: 18),

              // Meta row
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceVariant.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.how_to_vote_outlined, size: 14, color: AppTheme.textMuted),
                        const SizedBox(width: 6),
                        Text(
                          '4,872 votes today',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'LIVE • Updated moments ago',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.republicanRed,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
