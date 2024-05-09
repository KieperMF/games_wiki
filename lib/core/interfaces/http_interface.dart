abstract interface class HttpInterface{
  Future<dynamic> getData({required String path, Map<String, dynamic>? queryParam});
  /*Future<dynamic> update();
  Future<dynamic> delete();
  Future<dynamic> post();*/
} 