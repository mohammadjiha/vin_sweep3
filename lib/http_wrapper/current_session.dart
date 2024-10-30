import '../features/authentication/screens/sigin&register/models/login_response.dart';

class CurrentSession {
  static final CurrentSession _shared = CurrentSession._private();

  factory CurrentSession() => _shared;

  CurrentSession._private();

  ApiUser? _apiUser;
  String? _accessToken;

  void setApiUser(ApiUser model) {
    _apiUser = model;
  }

  ApiUser? getApiUser() {
    if (isAuth()) return _apiUser;
    return null;
  }

  bool isAuth() => _apiUser != null;

  void setAccessToken(String token) {
    _accessToken = token;
  }

  String? getAccessToken() {
    return _accessToken;
  }

  bool hasAccessToken() => _accessToken != null;
}
