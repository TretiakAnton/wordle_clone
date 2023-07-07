abstract class GenericGetRequest {
  final String path;

  Map<String, dynamic> toJson();

  GenericGetRequest({required this.path});
}
