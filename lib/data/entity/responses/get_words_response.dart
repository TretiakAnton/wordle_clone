class GetWordsResponse {
  final List<String> words;

  GetWordsResponse({required this.words});

  factory GetWordsResponse.fromJson(List<dynamic> json) {
    return GetWordsResponse(
      words: json.map((word) => word['word'].toString()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'words': words,
    };
  }
}
