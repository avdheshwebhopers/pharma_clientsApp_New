import 'package:flutter/material.dart';
import 'package:pharma_clients_app/data/model/response_model/login_response_model.dart';
import 'package:pharma_clients_app/utils/utils.dart';
import 'package:pharma_clients_app/view_model/afterLogin_viewModel/afterLogin_viewModels.dart';
import 'package:pharma_clients_app/view_model/user_viewModel.dart';
import 'package:pharma_clients_app/views/home_screen.dart';

import '../beforeLogin_viewModels/beforeLogin_viewModel.dart';

class SplashServices {
  Future<LoginResponseModel> getUserData() => UserViewModel().getUser();
  checkAuthentication(BuildContext context)async{
    getUserData().then((value)async{
      if(value.data!.token == "null" || value.data!.token.toString() == ''){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context)=> HomeScreen(
                  token: null,
                  isOwner: null,)));
      }else{
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context)=> HomeScreen(
                  token: value.data?.user?.name,
                  isOwner: value.data?.user?.isOwner,
                )));
      }
    }).onError((error, stackTrace){
      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }

}