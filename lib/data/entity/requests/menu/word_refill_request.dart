class WordRefillRequest {
  final bool is4letterWordsNeedRefill;
  final bool is5letterWordsNeedRefill;
  final bool is6letterWordsNeedRefill;

  WordRefillRequest({
    required this.is4letterWordsNeedRefill,
    required this.is5letterWordsNeedRefill,
    required this.is6letterWordsNeedRefill,
  });
}
