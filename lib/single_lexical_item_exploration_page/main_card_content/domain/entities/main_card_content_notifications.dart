import 'package:equatable/equatable.dart';

sealed class MainCardContentNotification {}

class CardActionDialogOpeningNotification extends Equatable implements MainCardContentNotification {
  const CardActionDialogOpeningNotification();

  @override
  List<Object?> get props => [];
}

class AdditionalContentRevealingNotification extends Equatable
    implements MainCardContentNotification {
  const AdditionalContentRevealingNotification();

  @override
  List<Object?> get props => [];
}
