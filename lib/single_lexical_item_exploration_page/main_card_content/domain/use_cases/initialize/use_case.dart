import 'package:built_collection/built_collection.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/lexical_item/lexical_item.dart';
import 'package:mobile_app.core/core/domain/helpers/maybe_start_lexical_item_image_download/helper.dart';

part 'result.dart';

abstract class Initialize {
  void call({
    required LexicalItem lexicalItem,
  });
}

class InitializeImpl implements Initialize {
  const InitializeImpl({
    required MaybeStartLexicalItemImageDownload maybeStartLexicalItemImageDownload,
  }) : _maybeStartLexicalItemImageDownload = maybeStartLexicalItemImageDownload;

  final MaybeStartLexicalItemImageDownload _maybeStartLexicalItemImageDownload;

  @override
  void call({
    required LexicalItem lexicalItem,
  }) {
    _maybeStartLexicalItemImageDownload(
      lexicalItem: lexicalItem,
    );
  }
}
