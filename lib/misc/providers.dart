import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String username;
  String knlg;
  String nnknlg;

  UserProvider({this.username = "", this.knlg = "", this.nnknlg = ""});

  void changeUserName({
    required String newUserName,
  }) async {
    username = newUserName;
    notifyListeners();
  }

  void cknlg({
    required String nknlg,
  }) async {
    knlg = nknlg;
    notifyListeners();
  }

  void ncknlg({
    required String nnnknlg,
  }) async {
    nnknlg = nnnknlg;
    notifyListeners();
  }
}
