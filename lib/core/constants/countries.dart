import '../models/poll_option.dart';

/// South Africa focused version of LivePoll.
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

/// Current South Africa poll.
/// Top parties including FF+ / VF+ as requested. ANC first per UI order.
final List<CountryPoll> activePolls = [
  CountryPoll(
    country: Country.southAfrica,
    question: 'If national elections were held today, which party would you support?',
    options: const [
      PollOption(id: 'anc', label: 'African National Congress (ANC)'),
      PollOption(id: 'da', label: 'Democratic Alliance (DA)'),
      PollOption(id: 'mk', label: 'uMkhonto weSizwe (MK)'),
      PollOption(id: 'eff', label: 'Economic Freedom Fighters (EFF)'),
      PollOption(id: 'ifp', label: 'Inkatha Freedom Party (IFP)'),
      PollOption(id: 'pa', label: 'Patriotic Alliance (PA)'),
      PollOption(id: 'ffp', label: 'Freedom Front Plus (VF+)'),
      PollOption(id: 'other', label: 'Other / Undecided'),
    ],
  ),
];

extension CountryX on Country {
  CountryPoll get poll => activePolls.firstWhere((p) => p.country == this);
}
