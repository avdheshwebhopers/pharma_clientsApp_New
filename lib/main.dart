import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:pharma_clients_app/resources/app_colors.dart';
import 'package:pharma_clients_app/views/products/product_list_widget.dart';
import 'package:pharma_clients_app/utils/scroll_state/scroll_state.dart';
import 'package:pharma_clients_app/utils/slider/slider_provider.dart';
import 'package:pharma_clients_app/view_model/afterLogin_viewModel/afterLogin_viewModels.dart';
import 'package:pharma_clients_app/view_model/beforeLogin_viewModels/beforeLogin_viewModel.dart';
import 'package:pharma_clients_app/view_model/enquiry_view_model.dart';
import 'package:pharma_clients_app/view_model/login_viewmodel.dart';
import 'package:pharma_clients_app/view_model/user_viewModel.dart';
import 'package:pharma_clients_app/views/addScreen/AddVisitScreen.dart';
import 'package:pharma_clients_app/views/presentation/addPresentationScreen.dart';
import 'package:pharma_clients_app/views/products/product_screen.dart';
import 'package:pharma_clients_app/views/SplashScreen/splash_screen.dart';
import 'package:pharma_clients_app/views/register_screen.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'data/model/requested_data_model/notificationData.dart';
import 'view_model/ThemeChange.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message)async {
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");

  print('background message>>>>>>>>> ${message.data}');

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  var notification = message.data;

  if (notification != null) {
    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification['title'].toString(),
        notification['message'].toString(),
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
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ));


    //getNotificationData(message);
  }

  String date = DateFormat("dd-MM-yyyy h:mm a").format(DateTime.parse(
      message.sentTime != null
          ? message.sentTime.toString()
          : DateTime.now().toString()));

  var notificationData = NotificationData(
      title:  message.data['title'].toString(),
      message: message.data['message'].toString(),
      dateTime: date
  );
}

Future<void> main() async {

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: AppColors.backgroundColor,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Firebase.initializeApp();
  await Cart().loadCart();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    MaterialColor mycolor = MaterialColor(
      AppColors.primaryColor.value,
      <int, Color>{
        50: AppColors.primaryColor.withOpacity(0.1),
        100: AppColors.primaryColor.withOpacity(0.2),
        200: AppColors.primaryColor.withOpacity(0.3),
        300: AppColors.primaryColor.withOpacity(0.4),
        400: AppColors.primaryColor.withOpacity(0.5),
        500: AppColors.primaryColor.withOpacity(0.6),
        600: AppColors.primaryColor.withOpacity(0.7),
        700: AppColors.primaryColor.withOpacity(0.8),
        800: AppColors.primaryColor.withOpacity(0.9),
        900: AppColors.primaryColor.withOpacity(1.0),
      },
    );

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SliderProvider()),
          ChangeNotifierProvider(create: (_) => ThemeChange()),
          ChangeNotifierProvider(create: (_) => PackingViewModel()),
          ChangeNotifierProvider(create: (_) => AboutCompanyViewModel()),
          ChangeNotifierProvider(create: (_) => AboutPromotionalViewModel()),
          ChangeNotifierProvider(create: (_) => GuestProductViewModel()),
          ChangeNotifierProvider(create: (_) => ProductViewModel()),
          ChangeNotifierProvider(create: (_) => GuestVisualAidsViewModel()),
          ChangeNotifierProvider(create: (_) => EnquiryViewModel()),
          ChangeNotifierProvider(create: (_) => LoginViewModel()),
          ChangeNotifierProvider(create: (_) => ScrollState()),
          ChangeNotifierProvider(create: (_) => UserViewModel()),
          ChangeNotifierProvider(create: (_) => GuestDbCountViewModel()),
          ChangeNotifierProvider(create: (_) => DbCountViewModel()),
          ChangeNotifierProvider(create: (_) => OffersViewModel()),
          ChangeNotifierProvider(create: (_) => MrsViewModel()),
          ChangeNotifierProvider(create: (_) => UpdateMrViewModel()),
          ChangeNotifierProvider(create: (_) => DeleteMrViewModel()),
          ChangeNotifierProvider(create: (_) => AddCustomerViewModel()),
          ChangeNotifierProvider(create: (_) => StatusMrViewModel()),
          ChangeNotifierProvider(create: (_) => AddMrViewModel()),
          ChangeNotifierProvider(create: (_) => ChangePasswordViewModel()),
          ChangeNotifierProvider(create: (_) => DivisionsViewModel()),
          ChangeNotifierProvider(create: (_) => RegisterViewModel()),
          ChangeNotifierProvider(create: (_) => ProfileViewModel()),
          ChangeNotifierProvider(create: (_) => UpdateProfileViewModel()),
          ChangeNotifierProvider(create: (_) => StatesViewModel()),
          ChangeNotifierProvider(create: (_) => CitiesViewModel()),
          ChangeNotifierProvider(create: (_) => DivisionProvider()),
          ChangeNotifierProvider(create: (_) => ProfileSearchViewModel()),
          ChangeNotifierProvider(create: (_) => OtpVerifyViewModel()),
          ChangeNotifierProvider(create: (_) => ResetPasswordViewModel()),
          ChangeNotifierProvider(create: (_) => ProductByDivision()),
          ChangeNotifierProvider(create: (_) => AddtoFavViewModel()),
          ChangeNotifierProvider(create: (_) => Cart()),
          ChangeNotifierProvider(create: (_) => UpdateFirmViewModel()),
          ChangeNotifierProvider(create: (_) => ResetMrPasswordViewModel()),
          ChangeNotifierProvider(create: (_) => SelectPacking()),
          ChangeNotifierProvider(create: (_) => AddVisitViewModel()),
          ChangeNotifierProvider(create: (_) => Presentation()),
          ChangeNotifierProvider(create: (_) => ProProvider()),
          ChangeNotifierProvider(create: (_) => PlaceOrderViewModel()),
          ChangeNotifierProvider(create: (_) =>NotificationList())
        ],
        child: Builder(builder: (BuildContext context) {
          return ResponsiveSizer(
            builder: (context, orientation, screenType) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                themeMode: Provider.of<ThemeChange>(context).thememode,
                theme: ThemeData(
                    fontFamily: "SFPro-Rounded",
                    brightness: Brightness.light,
                    primarySwatch: mycolor,
                    scaffoldBackgroundColor: AppColors.backgroundColor,
                    appBarTheme: AppBarTheme(
                        color: AppColors.backgroundColor.withOpacity(1),
                        iconTheme: const IconThemeData(
                            color: Colors.black
                        ))
                ),
                home: const SplashScreen(),
              );
            },
            maxMobileWidth: 400,
          );
        }));
  }
}
