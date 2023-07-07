abstract class GenericPatchRequest {
  final String path;

  Map<String, dynamic> toJson();

  GenericPatchRequest({required this.path});
}
