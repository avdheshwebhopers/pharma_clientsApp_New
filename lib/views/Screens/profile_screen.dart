import 'package:flutter/material.dart';
import 'package:pharma_clients_app/utils/button.dart';
import 'package:pharma_clients_app/utils/profile_container.dart';
import 'package:pharma_clients_app/utils/utils.dart';
import 'package:pharma_clients_app/view_model/afterLogin_viewModel/afterLogin_viewModels.dart';
import 'package:pharma_clients_app/views/Screens/about_company.dart';
import 'package:pharma_clients_app/views/Screens/bank_details.dart';
import 'package:pharma_clients_app/views/Screens/change_password.dart';
import 'package:pharma_clients_app/views/products/favouriteScreen.dart';
import 'package:pharma_clients_app/views/login_screen.dart';
import 'package:pharma_clients_app/views/presentation/addPresentationScreen.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../resources/constant_strings.dart';
import '../../utils/text_style.dart';
import '../../view_model/user_viewModel.dart';
import '../editProfile&Firm/editFirmScreen.dart';
import '../editProfile&Firm/editProfileScreen.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({
    this.value,
    this.isOwner,
    Key? key}) : super(key: key);

  dynamic value;
  bool? isOwner;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    final userPrefernece = Provider.of<UserViewModel>(context);
    final cart = Provider.of<Cart>(context);
   // final presentation = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: TextWithStyle.appBarTitle(context, ConstantStrings.profileheading),
        elevation: 0,
        toolbarHeight: 6.h,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 1.h,),
            ProfileContainer(
              onPress: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=> const EditProfileScreen()));
            },
              title: 'Edit Profile',
              image: 'assets/images/svg/editProfile.svg',
            ),
            if(widget.isOwner == true || widget.isOwner == null)...[
              ProfileContainer(
                onPress: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=> const EditFirmScreen()));
                },
                title: 'Edit Firm',
                image: 'assets/images/svg/bankdetails.svg',
              ),
              ProfileContainer(
                onPress: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const BankDetailsScreen()));
                },
                title: 'Bank Details',
                image: 'assets/images/svg/bankdetails.svg',
              ),
              ],
            ProfileContainer(
              onPress: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=> const FavouriteScreen()));
              },
              title: 'Favorite Products',
              image: 'assets/images/svg/favourite.svg',
            ),
            ProfileContainer(
              onPress: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const ChangePasswordScreen()));
            },
              title: 'Change Password',
              image: 'assets/images/svg/changePassword.svg',
            ),
            ProfileContainer(
              onPress: (){
              Navigator.push(
                context, MaterialPageRoute(
                  builder: (context)=> AboutCompnay(
                      value: widget.value
                  )));},
              title: 'About',
              image: 'assets/images/svg/viewVisits.svg',
            ),
            SizedBox(height: 4.h,),
            Button(
              title: 'Logout',
              onPress: () async {
                Utils.confirmationDialogue('', ConstantStrings.logoutMessage ,() {
                userPrefernece.remove();
                cart.clear();
                //removePresentation();
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
                }, context);
              }, loading: false,),
            SizedBox(height: 10.h,),
          ],
        ),
      ),
    );
  }
}
