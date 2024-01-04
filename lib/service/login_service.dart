import 'package:hotel_ayo/helpers/user_info.dart';
import 'package:hotel_ayo/service/user_service.dart';

class LoginService {
  Future<bool> login(String username, String password) async {
    bool isLogin = false;
    List dataUsers = await UserService().getUserRaw();
    List getUser = dataUsers
        .where((e) => e['username'] == username && e['password'] == password)
        .toList();

    if (getUser.isNotEmpty) {
      String image = getUser[0]['avatar'];
      String userId = getUser[0]['id'];
      String userName = getUser[0]['username'];

      await UserInfo.setToken(image);
      await UserInfo().setUserID(userId);
      await UserInfo().setUsername(userName);
      isLogin = true;
    }

    return isLogin;
  }
}
