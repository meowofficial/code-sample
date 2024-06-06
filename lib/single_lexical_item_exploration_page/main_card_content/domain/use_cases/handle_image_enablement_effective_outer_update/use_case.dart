import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/lexical_item/lexical_item.dart';
import 'package:mobile_app.core/core/domain/helpers/get_lexical_item_effective_image_path/helper.dart';

part 'result.dart';

abstract class HandleImageEnablementEffectiveOuterUpdate {
  ImageEnablementEffectiveOuterUpdateHandlingResult call({
    required LexicalItem lexicalItem,
    required BuiltMap<String, String> cachedImagePathMap,
    required bool imageEnablementEffective,
  });
}

class HandleImageEnablementEffectiveOuterUpdateImpl
    implements HandleImageEnablementEffectiveOuterUpdate {
  const HandleImageEnablementEffectiveOuterUpdateImpl({
    required GetLexicalItemEffectiveImagePath getLexicalItemEffectiveImagePath,
  }) : _getLexicalItemEffectiveImagePath = getLexicalItemEffectiveImagePath;

  final GetLexicalItemEffectiveImagePath _getLexicalItemEffectiveImagePath;

  @override
  ImageEnablementEffectiveOuterUpdateHandlingResult call({
    required LexicalItem lexicalItem,
    required BuiltMap<String, String> cachedImagePathMap,
    required bool imageEnablementEffective,
  }) {
    final imagePath = _getLexicalItemEffectiveImagePath(
      lexicalItem: lexicalItem,
      cachedImagePathMap: cachedImagePathMap,
      imageEnablementEffective: imageEnablementEffective,
    );

    final result = ImageEnablementEffectiveOuterUpdateHandlingResult(
      imagePath: imagePath,
      imageEnablementEffective: imageEnablementEffective,
    );

    return result;
  }
}
