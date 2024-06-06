part of 'use_case.dart';

class AdditionalContentClosingResult extends Equatable {
  const AdditionalContentClosingResult({
    required this.flowCompleted,
    required this.notification,
  });

  final bool flowCompleted;
  final AdditionalCardContentNotification notification;

  @override
  List<Object?> get props {
    return [
      flowCompleted,
      notification,
    ];
  }
}
