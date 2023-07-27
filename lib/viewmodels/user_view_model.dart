import 'package:flutter/material.dart';
import 'package:the_bartender_app/data/api/api_response.dart';
import 'package:the_bartender_app/models/repositories/user_repository.dart';
import 'package:the_bartender_app/models/user.dart';

class UserViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');

  User? _user;

  ApiResponse get response {
    return _apiResponse;
  }

  User? get user {
    return _user;
  }

  //* Call the user service and gets the data of requested user
  Future<User?> fetchData(String username, String password) async {
    _apiResponse = ApiResponse.loading('Fetching recipe data');
    notifyListeners();
    try {
      User? user = await UserRepository().fetchData(username, password);
      setSelectedUser(user);
      _apiResponse = ApiResponse.completed(user);
      notifyListeners();
      return user;
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
      notifyListeners();
      return null;
    }
  }

  void setSelectedUser(User? user) {
    _user = user;
  }
}
