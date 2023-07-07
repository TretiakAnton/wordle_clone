abstract class GenericPostRequest{
  final String path;

  Map<String, dynamic> toJson();

  GenericPostRequest({required this.path});
}