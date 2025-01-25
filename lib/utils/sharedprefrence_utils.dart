import 'dart:convert';

import 'package:my_project/data_models/login_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SharedPreferenceUtill {
  static const String login_response = 'login_response';
  static const String domain_url = 'domain_url';

  static setDomainUrl(String url)async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
        domain_url, url);
  }

  static Future<String?> getDomainUrl() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(domain_url);
  }

  static setLoginResponse(LoginDataModel loginDataModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
        login_response, json.encode(loginDataModel));
  }

  static Future<LoginDataModel?> getLoginResponse() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return  pref.getString(login_response)!= null ? LoginDataModel.fromJson(jsonDecode(pref.getString(login_response)!)) : null;
  }

  Future<void> clearLogin() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }

}
