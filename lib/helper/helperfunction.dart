import 'package:shared_preferences/shared_preferences.dart';


class  HelperFunction{

  static String sharedPreferenceuserloggedinkey = "ISLOGGEDIN";
  static String sharedPreferenceusernamekey = "USERNAMEKEY";
  static String sharedPreferenceuseremailkey = "USEREMAILKEY";

  static Future<bool>saveuserloggedinsharedpreference (bool isuserloggedin)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferenceuserloggedinkey, isuserloggedin);
  }
  static Future<bool>saveuserusernamesharedpreference (String usernamekey)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceusernamekey, usernamekey);
  }
  static Future<bool>saveuseremailsharedpreference (String useremailkey)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceuseremailkey, useremailkey);
  }

  static Future<bool>getuserloggedinsharedpreference ()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return  prefs.getBool(sharedPreferenceuserloggedinkey);
  }
  static Future<String>getuserusernamesharedpreference ()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return  prefs.getString(sharedPreferenceusernamekey);
  }
  static Future<String>getuseremailsharedpreference ()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceuseremailkey);
  }

}
