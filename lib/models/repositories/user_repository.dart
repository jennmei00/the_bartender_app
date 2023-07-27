import 'package:the_bartender_app/data/services/base_service.dart';
import 'package:the_bartender_app/data/services/general_service.dart';
import 'package:the_bartender_app/models/user.dart';

class UserRepository {
  final BaseService _userService = GeneralService();

  Future<User?> fetchData(String username, String password) async {
    dynamic response = await _userService
        .getResponse('user?username=eq.$username&password=eq.$password');
    final List<dynamic> jsonData = response;
    User? user = jsonData.isNotEmpty ? User.fromMap(jsonData[0]) : null;
    return user;
  }
}
