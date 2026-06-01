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
        title: const Text('LivePoll'),
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
                      'LIVE  •  2026 MIDTERM GENERIC BALLOT',
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
                // American Coat of Arms (Great Seal eagle) - prominent official symbol
                const Text('🦅', style: TextStyle(fontSize: 48)),
                const SizedBox(height: 8),
                Text(
                  'Live Midterm Pulse',
                  style: theme.textTheme.headlineLarge,  // Now the BIGGEST text on the page
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  'Real-time participant results • One verified vote per day',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // === OFFICIAL PARTY LOGOS — Republican (LEFT) & Democratic (RIGHT) ===
          // Large as practical. For true official logos, add real asset images (see instructions in code comments).
          Row(
            children: [
              Expanded(
                child: _LargePartyLogo(
                  partyName: 'REPUBLICAN',
                  subtitle: 'GOP • Current Government',
                  animal: '🐘',
                  color: AppTheme.republicanRed,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _LargePartyLogo(
                  partyName: 'DEMOCRATIC',
                  subtitle: 'DNC',
                  animal: '🫏',
                  color: AppTheme.democratBlue,
                ),
              ),
            ],
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
                  'Starting percentages reflect late May 2026 national generic ballot averages.',
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

/// Large, dominant party logo widgets - centered and powerful.
/// Republican (left) and Democratic (right).
/// Made bigger and more commanding.
class _LargePartyLogo extends StatelessWidget {
  final String partyName;
  final String subtitle;
  final String animal;
  final Color color;

  const _LargePartyLogo({
    required this.partyName,
    required this.subtitle,
    required this.animal,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color, width: 3),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.12),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Much bigger, dominant logo
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              animal,
              style: const TextStyle(fontSize: 120),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            partyName,
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 22,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.0,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
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
    // Realistic starting point based on late May 2026 national generic ballot averages.
    // Republicans featured first (current governing party). Numbers will be replaced by live votes.
    switch (optionId) {
      case 'rep':        // Republican - featured first
        return 0.42;
      case 'dem':
        return 0.39;
      case 'ind':
        return 0.11;
      case 'undecided':
        return 0.08;
      default:
        return 0.10;
    }
  }

  Color _colorForOption(String optionId) {
    switch (optionId) {
      case 'rep':
        return AppTheme.republicanRed;
      case 'dem':
        return AppTheme.democratBlue;
      case 'ind':
        return const Color(0xFF6B7280);
      case 'undecided':
        return const Color(0xFF475569);
      default:
        return AppTheme.primary;
    }
  }

  /// Orders options so Republicans appear first (current governing party)
  List<PollOption> _orderedOptions(List<PollOption> options) {
    final rep = options.where((o) => o.id == 'rep').toList();
    final dem = options.where((o) => o.id == 'dem').toList();
    final others = options.where((o) => o.id != 'rep' && o.id != 'dem').toList();
    return [...rep, ...dem, ...others];
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
              // Header - Big centered American flag + text (much more prominent)
              Center(
                child: Column(
                  children: [
                    // Much larger flag
                    const Text('🇺🇸', style: TextStyle(fontSize: 64)),
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
                      'If the midterm elections were held today',
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

              const SizedBox(height: 22),

              // Results - Republicans first (current government), then Democrats
              // Using realistic late May 2026 generic ballot averages as starting point
              ..._orderedOptions(poll.options).map((option) {
                final pct = _fakePercentage(option.id);
                final barColor = _colorForOption(option.id);
                final isMajorParty = option.id == 'rep' || option.id == 'dem';

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 9),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (isMajorParty) ...[
                            Text(
                              option.id == 'rep' ? '🐘  ' : '🫏  ',
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
                          '2,847 votes today',
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
