part of 'use_case.dart';

class InitializationResult {
  const InitializationResult({
    required this.cachedImagePathMapStream,
  });

  final Stream<BuiltMap<String, String>> cachedImagePathMapStream;
}