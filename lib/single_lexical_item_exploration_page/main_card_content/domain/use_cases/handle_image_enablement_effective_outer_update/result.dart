part of 'use_case.dart';

class ImageEnablementEffectiveOuterUpdateHandlingResult extends Equatable {
  const ImageEnablementEffectiveOuterUpdateHandlingResult({
    required this.imagePath,
    required this.imageEnablementEffective,
  });

  final String? imagePath;
  final bool imageEnablementEffective;

  @override
  List<Object?> get props {
    return [
      imagePath,
      imageEnablementEffective,
    ];
  }
}
