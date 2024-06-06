part of 'use_case.dart';

class DialectOuterUpdateHandlingResult extends Equatable {
  const DialectOuterUpdateHandlingResult({
    required this.dialect,
    required this.safeToPronounce,
  });

  final Dialect dialect;
  final bool safeToPronounce;

  @override
  List<Object?> get props {
    return [
      dialect,
      safeToPronounce,
    ];
  }
}
