import 'package:mobile_app.core/core/domain/entities/learning_content/lexical_item/lexical_item.dart';
import 'package:mobile_app.core/core/domain/helpers/get_lexical_item_usage_example_title/helper.dart';
import 'package:mobile_app.core/core/domain/services/tts_service/service.dart';

abstract class PronounceLexicalItemUsageExample {
  void call({
    required LexicalItemUsageExample usageExample,
  });
}

class PronounceLexicalItemUsageExampleImpl implements PronounceLexicalItemUsageExample {
  const PronounceLexicalItemUsageExampleImpl({
    required GetLexicalItemUsageExampleTitle getLexicalItemUsageExampleTitle,
    required TtsService ttsService,
  })  : _getLexicalItemUsageExampleTitle = getLexicalItemUsageExampleTitle,
        _ttsService = ttsService;

  final GetLexicalItemUsageExampleTitle _getLexicalItemUsageExampleTitle;
  final TtsService _ttsService;

  @override
  void call({
    required LexicalItemUsageExample usageExample,
  }) {
    final usageExampleTitle = _getLexicalItemUsageExampleTitle(
      usageExample: usageExample,
    );

    _ttsService.speak(usageExampleTitle);
  }
}
