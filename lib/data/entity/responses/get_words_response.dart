class GetWordsResponse {
  final List<String> words;

  GetWordsResponse({required this.words});

  factory GetWordsResponse.fromJson(List<dynamic> json) {
    final List<String> words = List<String>.from(json);
    return GetWordsResponse(words: words);
  }

  Map<String, dynamic> toJson() {
    return {
      'words': words,
    };
  }
}
