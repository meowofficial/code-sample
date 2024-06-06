part of 'lexical_item_progress_pm.dart';

class LearningLexicalItemProgressPM extends Equatable implements LexicalItemProgressPM {
  const LearningLexicalItemProgressPM({
    required this.progressPercent,
  });

  final int progressPercent;

  @override
  List<Object?> get props {
    return [
      progressPercent,
    ];
  }
}
