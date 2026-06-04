import '../models/poll_option.dart';

/// This version of LivePoll is focused on South Africa.
enum Country {
  southAfrica('za', 'South Africa', '🇿🇦');

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

/// Current South Africa-focused poll.
/// Tailored for current political sentiment (post-2024 elections).
final List<CountryPoll> activePolls = [
  CountryPoll(
    country: Country.southAfrica,
    question: 'If national elections were held today, which party would you support?',
    options: const [
      PollOption(id: 'anc', label: 'ANC'),
      PollOption(id: 'da', label: 'Democratic Alliance (DA)'),
      PollOption(id: 'mk', label: 'MK Party'),
      PollOption(id: 'eff', label: 'EFF'),
      PollOption(id: 'ifp', label: 'IFP'),
      PollOption(id: 'pa', label: 'Patriotic Alliance (PA)'),
      PollOption(id: 'ffp', label: 'VF+ (Freedom Front Plus)'),
      PollOption(id: 'other', label: 'Other / Undecided'),
    ],
  ),
];

extension CountryX on Country {
  CountryPoll get poll => activePolls.firstWhere((p) => p.country == this);
}
