part of 'use_case.dart';

class AdditionalContentRevealingResult extends Equatable {
  const AdditionalContentRevealingResult({
    required this.flowCompleted,
    required this.notification,
  });

  final bool flowCompleted;
  final MainCardContentNotification notification;

  @override
  List<Object?> get props {
    return [
      flowCompleted,
      notification,
    ];
  }
}
