class CheckWordsResponse {
  final bool is4LettersWordsEmpty;
  final bool is5LettersWordsEmpty;
  final bool is6LettersWordsEmpty;

  CheckWordsResponse({
    required this.is4LettersWordsEmpty,
    required this.is5LettersWordsEmpty,
    required this.is6LettersWordsEmpty,
  });
}
