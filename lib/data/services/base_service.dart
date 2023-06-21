abstract class BaseService {
  final String baseUrl = 'http://192.168.178.164:3000/';

  Future<dynamic> getResponse(String url);
}