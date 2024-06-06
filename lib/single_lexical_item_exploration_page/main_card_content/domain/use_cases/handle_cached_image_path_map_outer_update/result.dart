part of 'use_case.dart';

class CachedImagePathMapOuterUpdateHandlingResult extends Equatable {
  const CachedImagePathMapOuterUpdateHandlingResult({
    required this.imagePath,
    required this.cachedImagePathMap,
  });

  final String? imagePath;
  final BuiltMap<String, String> cachedImagePathMap;

  @override
  List<Object?> get props {
    return [
      imagePath,
      cachedImagePathMap,
    ];
  }
}
