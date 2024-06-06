import 'package:mobile_app.core/core/domain/services/tts_service/service.dart';

abstract class PronounceLexicalItem {
  void call({
    required String lexicalItemTitle,
  });
}

class PronounceLexicalItemImpl implements PronounceLexicalItem {
  const PronounceLexicalItemImpl({
    required TtsService ttsService,
  }) : _ttsService = ttsService;

  final TtsService _ttsService;

  @override
  void call({
    required String lexicalItemTitle,
  }) {
    _ttsService.speak(lexicalItemTitle);
  }
}
