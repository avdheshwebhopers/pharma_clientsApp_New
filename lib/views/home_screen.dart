import 'dart:io';
import 'package:badges/badges.dart' as badge;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:pharma_clients_app/data/model/requested_data_model/notificationData.dart';
import 'package:pharma_clients_app/utils/utils.dart';
import 'package:pharma_clients_app/views/AddScreen/AddVisitScreen.dart';
import 'package:pharma_clients_app/views/Screens/FAQsScreen.dart';
import 'package:pharma_clients_app/views/Screens/NotificationScreen.dart';
import 'package:pharma_clients_app/views/Screens/calculator.dart';
import 'package:pharma_clients_app/views/Screens/cart_screen.dart';
import 'package:pharma_clients_app/views/customer/customers_screen.dart';
import 'package:pharma_clients_app/views/Screens/selfAnalysisScreen.dart';
import 'package:pharma_clients_app/views/presentation/addPresentationScreen.dart';
import 'package:pharma_clients_app/views/presentation/presentaionListScreen.dart';
import 'package:pharma_clients_app/views/visits_screen.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:share_plus/share_plus.dart';
import '../data/model/response_model/about_company/about_company_response_model.dart';
import '../data/response/status.dart';
import '../resources/app_colors.dart';
import '../resources/constant_strings.dart';
import '../utils/IconWithFun/gif_with_fun.dart';
import '../utils/IconWithFun/png_with_fun.dart';
import '../utils/IconWithFun/svg_with_fun.dart';
import '../utils/Dialogue/error_dialogue.dart';
import '../utils/scroll_state/scroll_state.dart';
import '../utils/slider/Slider.dart';
import '../utils/text_style.dart';
import '../view_model/afterLogin_viewModel/afterLogin_viewModels.dart';
import '../view_model/beforeLogin_viewModels/beforeLogin_viewModel.dart';
import '../view_model/login_viewmodel.dart';
import 'AddScreen/addMr_Screen.dart';
import 'AddScreen/add_customer.dart';
import 'Mr/MrsScreen.dart';
import 'Screens/customersOrderScreen.dart';
import 'Screens/myOrderScreen.dart';
import 'products/product_screen.dart';
import 'Screens/divisons_screen.dart';
import 'Screens/enquiry_screen.dart';
import 'products/new_launched.dart';
import 'Screens/offer_screen.dart';
import 'Screens/profile_screen.dart';
import 'Screens/promotional.dart';
import 'products/upcoming_products.dart';
import 'Screens/visual_aids_screen.dart';
import 'login_screen.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  String? token;
  bool? isOwner;

  HomeScreen({required this.token, this.isOwner, Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AboutCompanyViewModel model = AboutCompanyViewModel();
  LoginViewModel loginmodel = LoginViewModel();
  GuestDbCountViewModel dbcount = GuestDbCountViewModel();
  DbCountViewModel count = DbCountViewModel();
  List<AboutCompany> about = [];
  List img = [];
  String? token;
  int? type;

  @override
  void initState() {
    if (kDebugMode) {
      print(widget.token);
      print(widget.isOwner);
    }

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    () async {
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        if (kDebugMode) {
          print('User granted permission');
        }
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        if (kDebugMode) {
          print('User granted provisional permission');
        }
      } else {
        if (kDebugMode) {
          print('User declined or has not accepted permission');
        }
      }

      messaging.getToken().then((value) {
        token = value;

        if (kDebugMode) {
          print('FCM TOKEN>>>>>>: ${value!}');
        }

        // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        //   FirebaseMessaging.onMessage.listen((message) {
        //
        //     RemoteNotification? notification = message.notification ;
        //     AndroidNotification? android = message.notification!.android ;
        //
        //     if (kDebugMode) {
        //       print("notifications title:${notification!.title}");
        //       print("notifications body:${notification.body}");
        //       print('count:${android!.count}');
        //       print('data:${message.data.toString()}');
        //     }
        //
        //     if(Platform.isAndroid){
        //       // initLocalNotifications(context, message);
        //       // showNotification(message);
        //     }
        //
        //   });
        //   RemoteNotification? notification = message.notification;
        //   AndroidNotificationChannel channel = const AndroidNotificationChannel(
        //       'title',
        //       'Notifications',
        //       description: '',
        //       importance: Importance.max,
        //   );
        // });

      });
      if (widget.isOwner == false) {
        type = 1;
        await FirebaseMessaging.instance.subscribeToTopic('MRs_notification');
      } else if (widget.isOwner == true) {
        type = 0;
        await FirebaseMessaging.instance.subscribeToTopic('Distributors_notification');
      } else {
        type = 2;
      }

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }();

    Future<void> _messageHandler(RemoteMessage message) async {
      print('background message>>>>>>>>> ${message.data}');

      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description: 'This channel is used for important notifications.', // description
        importance: Importance.max,
      );

      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      var notification = message.data;
      print(notification);

      if (notification != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification['title'],
            notification['message'],
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id, channel.name, channelDescription: channel.description,
                icon: '@mipmap/ic_launcher',
                playSound: true,
                enableVibration: true,
                largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
                // other properties...
              ),
              iOS: const DarwinNotificationDetails(
                presentBadge: true,
                presentSound: true,
              ),
            ));

        //getNotificationData(message);
      }
    }

    FirebaseMessaging.onBackgroundMessage(_messageHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage event) async {
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description: 'This channel is used for important notifications.', // description
        importance: Importance.max,
      );

      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      var notification = event.notification;
      print(notification!.title);
      var initializationSettingsAndroid =
      const AndroidInitializationSettings('images/ic_home_active.png');

      if (notification != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id, channel.name, channelDescription: channel.description,
                icon: '@mipmap/ic_launcher',
                playSound: true,
                enableVibration: true,
                largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
                // other properties...
              ),
              iOS: const DarwinNotificationDetails(
                presentBadge: true,
                presentSound: true,
              ),
            ));
      }

      print("message received");
      print("message received>>>>>" + event.data.toString());
      String date = DateFormat("dd-MM-yyyy h:mm a").format(DateTime.parse(
          event.sentTime != null
              ? event.sentTime.toString()
              : DateTime.now().toString()));

          var notificationData = NotificationData(
              title: notification.title ?? 'Na',
              message: notification.body ?? 'Na',
              dateTime: date
          );

          await Provider.of<NotificationList>(context,listen: false).addNotification(notificationData);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('Message clicked foreground !');
      print("message clicked foreground>>>>>${message.notification!.body}");
      String date = DateFormat("dd-MM-yyyy h:mm a").format(DateTime.parse(
          message.sentTime != null
              ? message.sentTime.toString()
              : DateTime.now().toString()));

      print(message);
      var notificationData = NotificationData(
          title: message.data['title'],
          message: message.data['message'],
          dateTime: date
      );

      await Provider.of<NotificationList>(context,listen: false).addNotification(notificationData);

      // var notificationData = NotificationData(null, message.data['title'],
      //     message.data['message'], date, type, user.id);
      // setState(() {
      //   notificationList.add(notificationData);
      // });
      // NotificationProvider.saveNotifications(notificationList);
      // bool res = await FlutterAppBadger.isAppBadgeSupported();
      // if (res) FlutterAppBadger.updateBadgeCount(notificationList.length);
    });

    widget.token;
    getCount();
    getData();
    super.initState();
  }

  Future<void> getCount() async {
    if (widget.token != null && widget.token.toString().isNotEmpty) {
      await count.fetchCountApi(context);
    } else {
      await dbcount.fetchDbCountApi();
    }
  }

  getData() async {
    await model.fetchAboutCompany();
  }

  @override
  Future<void> dispose() async {
    await model.fetchAboutCompany();
    // TODO: implement dispose
    super.dispose();
  }

  callback() {
    getCount();
  }

  Future<bool?> _onWillPop() async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to exit an App'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => exit(0),
            /*Navigator.of(context).pop(true)*/
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {

      return ChangeNotifierProvider<AboutCompanyViewModel>(
          create: (BuildContext context) => model,
    child: Consumer<AboutCompanyViewModel>(builder: (context, value, _) {
    switch (value.aboutCompany.status!) {
    case Status.loading:
    return Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    color: AppColors.backgroundColor,
    child: Center(
    child: Image.asset(
    'assets/images/png/loading-gif.gif',
    height: 6.h,
    ),
    ),
    );
    case Status.error:
    return ErrorDialogue(
    message: value.aboutCompany.message,
    );
    case Status.completed:
    about.add(value.aboutCompany.data!.data!);
    return WillPopScope(
          onWillPop: () async {
        bool? result = await _onWillPop();
        result ??= false;
        return result;
      },
        child: Scaffold(
          body: _buildScreen(_currentIndex),
          bottomNavigationBar: SalomonBottomBar(
            selectedItemColor: Colors.green.shade800,
            unselectedItemColor: Colors.black,
            margin: EdgeInsets.all(20),
            currentIndex: _currentIndex,
            onTap: (index) {
              // _currentIndex = index;
              setState(() {
                print('run');
                _currentIndex = index;
              });
            },
            items: [
              SalomonBottomBarItem(
                icon: Icon(CupertinoIcons.house_fill),
                title: Text("Dashboard"),
              ),
              SalomonBottomBarItem(
                icon: Icon(CupertinoIcons.cube_box_fill),
                title: Text("Products"),
              ),
              SalomonBottomBarItem(
                icon: Icon(CupertinoIcons.photo_fill),
                title: Text("Visual-Aids"),
              ),

              SalomonBottomBarItem(
                icon: Icon(CupertinoIcons.profile_circled),
                title: Text("Profile"),
              ),
            ],
          ),
          floatingActionButton: Consumer<ScrollState>(
            builder: (context, scrollState, _) {
              return scrollState.isScrolling
                  ? SizedBox(
                height: 7.h,
                    child: FloatingActionButton.extended(
                        elevation: 10,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EnquiryScreen(value: about)));
                        },
                        backgroundColor: AppColors.primaryColor,
                        label: TextWithStyle.contactUsTitle(
                            context, ConstantStrings.enquiry),
                      ),
                  )
                  : SizedBox(
                      height: 8.h,
                      width: 8.h,
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EnquiryScreen(value: about)));
                        },
                        backgroundColor: AppColors.primaryColor,
                        child: Icon(
                          CupertinoIcons.phone_circle_fill,
                          size: 5.h,
                        ),
                      ),
                    );
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        ));}
    }));

  }
  Widget _buildScreen(int index) {
    switch (index) {
      case 0:
        return DashboardScreen(isOwner: widget.isOwner, token: widget.token);
      case 1:
        return ProductScreen(isOwner: widget.isOwner, token: widget.token);
      case 2:
        return VisualAidsScreen(token: widget.token);
      case 3:
        return widget.token != null && widget.token.toString().isNotEmpty ? ProfileScreen(value: about, isOwner: true): LoginScreen()  ;
      default:
        return Container();
    }
  }

  // Widget _buildScreen(int index) {
  //   if (index == 0) {
  //     // You can add conditions here to determine which screen to show for index 0.
  //     if (widget.isOwner == true ) {
  //       return ProductScreen(isOwner: true, token: widget.token);
  //     } else {
  //       return ProductScreen(isOwner: false, token: widget.token);
  //     }
  //   } else if (index == 1) {
  //     // You can add conditions here to determine which screen to show for index 1.
  //     if (widget.showVisualAids) {
  //       return VisualAidsScreen(token: widget.token);
  //     } else {
  //       return OtherScreen(); // Create an "OtherScreen" for alternative content.
  //     }
  //   } else if (index == 2) {
  //     // You can add conditions here to determine which screen to show for index 2.
  //     if (widget.token.isNotEmpty) {
  //       return DivisionScreen(token: widget.token, value: about);
  //     } else {
  //       return NoTokenScreen(); // Create a "NoTokenScreen" for alternative content.
  //     }
  //   } else if (index == 3) {
  //     return NewLaunchedProductScreen(token: widget.token);
  //   } else {
  //     return Container();
  //   }
  // }
}


