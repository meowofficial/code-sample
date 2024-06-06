import 'package:equatable/equatable.dart';

sealed class AdditionalCardContentNotification {}

class AdditionalContentClosingNotification extends Equatable
    implements AdditionalCardContentNotification {
  const AdditionalContentClosingNotification();

  @override
  List<Object?> get props => [];
}
