import 'package:flutter/material.dart';
import 'package:pharma_clients_app/data/model/response_model/login_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier{

  Future<bool> saveUser(LoginResponseModel user)async{
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', user.data!.token.toString());
    sp.setString('name', user.data!.user!.name.toString());
    sp.setBool('owner', user.data!.user!.isOwner!);
    notifyListeners();
    return true ;
  }

  Future<LoginResponseModel> getUser()async{

    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? token = sp.getString('token');
    final String? name = sp.getString('name');
    final bool? isOwner = sp.getBool('owner');

    return LoginResponseModel(
      data: Data(
          token: token.toString(),
          user: User(
              name: name.toString(),
            isOwner: isOwner,

          )));
  }

  Future<bool> remove()async{
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('token');
    return true;
  }

}


// sp.setString("id", user.data!.user!.id!);
// sp.setString("name", user.data!.user!.name!);
// sp.setString("phone", user.data!.user!.phone!);
// sp.setString("city", user.data!.user!.city!);
// sp.setString("state", user.data!.user!.state!);
// sp.setString("address", user.data!.user!.address!);