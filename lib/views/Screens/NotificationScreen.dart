import 'package:flutter/material.dart';
import 'package:pharma_clients_app/view_model/afterLogin_viewModel/afterLogin_viewModels.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../resources/app_colors.dart';
import '../../resources/constant_strings.dart';
import '../../utils/text_style.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NotificationList>(context);
    return FutureBuilder(
        future: provider.loadNotifications(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  return Scaffold(
                    appBar: AppBar(
                      centerTitle: false,
                      elevation: 0,
                      title: TextWithStyle.appBarTitle(
                          context, ConstantStrings.notificationHeading),
                      // actions: [
                      //   InkWell(
                      //     onTap: (){
                      //       setState(() {
                      //         provider.clearNotifications();
                      //       });
                      //     },
                      //     child: Container(
                      //       margin: EdgeInsets.only(right: 1.h,top: 2.h),
                      //       child: TextWithStyle.containerTitle(context, 'clear'),
                      //     ),
                      //   )
                      // ],
                    ),
                    body: Consumer<NotificationList>(
                      builder: (BuildContext context, value, Widget? child) {
                        return value.notifications.isNotEmpty
                            ? ListView.builder(
                            itemCount: value.notifications.length,
                            itemBuilder: (BuildContext context, int index) {
                              final val = value.notifications[index];
                              return Container(
                                margin: EdgeInsets.only(left: 1.h, right: 1.h, top: 1.h),
                                padding: EdgeInsets.only(left: 2.h,bottom: 0.5.h),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(1.h)),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                      AppColors.primaryColor.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 4,
                                      offset: const Offset(0, 0),
                                    )
                                  ],
                                ),
                                child: ListTile(
                                  title: TextWithStyle.containerTitle(context, val.title),
                                  subtitle: TextWithStyle.productDescription(context, val.message),
                                  trailing: IconButton(onPressed: (){
                                    provider.removeNotification(index);
                                  }, icon: const Icon(Icons.delete)),

                                ),
                              );
                            })
                            : const Center(
                          child: Text('No Notifications found.'),
                        );
                      },
                    ),
                  );
        },
      );
  }
}

