import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pharma_clients_app/view_model/user_viewModel.dart';
import 'package:provider/provider.dart';
import '../data/model/response_model/login_response_model.dart';
import '../data/repository/login_repository.dart';
import '../utils/utils.dart';
import '../views/home_screen.dart';

class LoginViewModel with ChangeNotifier{

  final _myRepo = LoginRepository();

  bool _loading = false ;
  bool get loading => _loading ;

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> login(dynamic data, BuildContext context) async {

    setLoading(true);

    _myRepo.login(data).then((value){
      setLoading(false);
      if(value.success == true){
        print('run');
        final userPreferences = Provider.of<UserViewModel>(context, listen: false);
        userPreferences.saveUser(
          LoginResponseModel(
            data: Data(
                token: value.data!.token.toString(),
                user: User(
                  name: value.data!.user?.name.toString(),
                  isOwner: value.data!.user?.isOwner
                )
            )
          )
        );
        Navigator.push(context,
            MaterialPageRoute(
                builder: (context)=> HomeScreen(token: value.data!.user?.name!,
                isOwner: value.data!.user?.isOwner,)));
      }else{
        Utils.errorAlertDialogue(value.message.toString(), context);
      }
    }).onError((error, stackTrace){
      setLoading(false);
      if(kDebugMode){
        print(error.toString());
      }
    });
  }

}