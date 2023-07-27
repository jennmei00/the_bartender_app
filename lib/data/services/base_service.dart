abstract class BaseService {
  final String baseUrl = 'http://192.168.178.164:3000/'; //  /192.168.178.164 => PC *.95 => Laptop

  Future<dynamic> getResponse(String url);
}