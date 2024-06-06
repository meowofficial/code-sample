import 'package:built_collection/built_collection.dart';
import 'package:mobile_app.core/core/domain/services/image_service/service.dart';

part 'result.dart';

abstract class Initialize {
  InitializationResult call();
}

class InitializeImpl implements Initialize {
  const InitializeImpl({
    required ImageService imageService,
  }) : _imageService = imageService;

  final ImageService _imageService;

  @override
  InitializationResult call() {
    final result = InitializationResult(
      cachedImagePathMapStream: _imageService.cachedImagePathMapStream,
    );

    return result;
  }
}
