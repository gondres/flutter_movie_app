class RepositoriesResponse {
  final bool isSuccess;
  final dynamic dataResponse;
  final int statusCode;

  RepositoriesResponse(
      {required this.isSuccess,
      required this.dataResponse,
      required this.statusCode});
}
