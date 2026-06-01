import '../models/poll_option.dart';

/// This version of LivePoll is focused exclusively on the United States.
enum Country {
  unitedStates('us', 'United States', '🇺🇸');

  const Country(this.code, this.displayName, this.flag);

  final String code;
  final String displayName;
  final String flag;
}

class CountryPoll {
  final Country country;
  final String question;
  final List<PollOption> options;

  const CountryPoll({
    required this.country,
    required this.question,
    required this.options,
  });
}

/// Current USA-focused poll.
/// Tailored for the current political moment (midterms / 2026 cycle).
final List<CountryPoll> activePolls = [
  CountryPoll(
    country: Country.unitedStates,
    question: 'If the midterm elections were held today, which party would you support?',
    options: const [
      PollOption(id: 'rep', label: 'Republican Party'),
      PollOption(id: 'dem', label: 'Democratic Party'),
      PollOption(id: 'ind', label: 'Independent / Other'),
      PollOption(id: 'undecided', label: 'Undecided'),
    ],
  ),
];

extension CountryX on Country {
  CountryPoll get poll => activePolls.firstWhere((p) => p.country == this);
}
