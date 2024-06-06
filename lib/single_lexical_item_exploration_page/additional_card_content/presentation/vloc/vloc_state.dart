part of 'vloc.dart';

class AdditionalCardContentVlocState extends Equatable {
  const AdditionalCardContentVlocState({
    required this.scrollViewKey,
    required this.usageExamples,
    required this.allowScrollingToBottom,
    required this.allowScrollingToTop,
  });

  final PageStorageKey<String> scrollViewKey;
  final BuiltList<LexicalItemUsageExample> usageExamples;
  final bool allowScrollingToBottom;
  final bool allowScrollingToTop;

  @override
  List<Object?> get props {
    return [
      scrollViewKey,
      usageExamples,
      allowScrollingToBottom,
      allowScrollingToTop,
    ];
  }

  AdditionalCardContentVlocState copyWith({
    PageStorageKey<String> Function()? scrollViewKey,
    BuiltList<LexicalItemUsageExample> Function()? usageExamples,
    bool Function()? allowScrollingToBottom,
    bool Function()? allowScrollingToTop,
  }) {
    return AdditionalCardContentVlocState(
      scrollViewKey: scrollViewKey == null ? this.scrollViewKey : scrollViewKey(),
      usageExamples: usageExamples == null ? this.usageExamples : usageExamples(),
      allowScrollingToBottom:
          allowScrollingToBottom == null ? this.allowScrollingToBottom : allowScrollingToBottom(),
      allowScrollingToTop:
          allowScrollingToTop == null ? this.allowScrollingToTop : allowScrollingToTop(),
    );
  }
}
