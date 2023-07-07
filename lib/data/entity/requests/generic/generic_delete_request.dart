abstract class GenericDeleteRequest {
  final String path;

  Map<String, dynamic> toQuery();

  GenericDeleteRequest({required this.path});
}
