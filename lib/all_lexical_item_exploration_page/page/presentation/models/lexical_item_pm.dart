import 'package:equatable/equatable.dart';
import 'package:mobile_app.home.collections.lexical_item_exploration/all_lexical_item_exploration_page/page/presentation/models/lexical_item_progress_pms/lexical_item_progress_pm.dart';

class LexicalItemPM extends Equatable {
  const LexicalItemPM({
    required this.id,
    required this.title,
    required this.translation,
    required this.progressPM,
    required this.permitted,
  });

  final String id;
  final String title;
  final String translation;
  final LexicalItemProgressPM progressPM;
  final bool permitted;

  @override
  List<Object?> get props {
    return [
      id,
      title,
      translation,
      progressPM,
      permitted,
    ];
  }
}
