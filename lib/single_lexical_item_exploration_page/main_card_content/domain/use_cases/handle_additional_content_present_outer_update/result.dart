part of 'use_case.dart';

class AdditionalContentPresentOuterUpdateHandlingResult extends Equatable {
  const AdditionalContentPresentOuterUpdateHandlingResult({
    required this.additionalContentPresent,
  });

  final bool additionalContentPresent;

  @override
  List<Object?> get props {
    return [
      additionalContentPresent,
    ];
  }
}
