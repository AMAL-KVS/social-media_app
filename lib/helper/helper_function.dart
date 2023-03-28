// import 'package:shared_preferences/shared_preferences.dart';

// class HelperFunction {
//   static String userLogedInkey = "LOGED IN KEY";

//   static String userNameKey = "USER NAME KEY";
//   static String userEmailKey = "USEREMAILKEY";

//   static Future<bool> saveUserLogedInStus(bool userLogedIn) async {
//     SharedPreferences sf = await SharedPreferences.getInstance();
//     return sf.setBool(userLogedInkey, userLogedIn);
//   }

//   static Future<bool> saveUserNameSf(String userName) async {
//     SharedPreferences sf = await SharedPreferences.getInstance();
//     return sf.setString(userNameKey, userName);
//   }

//   static Future<bool> saveUserEmailSf(String userEmail) async {
//     SharedPreferences sf = await SharedPreferences.getInstance();
//     return sf.setString(userEmailKey, userEmail);
//   }

//   static Future<bool?> getUserLogInStus() async {
//     SharedPreferences sf = await SharedPreferences.getInstance();
//     return sf.getBool(userLogedInkey);
//   }

//   static Future<String?> getUserEmailFromSf() async {
//     SharedPreferences sf = await SharedPreferences.getInstance();
//     return sf.getString(userEmailKey);
//   }

//   static Future<String?> getUserNameFromSf() async {
//     SharedPreferences sf = await SharedPreferences.getInstance();
//     return sf.getString(userNameKey);
//   }

//   // static Future<String?> gettingPostsSf() async {
//   //   SharedPreferences sf = await SharedPreferences.getInstance();
//   //   return sf.getString(post);
//   // }
// }
