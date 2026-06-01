import 'package:flutter/foundation.dart';

@immutable
class PollOption {
  final String id;
  final String label;

  const PollOption({
    required this.id,
    required this.label,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PollOption &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