_onShare(BuildContext context,text,subject) {
    final box = context.findRenderObject() as RenderBox?;
    return Share.share(
      text,
      subject: subject,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }

  class DashboardScreen extends StatefulWidget {
    String? token;
    bool? isOwner;
    DashboardScreen({required this.token, this.isOwner,super.key,});
  
    @override
    State<DashboardScreen> createState() => _DashboardScreenState();
  }
  
  class _DashboardScreenState extends State<DashboardScreen> {

    AboutCompanyViewModel model = AboutCompanyViewModel();
    LoginViewModel loginmodel = LoginViewModel();
    GuestDbCountViewModel dbcount = GuestDbCountViewModel();
    DbCountViewModel count = DbCountViewModel();
    List<AboutCompany> about = [];
    List img = [];
    String? token;

    @override
    void initState() {
        getCount();
        getData();
      // TODO: implement initState
      super.initState();
    }

    Future<void> getCount() async {
      if (widget.token != null && widget.token.toString().isNotEmpty) {
        await count.fetchCountApi(context);
      } else {
        await dbcount.fetchDbCountApi();
      }
    }

    getData() async {
      await model.fetchAboutCompany();
    }

    @override
    Widget build(BuildContext context) {

      final scroll = Provider.of<ScrollState>(context, listen: false);
      var orientation = MediaQuery.of(context).orientation;
      final cart = Provider.of<Cart>(context, listen: false);

      Widget itemWidget(value, val){
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 7.h,
            centerTitle: false,
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Column(
              children: [
                widget.token == null
                    ? TextWithStyle.appBarTitle(
                        context, ConstantStrings.dashboardScreen)
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello,',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          TextWithStyle.appBarTitle(context, widget.token!),
                        ],
                      )
              ],
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NotificationScreen()));
                  },
                  icon: Icon(
                    CupertinoIcons.bell_fill,
                    size: 3.5.h,
                    color: Colors.white,
                  )),
              SizedBox(
                width: 2.w,
              ),
        //       widget.token != null && widget.token.toString().isNotEmpty
        //           ? FutureBuilder(
        // future: cart.loadCart(),
        // builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        // return Consumer<Cart>(builder: (BuildContext context, value, Widget? child) {
        // return badge.Badge(
        // badgeAnimation: const badge.BadgeAnimation.slide(),
        // position: badge.BadgePosition.topEnd(end: 0, top: 0),
        // badgeStyle: badge.BadgeStyle(
        // badgeColor: Colors.red,
        // ),
        // badgeContent: Text(
        // value.items.length.toString(),
        // style: TextStyle(color: Colors.white, fontSize: 12.sp),
        // ),
        // child: IconButton(
        // onPressed: () {
        // widget.token != null
        // ? Navigator.push(
        // context,
        // MaterialPageRoute(builder: (context)=> CartScreen( isOwner: widget.isOwner, owner: widget.token,)))
        //     : Navigator.pop(context);
        // },
        // icon: Container(
        // margin: EdgeInsets.only(top: 0.5.h),
        // child: Icon(
        // CupertinoIcons.cart,
        // size: 3.5.h,
        // ),
        // )
        // ),
        // );
        // },);
        // },
        // )
        //           : InkWell(
        //               onTap: () {
        //                 Navigator.push(
        //                     context,
        //                     MaterialPageRoute(
        //                         builder: (context) => const LoginScreen()));
        //               },
        //               child: SizedBox(
        //                 width: 3.5.h,
        //                 child: SvgPicture.asset(
        //                   'assets/images/svg/login.svg',
        //                   colorFilter: ColorFilter.mode(
        //                       AppColors.primaryColor, BlendMode.srcIn),
        //                 ),
        //               )),
              const SizedBox(
                width: 10,
              )
            ],
          ),
          body: NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (scrollInfo is ScrollStartNotification) {
                  scroll.updateScrolling(true);
                } else if (scrollInfo is ScrollEndNotification) {
                  scroll.updateScrolling(false);
                }
                return true;
              },
              child: RefreshIndicator(
                onRefresh: () {
                  return getCount();
                },
                child: SingleChildScrollView(
                    child: Column(
                      children: [
                        NotificationListener<ScrollNotification>(
                          onNotification: (scrollInfo) {
                            if (scrollInfo is ScrollStartNotification) {
                              scroll.updateScrolling(false);
                            } else if (scrollInfo is ScrollEndNotification) {
                              scroll.updateScrolling(false);
                            }
                            return true;
                          },
                          child: slider(
                            images: value.aboutCompany.data!.data!.aboutImgs!,
                            aspectRatio: 2.1,
                            viewPortFraction: 0.95,
                          ),
                        ),
                        // Container(
                        //     padding: EdgeInsets.only(top: 2.w),
                        //     margin: EdgeInsets.only(
                        //         left: 3.w, right: 3.w, bottom: 3.w, top: 3.w),
                        //     decoration: BoxDecoration(
                        //         color: Colors.white,
                        //         borderRadius: BorderRadius.all(Radius.circular(1.h)),
                        //         border: Border.all(
                        //             color: AppColors.borderColor,
                        //             strokeAlign: BorderSide.strokeAlignInside,
                        //             width: 1)),
                        //     child: Column(
                        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         TextWithStyle.containerTitle(
                        //             context, '   Our PortFolio'),
                        //         SizedBox(
                        //           height: 2.h,
                        //         ),
                        //         // Container(
                        //         //   padding: EdgeInsets.only(left: 3.w, right: 3.w),
                        //         //   child: Row(
                        //         //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //         //     crossAxisAlignment: CrossAxisAlignment.start,
                        //         //     children: [
                        //         //       badge.Badge(
                        //         //         badgeAnimation: const badge.BadgeAnimation.slide(),
                        //         //         position: badge.BadgePosition.topEnd(end: -0.4.h),
                        //         //         badgeStyle: badge.BadgeStyle(
                        //         //           badgeColor: Colors.red.shade600,
                        //         //           shape: badge.BadgeShape.square,
                        //         //           borderRadius: BorderRadius.circular(10),
                        //         //           elevation: 0,
                        //         //         ),
                        //         //         badgeContent: Text(
                        //         //           val.data?.productCount.toString() ?? '0',
                        //         //           style: TextStyle(
                        //         //               color: Colors.white,
                        //         //               fontSize: 13.sp,
                        //         //               fontWeight: FontWeight.w600),
                        //         //         ),
                        //         //         child: SvgIconsWithFun(
                        //         //           title: ConstantStrings.productScreen,
                        //         //           image: 'assets/images/svg/ic-product.svg',
                        //         //           onPress: () => Navigator.push(
                        //         //             context,
                        //         //             MaterialPageRoute(
                        //         //                 builder: (context) => ProductScreen(
                        //         //                   token: widget.token,
                        //         //                   isOwner: widget.isOwner,
                        //         //                 )),
                        //         //           ),
                        //         //         ),
                        //         //       ),
                        //         //       SvgIconsWithFun(
                        //         //         title: ConstantStrings.visualAidsScreen,
                        //         //         image: 'assets/images/svg/ic-visual-aid.svg',
                        //         //         onPress: () => Navigator.push(
                        //         //           context,
                        //         //           MaterialPageRoute(
                        //         //               builder: (context) => VisualAidsScreen(
                        //         //                 token: widget.token,
                        //         //               )),
                        //         //         ),
                        //         //       ),
                        //         //       SvgIconsWithFun(
                        //         //         title: ConstantStrings.divisions,
                        //         //         image: 'assets/images/svg/ic-division.svg',
                        //         //         onPress: () => Navigator.push(
                        //         //           context,
                        //         //           MaterialPageRoute(
                        //         //               builder: (context) => DivisionScreen(
                        //         //                   token: widget.token, value: about)),
                        //         //         ),
                        //         //       ),
                        //         //       badge.Badge(
                        //         //           position: badge.BadgePosition.topEnd(end: -0.3.h),
                        //         //           badgeStyle: badge.BadgeStyle(
                        //         //             badgeColor: Colors.red.shade600,
                        //         //             shape: badge.BadgeShape.square,
                        //         //             borderRadius: BorderRadius.circular(10),
                        //         //             elevation: 0,
                        //         //           ),
                        //         //           badgeContent: Text(
                        //         //             widget.token != null && widget.token!.isNotEmpty
                        //         //                 ? widget.isOwner == true
                        //         //                 ? val.dataa?.companyOrderCount.toString().length == 1
                        //         //                 ? '0${val.dataa?.companyOrderCount.toString()}'
                        //         //                 : val.dataa?.companyOrderCount.toString() ?? '0'
                        //         //                 : val.data?.orderCount.toString() ?? '0'
                        //         //                 : '0',
                        //         //             style: TextStyle(
                        //         //                 color: Colors.white, fontSize: 13.sp,
                        //         //                 fontWeight: FontWeight.w600
                        //         //               //AppColors.primaryColor
                        //         //             ),
                        //         //           ),
                        //         //           child: widget.token != null && widget.token!.isNotEmpty
                        //         //               ? widget.isOwner == true
                        //         //               ? SvgIconsWithFun(
                        //         //             title: ConstantStrings.myOrders,
                        //         //             image:
                        //         //             'assets/images/svg/ic-my-order.svg',
                        //         //             onPress: () => Navigator.push(
                        //         //               context,
                        //         //               MaterialPageRoute(
                        //         //                   builder: (context) =>
                        //         //                   const MyOrderScreen()),
                        //         //             ),
                        //         //           )
                        //         //               : SvgIconsWithFun(
                        //         //             title: ConstantStrings.myOrders,
                        //         //             image:
                        //         //             'assets/images/svg/ic-my-order.svg',
                        //         //             onPress: () => Navigator.push(
                        //         //               context,
                        //         //               MaterialPageRoute(
                        //         //                   builder: (context) =>
                        //         //                   const CustomersOrderScreen()),
                        //         //             ),
                        //         //           )
                        //         //               : SvgIconsWithFun(
                        //         //             title: ConstantStrings.myOrders,
                        //         //             image:
                        //         //             'assets/images/svg/ic-my-order.svg',
                        //         //             onPress: () => Navigator.push(
                        //         //               context,
                        //         //               MaterialPageRoute(
                        //         //                   builder: (context) =>
                        //         //                   const LoginScreen()),
                        //         //             ),
                        //         //           )),
                        //         //     ],
                        //         //   ),
                        //         // ),
                        //         // widget.isOwner == true || widget.isOwner == null
                        //         //     ? InkWell(
                        //         //   onTap: () {
                        //         //     Navigator.push(
                        //         //         context,
                        //         //         MaterialPageRoute(
                        //         //             builder: (context) =>
                        //         //             const PromotionalScreen()));
                        //         //   },
                        //         //   child: Container(
                        //         //     margin: EdgeInsets.only(top: 2.h),
                        //         //     height: 4.5.h,
                        //         //     width: MediaQuery.of(context).size.width,
                        //         //     decoration: BoxDecoration(
                        //         //         color: AppColors.barColor,
                        //         //         borderRadius: BorderRadius.only(
                        //         //             bottomRight: Radius.circular(0.9.h),
                        //         //             bottomLeft: Radius.circular(0.9.h))),
                        //         //     child: Row(
                        //         //       mainAxisAlignment:
                        //         //       MainAxisAlignment.spaceBetween,
                        //         //       crossAxisAlignment:
                        //         //       CrossAxisAlignment.center,
                        //         //       children: [
                        //         //         Container(
                        //         //             margin: EdgeInsets.only(left: 1.h),
                        //         //             child: Row(
                        //         //               children: [
                        //         //                 SizedBox(
                        //         //                   width: 1.h,
                        //         //                 ),
                        //         //                 Image.asset(
                        //         //                   'assets/images/png/promtional-items.png',
                        //         //                   width: 2.5.h,
                        //         //                 ),
                        //         //                 SizedBox(
                        //         //                   width: 1.h,
                        //         //                 ),
                        //         //                 TextWithStyle.promotionalTitle(
                        //         //                     context,
                        //         //                     "Some offerings from Our Side")
                        //         //               ],
                        //         //             )),
                        //         //         Container(
                        //         //           margin: EdgeInsets.only(right: 1.h),
                        //         //           child: Icon(
                        //         //             CupertinoIcons.right_chevron,
                        //         //             size: 2.h,
                        //         //           ),
                        //         //         )
                        //         //       ],
                        //         //     ),
                        //         //   ),
                        //         // )
                        //         //     : Container(
                        //         //   height: 2.h,
                        //         // )
                        //       ],
                        //     )
                        // ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(top: 2.w, bottom: 2.w),
                          margin: EdgeInsets.only(left: 3.w, right: 3.w, bottom: 3.w),
                          decoration: BoxDecoration(
                              color: Theme.of(context).brightness == Brightness.light
                                  ? Colors.white
                                  : Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.all(Radius.circular(1.h)),
                              border: Border.all(
                                  color: AppColors.borderColor,
                                  strokeAlign: BorderSide.strokeAlignInside,
                                  width: 1)),
                          child: GridView.count(
                            physics: const NeverScrollableScrollPhysics(),
                            primary: false,
                            padding: EdgeInsets.all(20),
                            shrinkWrap: true,
                            crossAxisSpacing: 1.2.w,
                            mainAxisSpacing: 5.w,
                            crossAxisCount: orientation == Orientation.portrait ? 4 : 8,
                            children: [
                              badge.Badge(
                                  badgeAnimation: const badge.BadgeAnimation.slide(),
                                  position: badge.BadgePosition.topEnd(end: 0.8.h),
                                  badgeStyle: badge.BadgeStyle(
                                    badgeColor: AppColors.primaryColor,
                                    shape: badge.BadgeShape.square,
                                    borderRadius: BorderRadius.circular(10),
                                    elevation: 0,
                                  ),
                                  badgeContent: Text(
                                    val.data?.upcommingCount == null || val.data?.upcommingCount == 0
                                        ? ' 0'
                                        : val.data?.upcommingCount.toString().length == 1
                                        ? '0${val.data?.upcommingCount}'
                                        : val.data?.upcommingCount.toString() ?? '0',
                                    style: TextStyle(color: Colors.white, fontSize: 13.sp
                                      //AppColors.primaryColor
                                    ),
                                  ),
                                  child: PngIconsWithFun(
                                    title: ConstantStrings.upcomingScreen,
                                    image: 'assets/images/png/upcoming-products.png',
                                    onPress: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UpcomingProductScreen(
                                            token: widget.token,
                                          )),
                                    ),
                                  )
                              ),
                              badge.Badge(
                                badgeAnimation: const badge.BadgeAnimation.slide(),
                                position: badge.BadgePosition.topEnd(end: 0.8.h),
                                badgeStyle: badge.BadgeStyle(
                                  badgeColor: AppColors.primaryColor,
                                  shape: badge.BadgeShape.square,
                                  borderRadius: BorderRadius.circular(10),
                                  elevation: 0,
                                ),
                                badgeContent: Text(
                                  val.data?.launchesCount.toString() ?? '0',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white, fontSize:13.sp
                                    //AppColors.primaryColor
                                  ),
                                ),
                                child: PngIconsWithFun(
                                  title: ConstantStrings.newLaunches,
                                  image: 'assets/images/png/new-launches.png',
                                  onPress: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NewLaunchedProductScreen(
                                          token: widget.token,
                                        )),
                                  ),
                                ),
                              ),
                              PngIconsWithFun(
                                title: ConstantStrings.myOrders,
                                image: 'assets/images/png/my-order.png',
                                onPress: () async {
                                  if (widget.token != null) {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => PresentationListScreen()));
                                  } else {
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const LoginScreen()));
                                  }
                                },
                              ),
                              PngIconsWithFun(
                                title: ConstantStrings.visits,
                                image: 'assets/images/png/visits.png',
                                onPress: () async {
                                  if (widget.token != null) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const VisitsScreen()));
                                  } else {
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const LoginScreen()));
                                  }
                                },
                              ),
                              PngIconsWithFun(
                                title: ConstantStrings.presentation,
                                image: 'assets/images/png/presentation.png',
                                onPress: () async {
                                  if (widget.token != null) {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => PresentationListScreen()));
                                  } else {
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const LoginScreen()));
                                  }
                                },
                              ),
                              widget.isOwner == true || widget.isOwner == null
                                  ? PngIconsWithFun(
                                title: 'Offers',
                                image: 'assets/images/png/sales.png',
                                onPress: () async {
                                  if (widget.token != null) {
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const OfferScreen()));
                                  } else {
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const LoginScreen()));
                                  }
                                },
                              )
                                  : InkWell(
                                  onTap: () async {
                                    if (widget.token != null) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              const CustomersScreen()));
                                    } else {
                                      await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              const LoginScreen()));
                                    }
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 0.h,
                                      ),
                                      Image.asset(
                                        'assets/images/png/customerss.png',
                                        height: 10.w,
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      TextWithStyle.pngIconTitle(context, 'Customers')
                                    ],
                                  )
                              ),
                              InkWell(
                                  onTap: () async {
                                    if (widget.token != null) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => const Calculator()));
                                    } else {
                                      await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => const LoginScreen()));
                                    }
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Image.asset(
                                        'assets/images/png/calculation.png',
                                        height: 10.w,
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      TextWithStyle.pngIconTitle(context, 'PTS/PTR')
                                    ],
                                  )),
                              // GifIconsWithFun(
                              //   title: ConstantStrings.faqs,
                              //   image: 'assets/images/png/faq.gif',
                              //   onPress: () async {
                              //     if (widget.token != null) {
                              //       Navigator.push(context, MaterialPageRoute(builder: (context)=> const FAQsScreen()));
                              //     } else {
                              //       await Navigator.push(
                              //           context,
                              //           MaterialPageRoute(
                              //               builder: (context) => const LoginScreen()));
                              //     }
                              //   },
                              // ),
                              InkWell(
                                  onTap: () async {
                                    if (widget.token != null) {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => SelfAnalysisScreen()));
                                    } else {
                                      await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => const LoginScreen()));
                                    }
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Image.asset(
                                        'assets/images/png/self-analysis.png',
                                        height: 10.w,
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      TextWithStyle.pngIconTitle(context, 'Analysis')
                                    ],
                                  )),
                              if (widget.isOwner == true || widget.isOwner == null) ...[
                                PngIconsWithFun(
                                  title: ConstantStrings.customers,
                                  image: 'assets/images/png/customers.png',
                                  onPress: () async {
                                    if (widget.token != null) {
                                      await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              const CustomersScreen()));
                                    } else {
                                      await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              const LoginScreen()));
                                    }
                                  },
                                ),
                                PngIconsWithFun(
                                  title: ConstantStrings.mrs,
                                  image: 'assets/images/png/view-mrs.png',
                                  onPress: () async {
                                    if (widget.token != null) {
                                      await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => const MrsScreen()));
                                    } else {
                                      await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              const LoginScreen()));
                                    }
                                  },
                                ),
                                PngIconsWithFun(
                                  title: ConstantStrings.customersOrders,
                                  image: 'assets/images/png/customer-order.png',
                                  onPress: () async {
                                    if (widget.token != null) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              const CustomersOrderScreen()));
                                    } else {
                                      await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              const LoginScreen()));
                                    }
                                  },
                                ),
                                PngIconsWithFun(
                                  title: ConstantStrings.promotionalheading,
                                  image: 'assets/images/png/promtional-items.png',
                                  onPress: () async {
                                    if (widget.token != null) {
                                      Utils.comingSoonDialogue(() {}, context);
                                    } else {
                                      await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              const LoginScreen()));
                                    }
                                  },
                                ),
                              ]
                            ],
                          ),
                        ),

                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(
                              left: 0.w, right: 0.w, top: 3.w, bottom: 0.w),
                          margin: EdgeInsets.only(
                              left: 3.w, right: 3.w, bottom: 3.w, top: 3.w),
                          decoration: BoxDecoration(
                              color: Theme.of(context).brightness == Brightness.light
                                  ? Colors.white
                                  : Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.all(Radius.circular(1.h)),
                              border: Border.all(
                                  color: AppColors.borderColor,
                                  strokeAlign: BorderSide.strokeAlignInside,
                                  width: 1)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 5.w),
                                child: TextWithStyle.containerTitle(context, 'Add'),
                              ),
                              GridView.count(
                                physics: const NeverScrollableScrollPhysics(),
                                primary: false,
                                padding: const EdgeInsets.all(20),
                                shrinkWrap: true,
                                crossAxisSpacing: 1.2.w,
                                mainAxisSpacing: 5.w,
                                crossAxisCount: 4,
                                children: [
                                  PngIconsWithFun(
                                    title: ConstantStrings.addPresentation,
                                    image: 'assets/images/png/add-presentation.png',
                                    onPress: () async {
                                      if (widget.token != null) {
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const AddPresentationScreen()));
                                      } else {
                                        await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                const LoginScreen()));
                                      }
                                    },
                                  ),
                                  PngIconsWithFun(
                                    title: ConstantStrings.addVisits,
                                    image: 'assets/images/png/addvisits.png',
                                    onPress: () async {
                                      if (widget.token != null) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context)=> const AddVisitScreen()));
                                      } else {
                                        await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                const LoginScreen()));
                                      }
                                    },
                                  ),
                                  PngIconsWithFun(
                                    title: ConstantStrings.addCustomers,
                                    image: 'assets/images/png/add-customer.png',
                                    onPress: () async {
                                      if (widget.token != null) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                const AddCustomerScreen()));
                                      } else {
                                        await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                const LoginScreen()));
                                      }
                                    },
                                  ),
                                  widget.isOwner == true || widget.isOwner == null
                                      ? PngIconsWithFun(
                                    title: ConstantStrings.addMrs,
                                    image: 'assets/images/png/add-mrs.png',
                                    onPress: () async {
                                      if (widget.token != null) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                const AddMrScreen()));
                                      } else {
                                        await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                const LoginScreen()));
                                      }
                                    },
                                  )
                                      : Container(),
                                ],
                              )
                            ],
                          ),
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     widget.isOwner == true || widget.isOwner == null
                        //         ? PngIconsWithFun(
                        //       title: 'Offers',
                        //       image: 'assets/images/png/sales.png',
                        //       onPress: () async {
                        //         if (widget.token != null) {
                        //           await Navigator.push(
                        //               context,
                        //               MaterialPageRoute(
                        //                   builder: (context) =>
                        //                   const OfferScreen()));
                        //         } else {
                        //           await Navigator.push(
                        //               context,
                        //               MaterialPageRoute(
                        //                   builder: (context) =>
                        //                   const LoginScreen()));
                        //         }
                        //       },
                        //     )
                        //         : InkWell(
                        //         onTap: () async {
                        //           if (widget.token != null) {
                        //             Navigator.push(
                        //                 context,
                        //                 MaterialPageRoute(
                        //                     builder: (context) =>
                        //                     const CustomersScreen()));
                        //           } else {
                        //             await Navigator.push(
                        //                 context,
                        //                 MaterialPageRoute(
                        //                     builder: (context) =>
                        //                     const LoginScreen()));
                        //           }
                        //         },
                        //         child: Column(
                        //           mainAxisAlignment: MainAxisAlignment.start,
                        //           crossAxisAlignment: CrossAxisAlignment.center,
                        //           children: [
                        //             SizedBox(
                        //               height: 0.h,
                        //             ),
                        //             Image.asset(
                        //               'assets/images/png/customerss.png',
                        //               height: 10.w,
                        //             ),
                        //             SizedBox(
                        //               height: 1.h,
                        //             ),
                        //             TextWithStyle.pngIconTitle(context, 'Customers')
                        //           ],
                        //         )
                        //     ),
                        //     InkWell(
                        //         onTap: () async {
                        //           if (widget.token != null) {
                        //             Navigator.push(
                        //                 context,
                        //                 MaterialPageRoute(
                        //                     builder: (context) => const Calculator()));
                        //           } else {
                        //             await Navigator.push(
                        //                 context,
                        //                 MaterialPageRoute(
                        //                     builder: (context) => const LoginScreen()));
                        //           }
                        //         },
                        //         child: Column(
                        //           mainAxisAlignment: MainAxisAlignment.start,
                        //           crossAxisAlignment: CrossAxisAlignment.center,
                        //           children: [
                        //             SizedBox(
                        //               height: 0.5.h,
                        //             ),
                        //             Image.asset(
                        //               'assets/images/png/calculation.png',
                        //               height: 10.w,
                        //             ),
                        //             SizedBox(
                        //               height: 1.h,
                        //             ),
                        //             TextWithStyle.pngIconTitle(context, 'PTS/PTR')
                        //           ],
                        //         )),
                        //     GifIconsWithFun(
                        //       title: ConstantStrings.faqs,
                        //       image: 'assets/images/png/faq.gif',
                        //       onPress: () async {
                        //         if (widget.token != null) {
                        //           Navigator.push(context, MaterialPageRoute(builder: (context)=> const FAQsScreen()));
                        //         } else {
                        //           await Navigator.push(
                        //               context,
                        //               MaterialPageRoute(
                        //                   builder: (context) => const LoginScreen()));
                        //         }
                        //       },
                        //     ),
                        //     InkWell(
                        //         onTap: () async {
                        //           if (widget.token != null) {
                        //             Navigator.push(context, MaterialPageRoute(builder: (context) => SelfAnalysisScreen()));
                        //           } else {
                        //             await Navigator.push(
                        //                 context,
                        //                 MaterialPageRoute(
                        //                     builder: (context) => const LoginScreen()));
                        //           }
                        //         },
                        //         child: Column(
                        //           mainAxisAlignment: MainAxisAlignment.start,
                        //           crossAxisAlignment: CrossAxisAlignment.center,
                        //           children: [
                        //             SizedBox(
                        //               height: 0.5.h,
                        //             ),
                        //             Image.asset(
                        //               'assets/images/png/self-analysis.png',
                        //               height: 10.w,
                        //             ),
                        //             SizedBox(
                        //               height: 1.h,
                        //             ),
                        //             TextWithStyle.pngIconTitle(context, 'Analysis')
                        //           ],
                        //         )),
                        //   ],
                        // ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Builder(
                          builder: (BuildContext context) {
                            return InkWell(
                              onTap: () {
                                value.aboutCompany.data.data.iosAppLiveLink.isEmpty &&
                                    value.aboutCompany.data.data.appLiveLink.isEmpty
                                    ? ErrorDialogue(
                                  message: 'NoLinkFound',
                                )
                                    : _onShare(
                                    context,
                                    'IosAppLink: ${value.aboutCompany.data.data.iosAppLiveLink}'
                                        '\nAndroidAppLink: ${value.aboutCompany.data.data.appLiveLink}',
                                    ConstantStrings.appName
                                );
                              },
                              child: Container(
                                  margin: EdgeInsets.only(left: 3.w, right: 3.w),
                                  child: Image.asset("assets/images/png/share-image.png")),
                            );
                          },
                        ),
                      ],
                    )),
              )),
        );
      }

      return ChangeNotifierProvider<AboutCompanyViewModel>(
          create: (BuildContext context) => model,
          child: Consumer<AboutCompanyViewModel>(builder: (context, value, _) {
            switch (value.aboutCompany.status!) {
              case Status.loading:
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: AppColors.backgroundColor,
                  child: Center(
                    child: Image.asset(
                      'assets/images/png/loading-gif.gif',
                      height: 6.h,
                    ),
                  ),
                );
              case Status.error:
                return ErrorDialogue(
                  message: value.aboutCompany.message,
                );
              case Status.completed:
                about.add(value.aboutCompany.data!.data!);
                return widget.token != null &&
                    widget.token.toString().isNotEmpty
                    ? ChangeNotifierProvider<DbCountViewModel>(
                    create: (BuildContext context) => count,
                    child: Consumer<DbCountViewModel>(
                        builder: (context, val, _) {
                          return val.loading == false
                              ? RefreshIndicator(onRefresh: () {
                                  return getData();
                                },
                              child: itemWidget(value, val))
                              : Container(color: AppColors.backgroundColor,
                            child: const Center(
                                child: CircularProgressIndicator()
                            ),
                          );
                        }))
                    : ChangeNotifierProvider<GuestDbCountViewModel>(
                    create: (BuildContext context) => dbcount,
                    child: Consumer<GuestDbCountViewModel>(
                        builder: (context, val, _) {
                          return val.loading == false
                              ? itemWidget(value, val)
                              : const CircularProgressIndicator();
                        }));
            //: ChangeNotifierProvider(create: (BuildContext context){});
            }
          }),
        );
    }
  }
  

