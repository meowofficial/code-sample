part of 'use_case.dart';

class PremiumAccessStatusOuterUpdateHandlingResult extends Equatable {
  const PremiumAccessStatusOuterUpdateHandlingResult({
    required this.permittedLexicalItemIds,
  });

  final BuiltSet<String> permittedLexicalItemIds;

  @override
  List<Object?> get props {
    return [
      permittedLexicalItemIds,
    ];
  }
}
