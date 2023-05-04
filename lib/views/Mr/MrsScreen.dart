import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pharma_clients_app/views/Mr/mrProfileScreen.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../data/model/response_model/mrs/mrs_responseModel.dart';
import '../../data/response/status.dart';
import '../../resources/app_colors.dart';
import '../../resources/constant_imageString.dart';
import '../../resources/constant_strings.dart';
import '../../utils/Dialogue/error_dialogue.dart';
import '../../utils/text_style.dart';
import '../../view_model/afterLogin_viewModel/afterLogin_viewModels.dart';

class MrsScreen extends StatefulWidget {
  const MrsScreen({Key? key}) : super(key: key);

  @override
  State<MrsScreen> createState() => _MrsScreenState();
}

class _MrsScreenState extends State<MrsScreen> {

  MrsViewModel model = MrsViewModel();
  List<Mrs> mrs = [];

  @override
  void initState() {
    model.fetchMrs();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('run');
    final delete = Provider.of<DeleteMrViewModel>(context ,listen: false);
    Widget slideLeftBackground() {
      return Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const <Widget>[
              Icon(
                Icons.delete,
                color: Colors.white,
              ),
              Text(
                " Delete",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.right,
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
      elevation: 0,
      centerTitle: false,
      toolbarHeight: 7.h,
      title: TextWithStyle.appBarTitle(context, ConstantStrings.mrsheading),
    ),
      body: ChangeNotifierProvider<MrsViewModel>(
        create: (BuildContext context) => model,
        child: Consumer<MrsViewModel>(
          builder: (context,value, _){
            switch(value.mrsList.status!){
              case Status.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case Status.error:
                if (kDebugMode) {
                  print(value.mrsList.message.toString());
                }
                return ErrorDialogue(message: value.mrsList.message.toString(),);
              case Status.completed:
                return value.mrsList.data!.data!.isNotEmpty
                    ? ListView.builder(
                  itemCount: value.mrsList.data!.data!.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                      background: slideLeftBackground(),
                      key: ValueKey(value.mrsList.data!.data![index]),
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.endToStart) {
                          final bool? res = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: const Text(
                                      "Are you sure you want to delete?" ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text(
                                        "Cancel",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text(
                                        "Delete",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      onPressed: () {
                                        // TODO: Delete the item from DB etc..
                                        setState(() {
                                          delete.deleteMrs(value.mrsList.data!.data![index].id, context);
                                          model.fetchMrs();
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              });
                          return res;
                        } else {
                          // TODO: Navigate to edit page;
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 1.h,right: 1.h,top: 1.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryColor.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: const Offset(0, 0),
                              )],
                          ),
                        child: InkWell(
                          onTap: () {
                            mrs.add(value.mrsList.data!.data![index]);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MrProfileScreen(
                                          profile: mrs,
                                        )));
                          },
                          child: Padding(
                            padding: EdgeInsets.all(2.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Stack(
                                  alignment: Alignment.topLeft,
                                  children: [
                                    CircleAvatar(
                                      radius: 5.h,
                                      backgroundColor: AppColors.primaryColor,
                                      foregroundColor: Colors.brown.withOpacity(0.5),
                                      child: Text(
                                        value.mrsList.data!.data![index].name!.substring(0, 1).toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 21.sp,
                                            color: Colors.white,
                                            fontWeight:
                                            FontWeight.w600),
                                      ), // setting it true will show initials text above profile picture, default false
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 0.5.h),
                                      width: 2.h,
                                      height: 2.h,
                                      decoration: BoxDecoration(
                                        color:  value.mrsList.data!.data![index].active!
                                            ? Colors.green
                                            : Colors.red,
                                        borderRadius: BorderRadius.circular(5.h),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 2.h,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      child: Text(
                                        value.mrsList.data!.data![index].name!,
                                        style: TextStyle(fontSize: 19.sp, fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    SizedBox(height: 0.5.h,),
                                    SizedBox(
                                     // width: MediaQuery.of(context).size.width/2,
                                      child: Text(
                                        value.mrsList.data!.data![index].email!,
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 17.sp,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 1.h,),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
                    : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(ConstantImage.empty,
                        width: 70.w,
                        //height: 30.h,
                        fit: BoxFit.fill,),
                      SizedBox(height: 2.h),
                      TextWithStyle.appBarTitle(context, ConstantStrings.emptyScreen)
                    ],
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
