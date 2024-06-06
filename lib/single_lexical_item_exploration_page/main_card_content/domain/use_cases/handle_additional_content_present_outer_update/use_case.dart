import 'package:equatable/equatable.dart';

part 'result.dart';

abstract class HandleAdditionalContentPresentOuterUpdate {
  AdditionalContentPresentOuterUpdateHandlingResult call({
    required bool additionalContentPresent,
  });
}

class HandleAdditionalContentPresentOuterUpdateImpl
    implements HandleAdditionalContentPresentOuterUpdate {
  const HandleAdditionalContentPresentOuterUpdateImpl();

  @override
  AdditionalContentPresentOuterUpdateHandlingResult call({
    required bool additionalContentPresent,
  }) {
    final result = AdditionalContentPresentOuterUpdateHandlingResult(
      additionalContentPresent: additionalContentPresent,
    );

    return result;
  }
}
