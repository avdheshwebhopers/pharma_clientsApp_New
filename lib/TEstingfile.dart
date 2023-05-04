// // // import 'dart:async';
// // // import 'dart:io';
// // // import 'dart:math';
// // // import 'package:flutter/foundation.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:flutter/services.dart';
// // // import 'package:home_widget/home_widget.dart';
// // // import 'package:workmanager/workmanager.dart';
// // //
// // // /// Used for Background Updates using Workmanager Plugin
// // // @pragma("vm:entry-point")
// // // void callbackDispatcher() {
// // //   Workmanager().executeTask((taskName, inputData) {
// // //     final now = DateTime.now();
// // //     return Future.wait<bool?>([
// // //       HomeWidget.saveWidgetData(
// // //         'title',
// // //         'Updated from Background',
// // //       ),
// // //       HomeWidget.saveWidgetData(
// // //         'message',
// // //         '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}',
// // //       ),
// // //       HomeWidget.updateWidget(
// // //         name: 'HomeWidgetExampleProvider',
// // //         iOSName: 'HomeWidgetExample',
// // //       ),
// // //     ]).then((value) {
// // //       return !value.contains(false);
// // //     });
// // //   });
// // // }
// // //
// // // /// Called when Doing Background Work initiated from Widget
// // // @pragma("vm:entry-point")
// // // void backgroundCallback(Uri? data) async {
// // //   print(data);
// // //
// // //   if (data!.host == 'titleclicked') {
// // //     final greetings = [
// // //       'Hello',
// // //       'Hallo',
// // //       'Bonjour',
// // //       'Hola',
// // //       'Ciao',
// // //       '哈洛',
// // //       '안녕하세요',
// // //       'xin chào'
// // //     ];
// // //     final selectedGreeting = greetings[Random().nextInt(greetings.length)];
// // //
// // //     await HomeWidget.saveWidgetData<String>('title', selectedGreeting);
// // //     await HomeWidget.updateWidget(
// // //         name: 'HomeWidgetExampleProvider', iOSName: 'HomeWidgetExample');
// // //   }
// // // }
// // //
// // // void main() {
// // //   WidgetsFlutterBinding.ensureInitialized();
// // //   Workmanager().initialize(callbackDispatcher, isInDebugMode: kDebugMode);
// // //   runApp(MaterialApp(home: MyApp()));
// // // }
// // //
// // // class MyApp extends StatefulWidget {
// // //   @override
// // //   _MyAppState createState() => _MyAppState();
// // // }
// // //
// // // class _MyAppState extends State<MyApp> {
// // //   final TextEditingController _titleController = TextEditingController();
// // //   final TextEditingController _messageController = TextEditingController();
// // //
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     HomeWidget.setAppGroupId('YOUR_GROUP_ID');
// // //     HomeWidget.registerBackgroundCallback(backgroundCallback);
// // //   }
// // //
// // //   @override
// // //   void didChangeDependencies() {
// // //     super.didChangeDependencies();
// // //     _checkForWidgetLaunch();
// // //     HomeWidget.widgetClicked.listen(_launchedFromWidget);
// // //   }
// // //
// // //   @override
// // //   void dispose() {
// // //     _titleController.dispose();
// // //     _messageController.dispose();
// // //     super.dispose();
// // //   }
// // //
// // //    _sendData() async {
// // //     try {
// // //       return Future.wait([
// // //         HomeWidget.saveWidgetData<String>('title', _titleController.text),
// // //         HomeWidget.saveWidgetData<String>('message', _messageController.text),
// // //       ]);
// // //     } on PlatformException catch (exception) {
// // //       debugPrint('Error Sending Data. $exception');
// // //     }
// // //   }
// // //
// // //    _updateWidget() async {
// // //     try {
// // //       return HomeWidget.updateWidget(
// // //           name: 'HomeWidgetExampleProvider', iOSName: 'HomeWidgetExample');
// // //     } on PlatformException catch (exception) {
// // //       debugPrint('Error Updating Widget. $exception');
// // //     }
// // //   }
// // //
// // //   _loadData() async {
// // //     try {
// // //       return Future.wait([
// // //         HomeWidget.getWidgetData<String?>('title', defaultValue: 'Default Title')
// // //             .then((value) => _titleController.text = value!),
// // //         HomeWidget.getWidgetData<String?>('message',
// // //             defaultValue: 'Default Message')
// // //             .then((value) => _messageController.text = value!),
// // //       ]);
// // //     } on PlatformException catch (exception) {
// // //       debugPrint('Error Getting Data. $exception');
// // //     }
// // //   }
// // //
// // //   Future<void> _sendAndUpdate() async {
// // //     await _sendData();
// // //     await _updateWidget();
// // //   }
// // //
// // //   void _checkForWidgetLaunch() {
// // //     HomeWidget.initiallyLaunchedFromHomeWidget().then(_launchedFromWidget);
// // //   }
// // //
// // //   void _launchedFromWidget(Uri? uri) {
// // //     if (uri != null) {
// // //       showDialog(
// // //           context: context,
// // //           builder: (buildContext) => AlertDialog(
// // //             title: Text('App started from HomeScreenWidget'),
// // //             content: Text('Here is the URI: $uri'),
// // //           ));
// // //     }
// // //   }
// // //
// // //   void _startBackgroundUpdate() {
// // //     Workmanager().registerPeriodicTask('1', 'widgetBackgroundUpdate',
// // //         frequency: Duration(minutes: 15));
// // //   }
// // //
// // //   void _stopBackgroundUpdate() {
// // //     Workmanager().cancelByUniqueName('1');
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: const Text('HomeWidget Example'),
// // //       ),
// // //       body: Center(
// // //         child: Column(
// // //           children: [
// // //             TextField(
// // //               decoration: InputDecoration(
// // //                 hintText: 'Title',
// // //               ),
// // //               controller: _titleController,
// // //             ),
// // //             TextField(
// // //               decoration: InputDecoration(
// // //                 hintText: 'Body',
// // //               ),
// // //               controller: _messageController,
// // //             ),
// // //             ElevatedButton(
// // //               onPressed: _sendAndUpdate,
// // //               child: Text('Send Data to Widget'),
// // //             ),
// // //             ElevatedButton(
// // //               onPressed: _loadData,
// // //               child: Text('Load Data'),
// // //             ),
// // //             ElevatedButton(
// // //               onPressed: _checkForWidgetLaunch,
// // //               child: Text('Check For Widget Launch'),
// // //             ),
// // //             if (Platform.isAndroid)
// // //               ElevatedButton(
// // //                 onPressed: _startBackgroundUpdate,
// // //                 child: Text('Update in background'),
// // //               ),
// // //             if (Platform.isAndroid)
// // //               ElevatedButton(
// // //                 onPressed: _stopBackgroundUpdate,
// // //                 child: Text('Stop updating in background'),
// // //               )
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// //
// // // import 'package:flutter/material.dart';
// // // import 'package:provider/provider.dart';
// // //
// // // class MyHomePage extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       body: FutureBuilder(
// // //         future: Provider.of<MyData>(context).fetchData(),
// // //         builder: (context, snapshot) {
// // //           if (snapshot.connectionState == ConnectionState.done) {
// // //             if (snapshot.hasData) {
// // //               return ListView.builder(
// // //                 itemCount: snapshot.data?.length,
// // //                 itemBuilder: (context, index) {
// // //                   return Text(snapshot.data![index]);
// // //                 },
// // //               );
// // //             } else {
// // //               return Center(
// // //                 child: Text('No data'),
// // //               );
// // //             }
// // //           } else {
// // //             return Center(
// // //               child: CircularProgressIndicator(),
// // //             );
// // //           }
// // //         },
// // //       ),
// // //     );
// // //   }
// // // }
// // //
// // // class MyData with ChangeNotifier {
// // //   List<String> data = [];
// // //
// // //   Future<List<String>> fetchData() async {
// // //     // Code to fetch data from server
// // //     data = [...data, 'Data from server'];
// // //     notifyListeners();
// // //     return data;
// // //   }
// // // }
// //
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'dart:async';
// // import 'dart:convert';
// // import 'package:http/http.dart' as http;
// //
// // // Define a model to store the API response
// // class ResponseData {
// //   final String message;
// //
// //   ResponseData({required this.message});
// //
// //   factory ResponseData.fromJson(Map<String, dynamic> json) {
// //     return ResponseData(
// //       message: json['message'],
// //     );
// //   }
// // }
// //
// // // Define a provider to fetch and store the API response
// // class ResponseDataProvider with ChangeNotifier {
// //   StreamController<ResponseData> _streamController = StreamController<ResponseData>();
// //   Stream<ResponseData> get stream => _streamController.stream;
// //
// //   fetchData() async {
// //     final response = await http.get('https://clientapps.webhopers.com:3069/api/app/about' as Uri);
// //
// //     if (response.statusCode == 200) {
// //       _streamController.sink.add(ResponseData.fromJson(json.decode(response.body)));
// //     } else {
// //       throw Exception('Failed to load data');
// //     }
// //   }
// //
// //   dispose() {
// //     _streamController.close();
// //     super.dispose();
// //   }
// // }
// //
// // class HomeScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Container(
// //         child: Center(
// //           child: StreamBuilder<ResponseData>(
// //             stream: Provider.of<ResponseDataProvider>(context).stream,
// //             builder: (context, snapshot) {
// //               if (snapshot.hasData) {
// //                 return Text(snapshot.data!.message);
// //               } else if (snapshot.hasError) {
// //                 return Text("${snapshot.error}");
// //               }
// //               return const CircularProgressIndicator();
// //             },
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // void main() {
// //   runApp(
// //     ChangeNotifierProvider(
// //       create: (context) => ResponseDataProvider(),
// //       child: MaterialApp(
// //         home: HomeScreen(),
// //       ),
// //     ),
// //   );
// // }
//
// // Copyright 2013 The Flutter Authors. All rights reserved.
// // Use of this source code is governed by a BSD-style license that can be
// // found in the LICENSE file.
//
// // ignore_for_file: public_member_api_docs
//
// // import 'dart:async';
// //
// // import 'package:flutter/material.dart';
// // import 'package:url_launcher/link.dart';
// // import 'package:url_launcher/url_launcher.dart';
// //
// // void main() {
// //   runApp(const MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   const MyApp({Key? key}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'URL Launcher',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //       ),
// //       home: const MyHomePage(title: 'URL Launcher'),
// //     );
// //   }
// // }
// //
// // class MyHomePage extends StatefulWidget {
// //   const MyHomePage({Key? key, required this.title}) : super(key: key);
// //   final String title;
// //
// //   @override
// //   State<MyHomePage> createState() => _MyHomePageState();
// // }
// //
// // class _MyHomePageState extends State<MyHomePage> {
// //   bool _hasCallSupport = false;
// //   Future<void>? _launched;
// //   String _phone = '';
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     // Check for phone call support.
// //     canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
// //       setState(() {
// //         _hasCallSupport = result;
// //       });
// //     });
// //   }
// //
// //   Future<void> _launchInBrowser(Uri url) async {
// //     if (!await launchUrl(
// //       url,
// //       mode: LaunchMode.externalApplication,
// //     )) {
// //       throw Exception('Could not launch $url');
// //     }
// //   }
// //
// //   Future<void> _launchInWebViewOrVC(Uri url) async {
// //     if (!await launchUrl(
// //       url,
// //       mode: LaunchMode.inAppWebView,
// //       webViewConfiguration: const WebViewConfiguration(
// //           headers: <String, String>{'my_header_key': 'my_header_value'}),
// //     )) {
// //       throw Exception('Could not launch $url');
// //     }
// //   }
// //
// //   Future<void> _launchInWebViewWithoutJavaScript(Uri url) async {
// //     if (!await launchUrl(
// //       url,
// //       mode: LaunchMode.inAppWebView,
// //       webViewConfiguration: const WebViewConfiguration(enableJavaScript: false),
// //     )) {
// //       throw Exception('Could not launch $url');
// //     }
// //   }
// //
// //   Future<void> _launchInWebViewWithoutDomStorage(Uri url) async {
// //     if (!await launchUrl(
// //       url,
// //       mode: LaunchMode.inAppWebView,
// //       webViewConfiguration: const WebViewConfiguration(enableDomStorage: false),
// //     )) {
// //       throw Exception('Could not launch $url');
// //     }
// //   }
// //
// //   Future<void> _launchUniversalLinkIos(Uri url) async {
// //     final bool nativeAppLaunchSucceeded = await launchUrl(
// //       url,
// //       mode: LaunchMode.externalNonBrowserApplication,
// //     );
// //     if (!nativeAppLaunchSucceeded) {
// //       await launchUrl(
// //         url,
// //         mode: LaunchMode.inAppWebView,
// //       );
// //     }
// //   }
// //
// //   Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
// //     if (snapshot.hasError) {
// //       return Text('Error: ${snapshot.error}');
// //     } else {
// //       return const Text('');
// //     }
// //   }
// //
// //   Future<void> _makePhoneCall(String phoneNumber) async {
// //     final Uri launchUri = Uri(
// //       scheme: 'tel',
// //       path: phoneNumber,
// //     );
// //     await launchUrl(launchUri);
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     // onPressed calls using this URL are not gated on a 'canLaunch' check
// //     // because the assumption is that every device can launch a web URL.
// //     final Uri toLaunch =
// //     Uri(scheme: 'https', host: 'www.cylog.org', path: 'headers/');
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(widget.title),
// //       ),
// //       body: ListView(
// //         children: <Widget>[
// //           Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: <Widget>[
// //               Padding(
// //                 padding: const EdgeInsets.all(16.0),
// //                 child: TextField(
// //                     onChanged: (String text) => _phone = text,
// //                     decoration: const InputDecoration(
// //                         hintText: 'Input the phone number to launch')),
// //               ),
// //               ElevatedButton(
// //                 onPressed: _hasCallSupport
// //                     ? () => setState(() {
// //                   _launched = _makePhoneCall(_phone);
// //                 })
// //                     : null,
// //                 child: _hasCallSupport
// //                     ? const Text('Make phone call')
// //                     : const Text('Calling not supported'),
// //               ),
// //               Padding(
// //                 padding: const EdgeInsets.all(16.0),
// //                 child: Text(toLaunch.toString()),
// //               ),
// //               ElevatedButton(
// //                 onPressed: () => setState(() {
// //                   _launched = _launchInBrowser(toLaunch);
// //                 }),
// //                 child: const Text('Launch in browser'),
// //               ),
// //               const Padding(padding: EdgeInsets.all(16.0)),
// //               ElevatedButton(
// //                 onPressed: () => setState(() {
// //                   _launched = _launchInWebViewOrVC(toLaunch);
// //                 }),
// //                 child: const Text('Launch in app'),
// //               ),
// //               ElevatedButton(
// //                 onPressed: () => setState(() {
// //                   _launched = _launchInWebViewWithoutJavaScript(toLaunch);
// //                 }),
// //                 child: const Text('Launch in app (JavaScript OFF)'),
// //               ),
// //               ElevatedButton(
// //                 onPressed: () => setState(() {
// //                   _launched = _launchInWebViewWithoutDomStorage(toLaunch);
// //                 }),
// //                 child: const Text('Launch in app (DOM storage OFF)'),
// //               ),
// //               const Padding(padding: EdgeInsets.all(16.0)),
// //               ElevatedButton(
// //                 onPressed: () => setState(() {
// //                   _launched = _launchUniversalLinkIos(toLaunch);
// //                 }),
// //                 child: const Text(
// //                     'Launch a universal link in a native app, fallback to Safari.(Youtube)'),
// //               ),
// //               const Padding(padding: EdgeInsets.all(16.0)),
// //               ElevatedButton(
// //                 onPressed: () => setState(() {
// //                   _launched = _launchInWebViewOrVC(toLaunch);
// //                   Timer(const Duration(seconds: 5), () {
// //                     closeInAppWebView();
// //                   });
// //                 }),
// //                 child: const Text('Launch in app + close after 5 seconds'),
// //               ),
// //               const Padding(padding: EdgeInsets.all(16.0)),
// //               Link(
// //                 uri: Uri.parse(
// //                     'https://pub.dev/documentation/url_launcher/latest/link/link-library.html'),
// //                 target: LinkTarget.blank,
// //                 builder: (BuildContext ctx, FollowLink? openLink) {
// //                   return TextButton.icon(
// //                     onPressed: openLink,
// //                     label: const Text('Link Widget documentation'),
// //                     icon: const Icon(Icons.read_more),
// //                   );
// //                 },
// //               ),
// //               const Padding(padding: EdgeInsets.all(16.0)),
// //               FutureBuilder<void>(future: _launched, builder: _launchStatus),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
//
// // void main() => runApp(MyApp());
// //
// // class MyApp extends StatelessWidget {
// //   var _openResult = 'Unknown';
// //
// //   Future<void> openFile() async {
// //     const filePath = '/storage/emulated/0/Download/flutter.png';
// //     final result = await OpenFilex.open(filePath);
// //
// //     print(_openResult = "type=${result.type}  message=${result.message}");
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //         appBar: AppBar(
// //           title: Text('Share URL Example'),
// //         ),
// //         body: Center(
// //           child:Column(
// //             children: [
// //               Text('open result: $_openResult\n'),
// //               TextButton(
// //                 onPressed: openFile,
// //                 child: const Text('Tap to open file'),
// //               ),
// //               TextButton(
// //                 child: Text('Share URL'),
// //                 onPressed: () {
// //                   Share.share('https://flutter.dev/');
// //                 },
// //               ),
// //             ],
// //           )
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// // import 'dart:io';
// //
// // import 'package:flutter/material.dart';
// // import 'package:open_filex/open_filex.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column;
// // import 'helper/save_file_mobile.dart';
// //
// // void main() {
// //   runApp(CreateExcelWidget());
// // }
// //
// // /// Represents the XlsIO widget class.
// // class CreateExcelWidget extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return const MaterialApp(
// //       home: CreateExcelStatefulWidget(title: 'Create Excel document'),
// //     );
// //   }
// // }
// //
// // /// Represents the XlsIO stateful widget class.
// // class CreateExcelStatefulWidget extends StatefulWidget {
// //   /// Initalize the instance of the [CreateExcelStatefulWidget] class.
// //   const CreateExcelStatefulWidget({Key? key, required this.title})
// //       : super(key: key);
// //
// //   /// title.
// //   final String title;
// //   @override
// //   // ignore: library_private_types_in_public_api
// //   _CreateExcelState createState() => _CreateExcelState();
// // }
// //
// // class _CreateExcelState extends State<CreateExcelStatefulWidget> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(widget.title),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: <Widget>[
// //             TextButton(
// //               style: TextButton.styleFrom(
// //                 foregroundColor: Colors.white,
// //                 backgroundColor: Colors.lightBlue,
// //                 disabledForegroundColor: Colors.grey,
// //               ),
// //               onPressed: generateExcel,
// //               child: const Text('Generate Excel'),
// //             )
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Future<void> generateExcel() async {
// //     //Create a Excel document.
// //
// //     //Creating a workbook.
// //     final Workbook workbook = Workbook();
// //     //Accessing via index
// //     final Worksheet sheet = workbook.worksheets[0];
// //     sheet.showGridlines = false;
// //
// //     // Enable calculation for worksheet.
// //     sheet.enableSheetCalculations();
// //
// //     //Set data in the worksheet.
// //     sheet.getRangeByName('A1').columnWidth = 4.82;
// //     sheet.getRangeByName('B1:C1').columnWidth = 13.82;
// //     sheet.getRangeByName('D1').columnWidth = 13.20;
// //     sheet.getRangeByName('E1').columnWidth = 7.50;
// //     sheet.getRangeByName('F1').columnWidth = 9.73;
// //     sheet.getRangeByName('G1').columnWidth = 8.82;
// //     sheet.getRangeByName('H1').columnWidth = 4.46;
// //
// //     sheet.getRangeByName('A1:H1').cellStyle.backColor = '#333F4F';
// //     sheet.getRangeByName('A1:H1').merge();
// //     sheet.getRangeByName('B4:D6').merge();
// //
// //     sheet.getRangeByName('B4').setText('Invoice');
// //     sheet.getRangeByName('B4').cellStyle.fontSize = 32;
// //
// //     sheet.getRangeByName('B8').setText('BILL TO:');
// //     sheet.getRangeByName('B8').cellStyle.fontSize = 9;
// //     sheet.getRangeByName('B8').cellStyle.bold = true;
// //
// //     sheet.getRangeByName('B9').setText('Abraham Swearegin');
// //     sheet.getRangeByName('B9').cellStyle.fontSize = 12;
// //
// //     sheet
// //         .getRangeByName('B10')
// //         .setText('United States, California, San Mateo,');
// //     sheet.getRangeByName('B10').cellStyle.fontSize = 9;
// //
// //     sheet.getRangeByName('B11').setText('9920 BridgePointe Parkway,');
// //     sheet.getRangeByName('B11').cellStyle.fontSize = 9;
// //
// //     sheet.getRangeByName('B12').setNumber(9365550136);
// //     sheet.getRangeByName('B12').cellStyle.fontSize = 9;
// //     sheet.getRangeByName('B12').cellStyle.hAlign = HAlignType.left;
// //
// //     final Range range1 = sheet.getRangeByName('F8:G8');
// //     final Range range2 = sheet.getRangeByName('F9:G9');
// //     final Range range3 = sheet.getRangeByName('F10:G10');
// //     final Range range4 = sheet.getRangeByName('F11:G11');
// //     final Range range5 = sheet.getRangeByName('F12:G12');
// //
// //     range1.merge();
// //     range2.merge();
// //     range3.merge();
// //     range4.merge();
// //     range5.merge();
// //
// //     sheet.getRangeByName('F8').setText('INVOICE#');
// //     range1.cellStyle.fontSize = 8;
// //     range1.cellStyle.bold = true;
// //     range1.cellStyle.hAlign = HAlignType.right;
// //
// //     sheet.getRangeByName('F9').setNumber(2058557939);
// //     range2.cellStyle.fontSize = 9;
// //     range2.cellStyle.hAlign = HAlignType.right;
// //
// //     sheet.getRangeByName('F10').setText('DATE');
// //     range3.cellStyle.fontSize = 8;
// //     range3.cellStyle.bold = true;
// //     range3.cellStyle.hAlign = HAlignType.right;
// //
// //     sheet.getRangeByName('F11').dateTime = DateTime(2020, 08, 31);
// //     sheet.getRangeByName('F11').numberFormat =
// //     r'[$-x-sysdate]dddd, mmmm dd, yyyy';
// //     range4.cellStyle.fontSize = 9;
// //     range4.cellStyle.hAlign = HAlignType.right;
// //
// //     range5.cellStyle.fontSize = 8;
// //     range5.cellStyle.bold = true;
// //     range5.cellStyle.hAlign = HAlignType.right;
// //
// //     final Range range6 = sheet.getRangeByName('B15:G15');
// //     range6.cellStyle.fontSize = 10;
// //     range6.cellStyle.bold = true;
// //
// //     sheet.getRangeByIndex(15, 2).setText('Code');
// //     sheet.getRangeByIndex(16, 2).setText('CA-1098');
// //     sheet.getRangeByIndex(17, 2).setText('LJ-0192');
// //     sheet.getRangeByIndex(18, 2).setText('So-B909-M');
// //     sheet.getRangeByIndex(19, 2).setText('FK-5136');
// //     sheet.getRangeByIndex(20, 2).setText('HL-U509');
// //
// //     sheet.getRangeByIndex(15, 3).setText('Description');
// //     sheet.getRangeByIndex(16, 3).setText('AWC Logo Cap');
// //     sheet.getRangeByIndex(17, 3).setText('Long-Sleeve Logo Jersey, M');
// //     sheet.getRangeByIndex(18, 3).setText('Mountain Bike Socks, M');
// //     sheet.getRangeByIndex(19, 3).setText('ML Fork');
// //     sheet.getRangeByIndex(20, 3).setText('Sports-100 Helmet, Black');
// //
// //     sheet.getRangeByIndex(15, 3, 15, 4).merge();
// //     sheet.getRangeByIndex(16, 3, 16, 4).merge();
// //     sheet.getRangeByIndex(17, 3, 17, 4).merge();
// //     sheet.getRangeByIndex(18, 3, 18, 4).merge();
// //     sheet.getRangeByIndex(19, 3, 19, 4).merge();
// //     sheet.getRangeByIndex(20, 3, 20, 4).merge();
// //
// //     sheet.getRangeByIndex(15, 5).setText('Quantity');
// //     sheet.getRangeByIndex(16, 5).setNumber(2);
// //     sheet.getRangeByIndex(17, 5).setNumber(3);
// //     sheet.getRangeByIndex(18, 5).setNumber(2);
// //     sheet.getRangeByIndex(19, 5).setNumber(6);
// //     sheet.getRangeByIndex(20, 5).setNumber(1);
// //
// //     sheet.getRangeByIndex(15, 6).setText('Price');
// //     sheet.getRangeByIndex(16, 6).setNumber(8.99);
// //     sheet.getRangeByIndex(17, 6).setNumber(49.99);
// //     sheet.getRangeByIndex(18, 6).setNumber(9.50);
// //     sheet.getRangeByIndex(19, 6).setNumber(175.49);
// //     sheet.getRangeByIndex(20, 6).setNumber(34.99);
// //
// //     sheet.getRangeByIndex(15, 7).setText('Total');
// //     sheet.getRangeByIndex(16, 7).setFormula('=E16*F16+(E16*F16)');
// //     sheet.getRangeByIndex(17, 7).setFormula('=E17*F17+(E17*F17)');
// //     sheet.getRangeByIndex(18, 7).setFormula('=E18*F18+(E18*F18)');
// //     sheet.getRangeByIndex(19, 7).setFormula('=E19*F19+(E19*F19)');
// //     sheet.getRangeByIndex(20, 7).setFormula('=E20*F20+(E20*F20)');
// //     sheet.getRangeByIndex(15, 6, 20, 7).numberFormat = r'$#,##0.00';
// //
// //     sheet.getRangeByName('E15:G15').cellStyle.hAlign = HAlignType.right;
// //     sheet.getRangeByName('B15:G15').cellStyle.fontSize = 10;
// //     sheet.getRangeByName('B15:G15').cellStyle.bold = true;
// //     sheet.getRangeByName('B16:G20').cellStyle.fontSize = 9;
// //
// //     sheet.getRangeByName('E22:G22').merge();
// //     sheet.getRangeByName('E22:G22').cellStyle.hAlign = HAlignType.right;
// //     sheet.getRangeByName('E23:G24').merge();
// //
// //     final Range range7 = sheet.getRangeByName('E22');
// //     final Range range8 = sheet.getRangeByName('E23');
// //     range7.setText('TOTAL');
// //     range7.cellStyle.fontSize = 8;
// //     range8.setFormula('=SUM(G16:G20)');
// //     range8.numberFormat = r'$#,##0.00';
// //     range8.cellStyle.fontSize = 24;
// //     range8.cellStyle.hAlign = HAlignType.right;
// //     range8.cellStyle.bold = true;
// //
// //     sheet.getRangeByIndex(26, 1).text =
// //     '800 Interchange Blvd, Suite 2501, Austin, TX 78721 | support@adventure-works.com';
// //     sheet.getRangeByIndex(26, 1).cellStyle.fontSize = 8;
// //
// //     final Range range9 = sheet.getRangeByName('A26:H27');
// //     range9.cellStyle.backColor = '#ACB9CA';
// //     range9.merge();
// //     range9.cellStyle.hAlign = HAlignType.center;
// //     range9.cellStyle.vAlign = VAlignType.center;
// //
// //     //Save and launch the excel.
// //     final List<int> bytes = workbook.saveAsStream();
// //     //Dispose the document.
// //     workbook.dispose();
// //
// //     //Save and launch the file.
// //
// //     final String path = (await getApplicationDocumentsDirectory()).path;
// //     final String filename = '$path/output.xlsx';
// //     final File file = File(filename);
// //     await file.writeAsBytes(bytes).then((_) {
// //       try {
// //         //OpenFilex.open(filename);
// //       } catch (e) {
// //         print(e);
// //       }
// //     });
// //   }
// //}
//
//
// // import 'package:flutter/material.dart';
// // import 'package:flutter/widgets.dart';
// //
// // void main() => runApp(MySlideTransition());
// //
// // import 'package:flutter/material.dart';
// //
// // class MyResponsiveWidget extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('My Responsive App'),
// //       ),
// //       body: LayoutBuilder(
// //         builder: (BuildContext context, BoxConstraints constraints) {
// //           if (constraints.maxWidth > 600) {
// //             return _buildWideLayout();
// //           } else {
// //             return _buildNarrowLayout();
// //           }
// //         },
// //       ),
// //     );
// //   }
// //
// //   Widget _buildWideLayout() {
// //     return Row(
// //       children: [
// //         Expanded(
// //           child: Container(
// //             color: Colors.blue,
// //             height: 200,
// //           ),
// //         ),
// //         Expanded(
// //           child: Container(
// //             color: Colors.red,
// //             height: 200,
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   Widget _buildNarrowLayout() {
// //     return Column(
// //       children: [
// //         Container(
// //           color: Colors.blue,
// //           height: 200,
// //         ),
// //         Container(
// //           color: Colors.red,
// //           height: 200,
// //         ),
// //       ],
// //     );
// //   }
// // }
//
//
// import 'package:flutter/material.dart';
// import 'package:multi_select_flutter/multi_select_flutter.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Multi Select',
//       theme: ThemeData(
//         primarySwatch: Colors.purple,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: MyHomePage(title: 'Flutter Multi Select', ),
//     );
//   }
// }
//
// class Animal {
//   final int id;
//   final String name;
//
//   Animal({
//     required this.id,
//     required this.name,
//   });
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key,this.title}) : super(key: key);
//    String? title;
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   static List<Animal?> _animals = [
//     Animal(id: 1, name: "Lion"),
//     Animal(id: 2, name: "Flamingo"),
//     Animal(id: 3, name: "Hippo"),
//     Animal(id: 4, name: "Horse"),
//     Animal(id: 5, name: "Tiger"),
//     Animal(id: 6, name: "Penguin"),
//     Animal(id: 7, name: "Spider"),
//     Animal(id: 8, name: "Snake"),
//     Animal(id: 9, name: "Bear"),
//     Animal(id: 10, name: "Beaver"),
//     Animal(id: 11, name: "Cat"),
//     Animal(id: 12, name: "Fish"),
//     Animal(id: 13, name: "Rabbit"),
//     Animal(id: 14, name: "Mouse"),
//     Animal(id: 15, name: "Dog"),
//     Animal(id: 16, name: "Zebra"),
//     Animal(id: 17, name: "Cow"),
//     Animal(id: 18, name: "Frog"),
//     Animal(id: 19, name: "Blue Jay"),
//     Animal(id: 20, name: "Moose"),
//     Animal(id: 21, name: "Gecko"),
//     Animal(id: 22, name: "Kangaroo"),
//     Animal(id: 23, name: "Shark"),
//     Animal(id: 24, name: "Crocodile"),
//     Animal(id: 25, name: "Owl"),
//     Animal(id: 26, name: "Dragonfly"),
//     Animal(id: 27, name: "Dolphin"),
//   ];
//   final _items = _animals.map((animal) => MultiSelectItem<Animal?>(animal, animal!.name)).toList();
//   //List<Animal> _selectedAnimals = [];
//   List<Animal?> _selectedAnimals2 = [];
//   List<Animal?> _selectedAnimals3 = [];
//   //List<Animal> _selectedAnimals4 = [];
//   List<Animal?> _selectedAnimals5 = [];
//   final _multiSelectKey = GlobalKey<FormFieldState>();
//
//   @override
//   void initState() {
//     _selectedAnimals5 = _animals;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title!),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           alignment: Alignment.center,
//           padding: EdgeInsets.all(20),
//           child: Column(
//             children: <Widget>[
//               SizedBox(height: 40),
//               //################################################################################################
//               // Rounded blue MultiSelectDialogField
//               //################################################################################################

//               SizedBox(height: 50),
//               //################################################################################################
//               // This MultiSelectBottomSheetField has no decoration, but is instead wrapped in a Container that has
//               // decoration applied. This allows the ChipDisplay to render inside the same Container.
//               //################################################################################################
//               // Container(
//               //   decoration: BoxDecoration(
//               //     color: Theme.of(context).primaryColor.withOpacity(.4),
//               //     border: Border.all(
//               //       color: Theme.of(context).primaryColor,
//               //       width: 2,
//               //     ),
//               //   ),
//               //   child: Column(
//               //     children: <Widget>[
//               //       MultiSelectBottomSheetField(
//               //         initialChildSize: 0.4,
//               //         listType: MultiSelectListType.CHIP,
//               //         searchable: true,
//               //         buttonText: Text("Favorite Animals"),
//               //         title: Text("Animals"),
//               //         items: _items,
//               //         onConfirm: (values) {
//               //           _selectedAnimals2 = values;
//               //         },
//               //         chipDisplay: MultiSelectChipDisplay(
//               //           onTap: (value) {
//               //             setState(() {
//               //               _selectedAnimals2.remove(value);
//               //             });
//               //           },
//               //         ),
//               //       ),
//               //       _selectedAnimals2 == null || _selectedAnimals2.isEmpty
//               //           ? Container(
//               //           padding: EdgeInsets.all(10),
//               //           alignment: Alignment.centerLeft,
//               //           child: Text(
//               //             "None selected",
//               //             style: TextStyle(color: Colors.black54),
//               //           ))
//               //           : Container(),
//               //     ],
//               //   ),
//               // ),
//               SizedBox(height: 40),
//               //################################################################################################
//               // MultiSelectBottomSheetField with validators
//               //################################################################################################
//               // MultiSelectBottomSheetField<Animal>(
//               //   key: _multiSelectKey,
//               //   initialChildSize: 0.7,
//               //   maxChildSize: 0.95,
//               //   title: Text("Animals"),
//               //   buttonText: Text("Favorite Animals"),
//               //   items: _items,
//               //   searchable: true,
//               //   validator: (values) {
//               //     if (values == null || values.isEmpty) {
//               //       return "Required";
//               //     }
//               //     List<String> names = values.map((e) => e.name).toList();
//               //     if (names.contains("Frog")) {
//               //       return "Frogs are weird!";
//               //     }
//               //     return null;
//               //   },
//               //   onConfirm: (values) {
//               //     setState(() {
//               //       _selectedAnimals3 = values;
//               //     });
//               //     _multiSelectKey.currentState!.validate();
//               //   },
//               //   chipDisplay: MultiSelectChipDisplay(
//               //     onTap: (item) {
//               //       setState(() {
//               //         _selectedAnimals3.remove(item);
//               //       });
//               //       _multiSelectKey.currentState.validate();
//               //     },
//               //   ),
//               // ),
//               SizedBox(height: 40),
//               //################################################################################################
//               // MultiSelectChipField
//               //################################################################################################
//               MultiSelectChipField(
//                 items: _items,
//                 initialValue: [_animals[4], _animals[7], _animals[9]],
//                 title: Text("Animals"),
//                 headerColor: Colors.blue.withOpacity(0.5),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.blue.shade700, width: 1.8),
//                 ),
//                 selectedChipColor: Colors.blue.withOpacity(0.5),
//                 selectedTextStyle: TextStyle(color: Colors.blue[800]),
//                 onTap: (values) {
//                   //_selectedAnimals4 = values;
//                 },
//               ),
//               SizedBox(height: 40),
//               //################################################################################################
//               // MultiSelectDialogField with initial values
//               //################################################################################################
//               MultiSelectDialogField(
//                 onConfirm: (val) {
//                   _selectedAnimals5 = val;
//                 },
//                 dialogWidth: MediaQuery.of(context).size.width * 0.7,
//                 items: _items,
//                 initialValue:
//                 _selectedAnimals5, // setting the value of this in initState() to pre-select values.
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// main.dart
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'KindaCode.com',
//       theme: ThemeData(
//         // enable Material 3
//         useMaterial3: true,
//         primarySwatch: Colors.indigo,
//       ),
//       home: const HomePage(),
//     );
//   }
// }
//
// // Multi Select widget
// // This widget is reusable
//
//
// // Implement a multi select on the Home screen
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     print(';run');
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('KindaCode.com'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // use this button to open the multi-select dialog
//
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class Division {
//   final String id;
//   final String name;
//
//   Division({required this.id, required this.name});
// }
//
// class MyApp extends StatelessWidget {
//   final List<Division> divisions = [
//     Division(id: '1', name: 'Division 1'),
//     Division(id: '2', name: 'Division 2'),
//     Division(id: '3', name: 'Division 3'),
//     Division(id: '4', name: 'Division 4'),
//     Division(id: '5', name: 'Division 5'),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Multi-Select Dialogue Example',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Multi-Select Dialogue'),
//         ),
//         body: Center(
//           child: ElevatedButton(
//             onPressed: () async {
//               List<String> selectedIds = await showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return DivisionSelector(divisions: divisions);
//                 },
//               );
//
//               print(selectedIds);
//             },
//             child: Text('Open Dialogue'),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class DivisionSelector extends StatefulWidget {
//   final List<Division> divisions;
//
//   DivisionSelector({required this.divisions});
//
//   @override
//   _DivisionSelectorState createState() => _DivisionSelectorState();
// }
//
// class _DivisionSelectorState extends State<DivisionSelector> {
//   List<Division> _selectedDivisions = [];
//
//   void _toggleSelection(Division division) {
//     setState(() {
//       if (_selectedDivisions.contains(division)) {
//         _selectedDivisions.remove(division);
//       } else {
//         _selectedDivisions.add(division);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Select Divisions'),
//       ),
//       body: Column(
//         children: [
//           CheckboxListTile(
//             title: Text('Select All'),
//             value: _selectedDivisions.length == widget.divisions.length,
//             onChanged: (bool? value) {
//               setState(() {
//                 if (value == true) {
//                   _selectedDivisions = List.from(widget.divisions);
//                 } else {
//                   _selectedDivisions.clear();
//                 }
//               });
//             },
//             secondary: Icon(Icons.select_all),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: widget.divisions.length,
//               itemBuilder: (BuildContext context, int index) {
//                 final division = widget.divisions[index];
//                 return CheckboxListTile(
//                   title: Text(division.name),
//                   value: _selectedDivisions.contains(division),
//                   onChanged: (bool? value) => _toggleSelection(division),
//                 );
//               },
//             ),
//           ),
//           TextButton(
//             onPressed: () {
//               List<String> selectedIds = _selectedDivisions.map((division) => division.id).toList();
//               print(selectedIds);
//               Navigator.pop(context);
//             },
//             child: Text('Submit'),
//           ),
//         ],
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'My App',
//       home: TestPage()
//     );
//   }
// }
//
//
// class TestPage extends StatefulWidget {
//   TestPage({Key? key}) : super(key: key);
//
//   @override
//   State<TestPage> createState() => _TestPageState();
// }
//
// class _TestPageState extends State<TestPage> {
//
//
//   bool? _value = false;
//
//   AlertDialog _showAlert(BuildContext context){
//     return AlertDialog(
//       title: const Text('Select Division'),
//       content: Container(
//         width: double.maxFinite,
//         child: ListView.builder(
//           itemCount: divisions.length,
//           itemBuilder: (BuildContext context, int index) {
//             return CheckboxListTile(
//               title: Text(divisions[index].name),
//               value: divisions[index].isSelected,
//               selected: _value!,
//               onChanged: (bool? value) {
//                 // toggle the checkbox state
//                 divisions[index].isSelected = value!;
//                 setState(() {
//                   _value = value!;
//                 });
//               },
//             );
//           },
//         ),
//       ),
//       actions: <Widget>[
//         TextButton(
//           child: Text('OK'),
//           onPressed: () {
//             // get the selected divisions
//             List<String> selectedIds = [];
//             for (Division division in divisions) {
//               if (division.isSelected) {
//                 selectedIds.add(division.id);
//               }
//             }
//             print('Selected IDs: $selectedIds');
//             Navigator.pop(context);
//           },
//         ),
//       ],
//     );
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: AppBar(
//         title: Text('My App'),
//       ),
//       body: Center(
//         child: TextButton(
//           child: const Text('Open Dialog'),
//           onPressed: () {
//             showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return _showAlert(context);
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }


//
// import 'package:flutter/material.dart';
//
// void main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   static const String _title = 'Flutter Code Sample';
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: _title,
//       home: Scaffold(
//         appBar: AppBar(title: const Text(_title)),
//         body: const Center(
//           child: MyStatefulWidget(),
//         ),
//       ),
//     );
//   }
// }
//
// class LabeledCheckbox extends StatelessWidget {
//   const LabeledCheckbox({
//     super.key,
//     required this.label,
//     required this.padding,
//     required this.value,
//     required this.onChanged,
//   });
//
//   final String label;
//   final EdgeInsets padding;
//   final bool value;
//   final ValueChanged<bool> onChanged;
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         onChanged(!value);
//       },
//       child: Padding(
//         padding: padding,
//         child: Row(
//           children: <Widget>[
//             Expanded(child: Text(label)),
//             Checkbox(
//               value: value,
//               onChanged: (bool? newValue) {
//                 onChanged(newValue!);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class MyStatefulWidget extends StatefulWidget {
//   const MyStatefulWidget({super.key});
//
//   @override
//   State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
// }
//
// class _MyStatefulWidgetState extends State<MyStatefulWidget> {
//
//   bool _isSelected = false;
//
//   @override
//   Widget build(BuildContext context) {
//
//     return LabeledCheckbox(
//       label: 'This is the label text',
//       padding: const EdgeInsets.symmetric(horizontal: 20.0),
//       value: _isSelected,
//       onChanged: (bool newValue) {
//         setState(() {
//           _isSelected = newValue;
//         });
//       },
//     );
//   }
// }



//Correct Code


// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// void main() {
//   runApp(MultiProvider(
//     providers: [
//       // ChangeNotifierProvider<SingleNotifier>(
//       //   create: (_) => SingleNotifier(),
//       // ),
//       ChangeNotifierProvider<MultipleNotifier>(
//         create: (_) => MultipleNotifier([]),
//       )
//     ],
//     child: MyApp(),
//   ));
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'AlertDialogs',
//       home: HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('AlertDialogs'),
//         ),
//         body: Center(
//             child: ListView(
//               children: ListTile.divideTiles(tiles: [
//                 ListTile(
//                   title: Text('Multiple choice Dialog'),
//                   onTap: () => _showMultipleChoiceDialog(context),
//                 ),
//               ], context: context)
//                   .toList(),
//             )));
//   }
//
//   _showMultipleChoiceDialog(BuildContext context) => showDialog(
//       context: context,
//       builder: (context) {
//         final _multipleNotifier = Provider.of<MultipleNotifier>(context);
//         return AlertDialog(
//           title: Text('Select one country or many countries'),
//           content: SingleChildScrollView(
//             child: Container(
//                 width: double.infinity,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: divisions.map((e) => CheckboxListTile(
//                     title: Text(e.name),
//                     value: _multipleNotifier.isHaveItem(e.id),
//                     onChanged: (value) {
//                       value!
//                           ? _multipleNotifier.addItem(e.id)
//                           : _multipleNotifier.removeItem(e.id);
//                     },
//                   )).toList(),
//                 )),
//           ),
//           actions: [
//             Consumer<MultipleNotifier>(
//               builder: (BuildContext context, value, _) {
//                 return TextButton(
//                     child: Text('Yes'),
//                     onPressed: () {
//                       print(_multipleNotifier._selecteItems);
//                       Navigator.of(context).pop();
//                     }
//                 );
//               },
//             )
//           ],
//         );
//       });
// }
//
// class MultipleNotifier extends ChangeNotifier {
//   List<String> _selecteItems;
//   MultipleNotifier(this._selecteItems);
//   List<String> get selectedItems => _selecteItems;
//
//   bool isHaveItem(String value) => _selecteItems.contains(value);
//
//   addItem(String value) {
//     if (!isHaveItem(value)!) {
//       _selecteItems.add(value);
//       notifyListeners();
//     }
//   }
//
//   removeItem(String value) {
//     if (isHaveItem(value)!) {
//       _selecteItems.remove(value);
//       notifyListeners();
//     }
//   }
// }
//
// final List<Division> divisions = [
//   Division(id: "0", name: 'Division 1'),
//   Division(id: "1", name: 'Division 2'),
//   Division(id: "2", name: 'Division 3'),
// ];
//
// class Division {
//   String id;
//   String name;
//   bool isSelected;
//
//   Division({
//     required this.id,
//     required this.name,
//     this.isSelected = false,
//   });
// }



// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'KindaCode.com',
//       theme: ThemeData(
//         // enable Material 3
//         useMaterial3: true,
//         primarySwatch: Colors.indigo,
//       ),
//       home: const HomePage(),
//     );
//   }
// }
//
// // Multi Select widget
// // This widget is reusable
// class MultiSelect extends StatefulWidget {
//   final List<String> items;
//   const MultiSelect({Key? key, required this.items}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() => _MultiSelectState();
// }
//
// class _MultiSelectState extends State<MultiSelect> {
//
//   // this variable holds the selected items
//   final List<String> _selectedItems = [];
//
// // This function is triggered when a checkbox is checked or unchecked
//   void _itemChange(String itemValue, bool isSelected) {
//     setState(() {
//       if (isSelected) {
//         _selectedItems.add(itemValue);
//       } else {
//         _selectedItems.remove(itemValue);
//       }
//     });
//   }
//
//   // this function is called when the Cancel button is pressed
//   void _cancel() {
//     Navigator.pop(context);
//   }
//
// // this function is called when the Submit button is tapped
//   void _submit() {
//     Navigator.pop(context, _selectedItems);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     print('run');
//
//     return AlertDialog(
//       title: const Text('Select Topics'),
//       content: SingleChildScrollView(
//         child: ListBody(
//           children: widget.items
//               .map((item) => CheckboxListTile(
//             value: _selectedItems.contains(item),
//             title: Text(item),
//             controlAffinity: ListTileControlAffinity.leading,
//             onChanged: (isChecked) => _itemChange(item, isChecked!),
//           )).toList(),
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: _cancel,
//           child: const Text('Cancel'),
//         ),
//         ElevatedButton(
//           onPressed: _submit,
//           child: const Text('Submit'),
//         ),
//       ],
//     );
//   }
// }
//
// // Implement a multi select on the Home screen
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   List<String> _selectedItems = [];
//
//   void _showMultiSelect() async {
//     // a list of selectable items
//     // these items can be hard-coded or dynamically fetched from a database/API
//     final List<String> items = [
//       'Flutter',
//       'Node.js',
//       'React Native',
//       'Java',
//       'Docker',
//       'MySQL'
//     ];
//
//     final List<String>? results = await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return MultiSelect(items: items);
//       },
//     );
//
//     // Update UI
//     if (results != null) {
//       setState(() {
//         _selectedItems = results;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('KindaCode.com'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // use this button to open the multi-select dialog
//             ElevatedButton(
//               onPressed: _showMultiSelect,
//               child: const Text('Select Your Favorite Topics'),
//             ),
//             const Divider(
//               height: 30,
//             ),
//             // display selected items
//             Wrap(
//               children: _selectedItems
//                   .map((e) => Chip(
//                 label: Text(e),
//               ))
//                   .toList(),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }


//Correct----------------------------------------
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class Product {
//   final String name;
//   final String description;
//   final double price;
//
//   const Product({
//     required this.name,
//     required this.description,
//     required this.price,
//   });
// }
//
// class CartItem {
//   final String name;
//   final double price;
//   int quantity;
//
//   CartItem({
//     required this.name,
//     required this.price,
//     this.quantity = 1,
//   });
//
//   CartItem.fromJson(Map<String, dynamic> json)
//       : name = json['name'],
//         price = json['price'],
//         quantity = json['quantity'];
//
//   Map<String, dynamic> toJson() => {
//     'name': name,
//     'price': price,
//     'quantity': quantity,
//   };
// }
//
// class Cart extends ChangeNotifier {
//   List<CartItem> _items = [];
//
//   List<CartItem> get items => _items;
//
//   int get itemCount => _items.length;
//
//   double get totalPrice => _items.fold(0, (sum, item) => sum + item.price * item.quantity);
//
//   void addItem(CartItem item) {
//     final index = _items.indexWhere((i) => i.name == item.name);
//     if (index != -1) {
//       _items[index].quantity++;
//     } else {
//       _items.add(item);
//     }
//     saveCart();
//     notifyListeners();
//   }
//
//   void removeItem(CartItem item) {
//     final index = _items.indexWhere((i) => i.name == item.name);
//     if (index != -1) {
//       if (_items[index].quantity > 1) {
//         _items[index].quantity--;
//       } else {
//         _items.removeAt(index);
//       }
//       saveCart();
//       notifyListeners();
//     }
//   }
//
//   void updateItemQuantity(CartItem item, int quantity) {
//   final index = _items.indexWhere((i) => i.name == item.name);
//   if (index != -1) {
//     _items[index].quantity = quantity;
//     if (_items[index].quantity == 0) {
//       _items.removeAt(index);
//     }
//     notifyListeners();
//     saveCart();
//   }
// }
//
//   void clear() {
//     _items.clear();
//     saveCart();
//     notifyListeners();
//   }
//
//   Future<void> loadCart() async {
//     final prefs = await SharedPreferences.getInstance();
//     final cartData = prefs.getString('cart');
//     if (cartData != null) {
//       final List<dynamic> list = jsonDecode(cartData);
//       _items = list.map((item) => CartItem.fromJson(item)).toList();
//       notifyListeners();
//     }
//   }
//
//   Future<void> saveCart() async {
//     final prefs = await SharedPreferences.getInstance();
//     final cartData = jsonEncode(_items.map((item) => item.toJson()).toList());
//     await prefs.setString('cart', cartData);
//   }
//
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: ProductListScreen(),
//     );
//   }
// }
//
// class ProductListScreen extends StatelessWidget {
//
//   final List<Product> products = [
//     Product(
//       name: 'Product 1',
//       description: 'This is product 1',
//       price: 10.0,
//     ),
//     Product(
//       name: 'Product 2',
//       description: 'This is product 2',
//       price: 20.0,
//     ),
//     Product(
//       name: 'Product 3',
//       description: 'This is product 3',
//       price: 30.0,
//     ),
//   ];
//
//   // static Future<bool> saveImage(List<int> imageBytes) async {
//   //   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   String base64Image = base64Encode(imageBytes);
//   //   return prefs.setString("image", base64Image);
//   // }
//   //
//   // static Future<Image> getImage() async {
//   //   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   Uint8List bytes = base64Decode(prefs.getString("image")!);
//   //   print(Image.memory(bytes));
//   //   return Image.memory(bytes);
//   // }
//
//   // String _encodedImage = '';
//   // Future<void> _loadImageFromPrefs() async {
//   //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   //   _encodedImage = sharedPreferences.getString('image') ?? '';
//   // }
//   //
//   // Future<String> _getImageString(String imagePath) async {
//   //   final bytes = await File(imagePath).readAsBytes();
//   //   final image = image_lib.decodeImage(bytes);
//   //   final encodedImage = base64.encode(image_lib.encodePng(image));
//   //   return encodedImage;
//   // }
//
//
//   @override
//   Widget build(BuildContext context) {
//     print('build');
//     return Scaffold(
//         appBar: AppBar(
//         title: Text('Products'),
//     actions: [
//     IconButton(
//     icon: Icon(Icons.shopping_cart),
//     onPressed: () {
//     Navigator.of(context).push(
//     MaterialPageRoute (builder: (context) => CartScreen()),
//     );
//     },
//     ),
//     ],
//         ),
//       body: ListView.builder(
//         itemCount: products.length,
//         itemBuilder: (context, index) {
//           final product = products[index];
//           return ListTile(
//             title: Text(product.name),
//             subtitle: Text(product.description),
//             trailing: Text('${product.price}'),
//             onTap: () async {
//               final cart = context.read<Cart>();
//               cart.addItem(
//                 CartItem(
//                   name: product.name,
//                   price: product.price,
//                 ),
//               );
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text('Item added to cart'),
//                   duration: Duration(seconds: 1),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//
// class CartScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//    final provider = Provider.of<Cart>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cart'),
//       ),
//        body: Consumer<Cart>(
//          builder: (BuildContext context, value, Widget? child) {
//            return value.itemCount == 0
//                ? Center(child: Text('Your cart is empty') )
//                : Column(
//              children: [
//                Expanded(
//                  child: ListView.builder(
//                    itemCount: value.itemCount,
//                    itemBuilder: (context, index) {
//                      final item = value.items[index];
//                      return ListTile(
//                        title: Text(item.name),
//                        trailing: Row(
//                          mainAxisSize: MainAxisSize.min,
//                          children: [
//                            IconButton(
//                              icon: Icon(Icons.remove),
//                              onPressed: () {
//                                provider.removeItem(item);
//                              },
//                            ),
//                            Text(item.quantity.toString()),
//                            IconButton(
//                              icon: Icon(Icons.add),
//                              onPressed: () {
//                                provider.addItem(item);
//                              },
//                            ),
//                          ],
//                        ),
//                      );
//                    },
//                  ),
//                ),
//                Divider(),
//                Padding(
//                  padding: const EdgeInsets.all(16.0),
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: [
//                      Text('Total:'),
//                      Consumer<Cart>(
//                        builder: (BuildContext context, value, Widget? child) {
//                          return Text('${value.totalPrice}');
//                        },)
//                      // child: Text('${cart.totalPrice}')),
//                    ],
//                  ),
//                ),
//                ElevatedButton(
//                  onPressed: () {
//                    provider.clear();
//                    Navigator.of(context).pop();
//                  },
//                  child: Text('Clear Cart'),
//                ),
//              ],
//            );
//          },
//        ),
//
//     );
//   }
// }
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final cart = Cart();
//   await cart.loadCart();
//   runApp(
//     ChangeNotifierProvider(
//       create: (_) => cart,
//       child: MyApp(),
//     ),
//   );
// }


// import 'package:flutter/foundation.dart';
//
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
//
// class CartItem {
//   final String id;
//   final String name;
//   final double price;
//   int quantity;
//   bool isSelected;
//
//   CartItem({
//     required this.id,
//     required this.name,
//     required this.price,
//     required this.quantity,
//     this.isSelected = false,
//   });
// }
//
//
// class CartProvider with ChangeNotifier {
//   List<CartItem> _cartItems = [];
//
//   List<CartItem> get cartItems => _cartItems;
//
//   // Load cart items from SharedPreferences
//   Future<void> loadCartItems() async {
//     final prefs = await SharedPreferences.getInstance();
//     final cartItemsJson = prefs.getString('cartItems');
//
//     if (cartItemsJson != null) {
//       final cartItemsData = json.decode(cartItemsJson) as List<dynamic>;
//
//       _cartItems = cartItemsData
//           .map((cartItemData) => CartItem(
//         id: cartItemData['id'],
//         name: cartItemData['name'],
//         price: cartItemData['price'],
//         quantity: cartItemData['quantity'],
//         isSelected: cartItemData['isSelected'],
//       ))
//           .toList();
//
//       notifyListeners();
//     }
//   }
//
//   // Save cart items to SharedPreferences
//   Future<void> saveCartItems() async {
//     final prefs = await SharedPreferences.getInstance();
//     final cartItemsJson = json.encode(
//       _cartItems
//           .map((cartItem) => {
//         'id': cartItem.id,
//         'name': cartItem.name,
//         'price': cartItem.price,
//         'quantity': cartItem.quantity,
//         'isSelected': cartItem.isSelected,
//       }).toList(),
//     );
//
//     prefs.setString('cartItems', cartItemsJson);
//   }
//
//   // Add an item to the cart
//   void addToCart(CartItem item) {
//     final cartItemIndex = _cartItems.indexWhere((cartItem) => cartItem.id == item.id);
//
//     if (cartItemIndex != -1) {
//       _cartItems[cartItemIndex].quantity += item.quantity;
//     } else {
//       _cartItems.add(item);
//     }
//
//     saveCartItems();
//
//     notifyListeners();
//   }
//
//   // Remove an item from the cart
//   void removeFromCart(String itemId) {
//     _cartItems.removeWhere((item) => item.id == itemId);
//
//     saveCartItems();
//
//     notifyListeners();
//   }
//
//   // Update the quantity of an item in the cart
//   void updateCartItemQuantity(String itemId, int newQuantity) {
//     final cartItemIndex = _cartItems.indexWhere((item) => item.id == itemId);
//
//     if (cartItemIndex != -1) {
//       _cartItems[cartItemIndex].quantity = newQuantity;
//
//       saveCartItems();
//
//       notifyListeners();
//     }
//   }
//
//   // Toggle the selection status of an item in the cart
//   void toggleCartItemSelection(String itemId) {
//     final cartItemIndex = _cartItems.indexWhere((item) => item.id == itemId);
//
//     if (cartItemIndex != -1) {
//       _cartItems[cartItemIndex].isSelected = !_cartItems[cartItemIndex].isSelected;
//
//       saveCartItems();
//
//       notifyListeners();
//     }
//   }
//
//   // Remove all selected items from the cart
//   void removeSelectedItemsFromCart() {
//     _cartItems.removeWhere((item) => item.isSelected);
//
//     saveCartItems();
//
//     notifyListeners();
//   }
//
// // Get the total price of all items in the cart
//   double getTotalPrice() {
//     double totalPrice = 0.0;
//
//     for (final item in _cartItems) {
//       totalPrice += item.price * item.quantity;
//     }
//
//     return totalPrice;
//   }
//
// // Clear the cart
//   void clearCart() {
//     _cartItems.clear();
//     saveCartItems();
//
//     notifyListeners();
//   }
// }
//
//
// class CartPage extends StatelessWidget {
//   const CartPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final cartProvider = Provider.of<CartProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cart'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: cartProvider.cartItems.length,
//               itemBuilder: (context, index) {
//                 final item = cartProvider.cartItems[index];
//
//                 return ListTile(
//                   title: Text(item.name),
//                   subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                         onPressed: () {
//                           cartProvider.updateCartItemQuantity(item.id, item.quantity + 1);
//                         },
//                         icon: Icon(Icons.add),
//                       ),
//                       Text(item.quantity.toString()),
//                       IconButton(
//                         onPressed: () {
//                           if (item.quantity == 1) {
//                             cartProvider.removeFromCart(item.id);
//                           } else {
//                             cartProvider.updateCartItemQuantity(item.id, item.quantity - 1);
//                           }
//                         },
//                         icon: Icon(Icons.remove),
//                       ),
//                       Checkbox(
//                         value: item.isSelected,
//                         onChanged: (newValue) {
//                           cartProvider.toggleCartItemSelection(item.id);
//                         },
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//           ListTile(
//             title: Text('Total: \$${cartProvider.getTotalPrice().toStringAsFixed(2)}'),
//             trailing: ElevatedButton(
//               onPressed: () {
//                 cartProvider.removeSelectedItemsFromCart();
//               },
//               child: Text('Remove Selected'),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               cartProvider.clearCart();
//             },
//             child: Text('Clear Cart'),
//           ),
//         ],
//       ),
//     );
//   }
// }

//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => CartProvider()..loadCartItems(),
//       child: MaterialApp(
//         title: 'Flutter Cart',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: HomePage(),
//         routes: {
//           '/cart': (_) => CartPage(),
//         },
//       ),
//     );
//   }
// }
//
//
// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final cartProvider = Provider.of<CartProvider>(context);
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Flutter Cart'),
//         ),
//         body: Center(
//         child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//         ElevatedButton(
//         onPressed: ()
//         {
//           Navigator.of(context).pushNamed('/cart');
//         },
//           child: Text('View Cart'),
//         ),
//           SizedBox(height: 16),
//           Text('Available Items:'),
//           Expanded(
//             child: ListView.builder(
//               itemCount: 10,
//               itemBuilder: (context, index) {
//                 final item = cartItems[index];
//                 return ListTile(
//                   title: Text(item.name),
//                   subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
//                   trailing: IconButton(
//                     onPressed: () {
//                       cartProvider.addToCart(item);
//                     },
//                     icon: Icon(Icons.add_shopping_cart),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//         ),
//         ),
//     );
//   }
// }






//
// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'Flutter Location Demo',
//       debugShowCheckedModeBanner: false,
//       home: LocationPage(),
//     );
//   }
// }
//
// class LocationPage extends StatefulWidget {
//   const LocationPage({Key? key}) : super(key: key);
//
//   @override
//   State<LocationPage> createState() => _LocationPageState();
// }
//
// class _LocationPageState extends State<LocationPage> {
//   String? _currentAddress;
//   Position? _currentPosition;
//
//   Future<bool> _handleLocationPermission() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text(
//               'Location services are disabled. Please enable the services')));
//       return false;
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Location permissions are denied')));
//         return false;
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text(
//               'Location permissions are permanently denied, we cannot request permissions.')));
//       return false;
//     }
//     return true;
//   }
//
//   Future<void> _getCurrentPosition() async {
//     final hasPermission = await _handleLocationPermission();
//
//     if (!hasPermission) return;
//     await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
//         .then((Position position) {
//       setState(() => _currentPosition = position);
//       _getAddressFromLatLng(_currentPosition!);
//     }).catchError((e) {
//       debugPrint(e);
//     });
//   }
//
//   Future<void> _getAddressFromLatLng(Position position) async {
//     await placemarkFromCoordinates(
//         _currentPosition!.latitude, _currentPosition!.longitude)
//         .then((List<Placemark> placemarks) {
//       Placemark place = placemarks[0];
//       setState(() {
//         _currentAddress =
//         '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.postalCode}';
//       });
//     }).catchError((e) {
//       debugPrint(e);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Location Page")),
//       body: SafeArea(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text('LAT: ${_currentPosition?.latitude ?? ""}'),
//               Text('LNG: ${_currentPosition?.longitude ?? ""}'),
//               Text('ADDRESS: ${_currentAddress ?? ""}'),
//               const SizedBox(height: 32),
//               ElevatedButton(
//                 onPressed: _getCurrentPosition,
//                 child: const Text("Get Current Location"),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class Product {
//   final int id;
//   final String name;
//   final double price;
//   int quantity;
//
//   Product({
//     required this.id,
//     required this.name,
//     required this.price,
//     this.quantity = 1});
// }
//
// class CartProvider with ChangeNotifier {
//   List<Product> _cartItems = [];
//
//   List<Product> get cartItems => _cartItems;
//
//   // Add a product to the cart
//   void addToCart(Product product) {
//     final index = _cartItems.indexWhere((p) => p.id == product.id);
//     if (index != -1) {
//       _cartItems[index].quantity += 1;
//     } else {
//       _cartItems.add(product);
//     }
//     saveCartToPrefs();
//     notifyListeners();
//   }
//
//   // Remove a product from the cart
//   void removeFromCart(Product product) {
//     _cartItems.remove(product);
//     saveCartToPrefs();
//     notifyListeners();
//   }
//
//   // Update the quantity of a product in the cart
//   void updateProductQuantity(Product product, int quantity) {
//     product.quantity = quantity;
//     saveCartToPrefs();
//     notifyListeners();
//   }
//
//   // Get the total price of all the products in the cart
//   double get totalPrice =>
//       _cartItems.fold(0, (total, current) => total + (current.price * current.quantity));
//
//   // Initialize the cart from stored data in Shared Preferences
//   Future<void> initCartFromPrefs() async {
//     final prefs = await SharedPreferences.getInstance();
//     final cartData = prefs.getString('cart');
//     if (cartData != null) {
//       final List<dynamic> decodedData = json.decode(cartData);
//       _cartItems = decodedData.map((item) => Product(
//         id: item['id'],
//         name: item['name'],
//         price: item['price'],
//         quantity: item['quantity'],
//       )).toList();
//       notifyListeners();
//     }
//   }
//
//   // Save the cart data to Shared Preferences
//   Future<void> saveCartToPrefs() async {
//     final prefs = await SharedPreferences.getInstance();
//     final encodedData = json.encode(_cartItems.map((item) => {
//       'id': item.id,
//       'name': item.name,
//       'price': item.price,
//       'quantity': item.quantity,
//     }).toList());
//     prefs.setString('cart', encodedData);
//   }
// }
//
// class CartScreen extends StatelessWidget {
//   const CartScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final cartProvider = Provider.of<CartProvider>(context);
//
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Cart'),
//         ),
//         body: ListView.builder(
//           itemCount: cartProvider.cartItems.length,
//           itemBuilder: (context, index) {
//             final product = cartProvider.cartItems[index];
//             return ListTile(
//               leading: Text('${product.id}'),
//               title: Text(product.name),
//               subtitle: Text('${product.price}'),
//               trailing: SizedBox(width: 100,
//                 child: Row(
//                   children: [
//                     IconButton(
//                       onPressed: () {
//                         if (product.quantity > 1) {
//                           cartProvider.updateProductQuantity(
//                               product,
//                               product.quantity - 1
//                           );
//                         }
//                       },
//                       icon: const Icon(Icons.remove),),
//                     Text('${product.quantity}'),
//                     IconButton(
//                       onPressed: () {
//                         cartProvider.updateProductQuantity(
//                             product, product.quantity + 1);
//                       },
//                       icon: const Icon(Icons.add),),
//                   ],),),
//               onLongPress: () {
//                 cartProvider.removeFromCart(product);
//               },);
//           },),
//         bottomNavigationBar: BottomAppBar(
//         child: Container(
//           padding: const EdgeInsets.symmetric(
//               horizontal: 16,
//               vertical: 8
//           ),
//           child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text( 'Total: ${cartProvider.totalPrice}',
//           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), ),
//     ElevatedButton( onPressed: () {},
//       child: const Text( 'Checkout', ), ), ], ), ), ), ); } }
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.clear(); // Clear the shared preferences for testing purposes
//   final cartProvider = CartProvider();
//   await cartProvider.initCartFromPrefs(); // Initialize the cart from the stored data in Shared Preferences
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => cartProvider),
//       ],
//       child: MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'My App',
//       home: CartScreen(),
//     );
//   }
// }
//
// import 'package:flutter/material.dart';
//
// class OtpTextField extends StatefulWidget {
//   final ValueChanged<String> onCompleted;
//
//   const OtpTextField({Key? key, required this.onCompleted}) : super(key: key);
//
//   @override
//   _OtpTextFieldState createState() => _OtpTextFieldState();
// }
//
// class _OtpTextFieldState extends State<OtpTextField> {
//   late List<FocusNode> _focusNodes;
//   late List<TextEditingController> _controllers;
//
//   @override
//   void initState() {
//     super.initState();
//     _focusNodes = List.generate(6, (index) => FocusNode());
//     _controllers = List.generate(6, (index) => TextEditingController());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print('run');
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: List.generate(4, (index) {
//         return SizedBox(
//           width: 40,
//           child: TextField(
//             autofocus: index == 0,
//             focusNode: _focusNodes[index],
//             controller: _controllers[index],
//             textAlign: TextAlign.center,
//             keyboardType: TextInputType.number,
//             onChanged: (value) {
//               if (value.length == 1) {
//                 if (index < 3) {
//                   _focusNodes[index + 1].requestFocus();
//                 } else {
//                   String otp = '';
//                   _controllers.forEach((controller) {
//                     otp += controller.text;
//                   });
//                   widget.onCompleted(otp);
//                 }
//               } else if (value.length == 0) {
//                 if (index > 0) {
//                   _focusNodes[index - 1].requestFocus();
//                 }
//               }
//             },
//           ),
//         );
//       }),
//     );
//   }
//
//   @override
//   void dispose() {
//     _focusNodes.forEach((node) => node.dispose());
//     _controllers.forEach((controller) => controller.dispose());
//     super.dispose();
//   }
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'OTP TextField Demo',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('OTP TextField Demo'),
//         ),
//         body: Center(
//           child: Padding(
//             padding: EdgeInsets.all(20),
//             child: OtpTextField(
//               onCompleted: (String value) {
//                 print('Entered OTP is $value');
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// void main() {
//   runApp(MyApp());
// }
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class Division {
//   final int id;
//   final String name;
//
//   Division({required this.id, required this.name});
// }
//
//
//
//
//
// class MultiSelectDivision extends StatelessWidget {
//   final List<Division> divisions = [
//     Division(id: 1, name: 'Division 1'),
//     Division(id: 2, name: 'Division 2'),
//     Division(id: 3, name: 'Division 3'),
//     Division(id: 4, name: 'Division 4'),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//
//     print('run');
//     final provider = Provider.of<DivisionProvider>(context, listen: false);
//     return ElevatedButton(
//           child: Text('Select Divisions'),
//
//         );
//
//   }
// }
//
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => DivisionProvider(),
//       child: MaterialApp(
//         title: 'Multi-Select Division',
//         home: MultiSelectDivision(),
//       ),
//     );
//   }
// }



// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(
//           create: (context) => ProductListt(),
//         ),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Product List',
//         home: ProductListScreen(),
//       ),
//     );
//   }
// }
//
// class ProductListScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Product List'),
//       ),
//       body: Consumer<ProductListt>(
//         builder: (context, productList, child) {
//           print(productList.selectecProducts);
//           return ListView.builder(
//             itemCount: productList.products.length,
//             itemBuilder: (context, index) {
//               final product = productList.products[index];
//               final isSelected = productList.isSelected(product);
//
//               return InkWell(
//                 onLongPress: () {
//                   productList.toggleSelection(product);
//                 },
//                 onTap: () {
//                   if (productList.isSelectionMode) {
//                     productList.toggleSelection(product);
//                   } else {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ProductDetailScreen(product),
//                       ),
//                     );
//                   }
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     border: isSelected
//                         ? Border.all(color: Colors.blue, width: 2.0)
//                         : null,
//                   ),
//                   padding: const EdgeInsets.all(16.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(product.name,
//                                 style: const TextStyle(fontSize: 18.0)),
//                             Text(product.description,
//                                 style: const TextStyle(fontSize: 14.0)),
//                           ],
//                         ),
//                       ),
//                       if (isSelected)
//                         const Icon(
//                           CupertinoIcons.check_mark_circled_solid,
//                           color: Colors.blue,
//                         ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//
// class ProductDetailScreen extends StatelessWidget {
//   final Item product;
//
//    ProductDetailScreen(this.product);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(product.name),
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(product.name, style: const TextStyle(fontSize: 24.0)),
//             Text(product.description, style: const TextStyle(fontSize: 18.0)),
//             const SizedBox(height: 16.0),
//             Text('Price: \$${product.price}',
//                 style: const TextStyle(fontSize: 18.0)),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ProductListt extends ChangeNotifier {
//   List<Item> _products = [
//     Item('Product 1', 'Description 1', 10.0),
//     Item('Product 2', 'Description 2', 20.0),
//     Item('Product 3', 'Description 3', 30.0),
//   ];
//   List<Item> _selectedProducts = [];
//   List<Item> get selectecProducts => _selectedProducts;
//
//   bool get isSelectionMode => _selectedProducts.isNotEmpty;
//
//   List<Item> get products => _products;
//
//   void toggleSelection(Item product) {
//     if (_selectedProducts.contains(product)) {
//       _selectedProducts.remove(product);
//     } else {
//       _selectedProducts.add(product);
//     }
//     notifyListeners();
//   }
//
//   bool isSelected(Item product) {
//     return _selectedProducts.contains(product);
//   }
//
//   void clearSelection() {
//     _selectedProducts.clear();
//     notifyListeners();
//   }
// }
//
// class Item {
//   final String name;
//   final String description;
//   final double price;
//
//   Item(this.name, this.description, this.price);
// }


// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class CartItem {
//   final String productId;
//   final String packingType;
//   final double price;
//   int quantity;
//
//   CartItem({
//     required this.productId,
//     required this.packingType,
//     required this.price,
//     this.quantity = 1,
//   });
//
//   double get total => price * quantity;
//
//   Map<String, dynamic> toJson() {
//     return {
//       'product_id': productId,
//       'packing_type': packingType,
//       'price': price,
//       'quantity': quantity,
//     };
//   }
//
//   factory CartItem.fromJson(Map<String, dynamic> json) {
//     return CartItem(
//       productId: json['product_id'],
//       packingType: json['packing_type'],
//       price: json['price'],
//       quantity: json['quantity'] ?? 1,
//     );
//   }
// }
//
// class CartModel with ChangeNotifier {
//   late SharedPreferences _prefs;
//   static const _cartKey = 'cart';
//
//   List<CartItem> _items = [
//     CartItem(productId: "61135e6634b5814ab534f20f", packingType: "Strip", price: 50),
//     CartItem(productId: "61135e6634b5814ab534f210", packingType: "Strip", price: 60),
//     CartItem(productId: "61135e6634b5814ab534f211", packingType: "Vial", price: 10),
//     CartItem(productId: "61135e6634b5814ab534f214", packingType: "Box", price: 100),
//
//   ];
//
//   List<CartItem> get items => List.unmodifiable(_items);
//
//   double get total => _items.fold(0, (sum, item) => sum + item.total);
//
//   int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);
//
//   CartModel() {
//     _initPrefs();
//   }
//
//   void _initPrefs() async {
//     _prefs = await SharedPreferences.getInstance();
//     final cartData = _prefs.getString(_cartKey);
//     if (cartData != null) {
//       final cartJson = jsonDecode(cartData) as List<dynamic>;
//       _items = cartJson.map((json) => CartItem.fromJson(json)).toList();
//       notifyListeners();
//     }
//   }
//
//   void _savePrefs() {
//     final cartJson = jsonEncode(_items.map((item) => item.toJson()).toList());
//     _prefs.setString(_cartKey, cartJson);
//   }
//
//   void addItem(String productId, String packingType, double price) {
//     final existingIndex = _items.indexWhere(
//           (item) => item.productId == productId && item.packingType == packingType,
//     );
//     if (existingIndex >= 0) {
//       _items[existingIndex].quantity++;
//     } else {
//       _items.add(CartItem(
//         productId: productId,
//         packingType: packingType,
//         price: price,
//       ));
//     }
//     notifyListeners();
//     _savePrefs();
//   }
//
//   void updateItem(String productId, String packingType, int quantity) {
//     final existingIndex = _items.indexWhere(
//           (item) => item.productId == productId && item.packingType == packingType,
//     );
//     if (existingIndex >= 0) {
//       if (quantity <= 0) {
//         removeItem(productId, packingType);
//       } else {
//         _items[existingIndex].quantity = quantity;
//         notifyListeners();
//         _savePrefs();
//       }
//     }
//   }
//
//   void removeItem(String productId, String packingType) {
//     _items.removeWhere(
//           (item) => item.productId == productId && item.packingType == packingType,
//     );
//     notifyListeners();
//     _savePrefs();
//   }
//
//   void clear() {
//     _items.clear();
//     notifyListeners();
//     _savePrefs();
//   }
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => CartModel(),
//       child: MaterialApp(
//         home: Scaffold(
//           appBar: AppBar(
//             title: Text('My App'),
//           ),
//           body: Consumer<CartModel>(
//             builder: (context, cart, child) {
//               return Column(
//                 children: [
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: cart.itemCount,
//                       itemBuilder: (context, index) {
//                         final item = cart.items[index];
//                         return ListTile(
//                           title: Text('${item.quantity} x ${item.packingType}'),
//                           subtitle: Text('${item.price} each'),
//                           trailing: IconButton(
//                             icon: Icon(Icons.delete),
//                             onPressed: () {
//                               cart.removeItem(item.productId, item.packingType);
//                             },
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   Divider(),
//                   ListTile(
//                     title: Text('Total: ${cart.total}'),
//                     trailing: ElevatedButton(
//                       child: Text('Checkout'),
//                       onPressed: () {
//                         // Implement checkout logic here
//                       },
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// void main() {
//   runApp(MyApp());
// }

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class Product {
//   final String id;
//   final String name;
//   final double price;
//   final String packing;
//   final String packingType;
//   int quantity;
//
//   Product({
//     required this.id,
//     required this.name,
//     required this.price,
//     required this.packing,
//     required this.packingType,
//     this.quantity = 1,
//   });
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'price': price,
//       'packing': packing,
//       'packingType': packingType,
//       'quantity': quantity,
//     };
//   }
// }
//
// class CartModel extends ChangeNotifier {
//   late SharedPreferences _prefs;
//   final List<Product> _cartItems = [];
//
//   CartModel() {
//     _initSharedPreferences();
//     _loadCartItemsFromSharedPreferences();
//   }
//
//   List<Product> get cartItems => _cartItems;
//
//   void addToCart(Product product) async {
//     int index = _cartItems.indexWhere((item) => item.id == product.id);
//     if (index != -1) {
//       _cartItems[index].quantity += 1;
//     } else {
//       _cartItems.add(product);
//     }
//     await _saveCartItemsToSharedPreferences();
//     notifyListeners();
//   }
//
//   void removeFromCart(Product product) async {
//     int index = _cartItems.indexWhere((item) => item.id == product.id);
//     if (index != -1) {
//       _cartItems[index].quantity -= 1;
//       if (_cartItems[index].quantity == 0) {
//         _cartItems.removeAt(index);
//       }
//       await _saveCartItemsToSharedPreferences();
//       notifyListeners();
//     }
//   }
//
//   double get totalPrice {
//     double sum = 0;
//     _cartItems.forEach((item) {
//       sum += item.price * item.quantity;
//     });
//     return sum;
//   }
//
//   void _initSharedPreferences() async {
//     _prefs = await SharedPreferences.getInstance();
//   }
//
//   void _loadCartItemsFromSharedPreferences() {
//     List<String> itemsJsonString = _prefs.getStringList('cart_items') ?? [];
//     _cartItems.clear();
//     itemsJsonString.forEach((itemJsonString) {
//       Map<String, dynamic> itemJson = json.decode(itemJsonString);
//       Product item = Product(
//         id: itemJson['id'],
//         name: itemJson['name'],
//         price: itemJson['price'].toDouble(),
//         packing: itemJson['packing'],
//         packingType: itemJson['packingType'],
//         quantity: itemJson['quantity'],
//       );
//       _cartItems.add(item);
//     });
//   }
//
//   Future<void> _saveCartItemsToSharedPreferences() async {
//     List<String> itemsJsonString =
//     _cartItems.map((item) => json.encode(item.toJson())).toList();
//     await _prefs.setStringList('cart_items', itemsJsonString);
//   }
// }
//
// class CartPage extends StatelessWidget {
//   const CartPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Cart'),
//         ),
//         body: Consumer<CartModel>(
//         builder: (context, cart, child) {
//       return ListView.builder(
//           itemCount: cart.cartItems.length,
//           itemBuilder: (context, index) {
//         return ListTile(
//             title: Text(cart.cartItems[index].name),
//     subtitle: Text(cart.cartItems[index].packing),
//     trailing: Text('${cart.cartItems[index].quantity} x ${cart.cartItems[index].price.toStringAsFixed(2)} = ${(cart.cartItems[index].quantity * cart.cartItems[index].price).toStringAsFixed(2)}'),
//           leading: IconButton(
//             icon: Icon(Icons.remove),
//             onPressed: () {
//               cart.removeFromCart(cart.cartItems[index]);
//             },
//           ),
//         );
//           },
//       );
//         },
//         ),
//     );
//   }
// }
//
// class ProductPage extends StatelessWidget {
//   const ProductPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Products'),
//       ),
//       body: ListView.builder(
//         itemCount: products.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(products[index].name),
//             subtitle: Text('${products[index].packing} ${products[index].packingType}'),
//             trailing: ElevatedButton(
//               child: Text('Add to cart'),
//               onPressed: () {
//                 Provider.of<CartModel>(context,listen: false)
//                     .addToCart(products[index]);
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// final List<Product> products = [
//   Product(
//     id: '1',
//     name: 'Product 1',
//     price: 1.99,
//     packing: '500',
//     packingType: 'g',
//   ),
//   Product(
//     id: '2',
//     name: 'Product 2',
//     price: 2.49,
//     packing: '1',
//     packingType: 'kg',
//   ),
//   Product(
//     id: '3',
//     name: 'Product 3',
//     price: 0.99,
//     packing: '250',
//     packingType: 'g',
//   ),
// ];
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => CartModel(),
//       child: MaterialApp(
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: ProductPage(),
//       ),
//     );
//   }
// }



// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:path_provider/path_provider.dart' as path_provider;
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // initialize Hive
//   var appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
//   Hive.init(appDocumentDirectory.path);
//   // register the ImageModel adapter
//   Hive.registerAdapter(ImageModelAdapter());
//   // open the box
//   var box = await Hive.openBox<ImageModel>('imageBox');
//   // save an example image
//   var imageBytes = Uint8List.fromList([0, 1, 2, 3, 4]);
//   var imageName = 'exampleImage';
//   var imageModel = ImageModel(name: imageName, imageBytes: imageBytes);
//   await box.put(imageName, imageModel);
//   // retrieve the image
//   var retrievedImageModel = box.get(imageName);
//   print('Retrieved image name: ${retrievedImageModel?.name}');
//   print('Retrieved image bytes: ${retrievedImageModel?.imageBytes}');
//   // close the box
//   await box.close();
//   // close Hive
//   Hive.close();
// }
//
// class ImageModel {
//   final String name;
//   final Uint8List imageBytes;
//
//   ImageModel({required this.name, required this.imageBytes});
// }
//
// class ImageModelAdapter extends TypeAdapter<ImageModel> {
//   @override
//   final int typeId = 0;
//
//   @override
//   ImageModel read(BinaryReader reader) {
//     var name = reader.read();
//     var bytes = reader.read();
//     return ImageModel(name: name, imageBytes: bytes);
//   }
//
//   @override
//   void write(BinaryWriter writer, ImageModel obj) {
//     writer.write(obj.name);
//     writer.write(obj.imageBytes);
//   }
// }

//
// import 'dart:async';
// import 'dart:convert';
// import 'dart:math';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//



// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   final List<String> _imageUrls = [
//     'https://clientapps.webhopers.com:3069/core/uploads/products/img/minol.jpg',
//     'https://picsum.photos/id/2/200/300',
//     'https://picsum.photos/id/3/200/300',
//   ];
//   final String _listName = 'My Image List';
//   ImageList? _imageList;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image List Demo'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: _saveImageList,
//               child: Text('Save Image List'),
//             ),
//             SizedBox(height: 16),
//             Center(
//               child: _imageList == null
//                   ? Text('Image list not loaded.')
//                   : Container(
//                     height: 300,
//                 width: 300,
//                 child: GridView.builder(
//                 itemCount: _imageList!.images.length,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 8,
//                     mainAxisSpacing: 8,
//                 ),
//                 itemBuilder: (context, index) {
//                     final bytes = _imageList!.images[index];
//                     return Image.memory(bytes);
//                 },
//               ),
//                   ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _loadImageList,
//         tooltip: 'Load Image List',
//         child: Icon(Icons.file_download),
//       ),
//     );
//   }
//
//   Future<void> _saveImageList() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final List<String>? imageNames = prefs.getStringList('imageNames');
//     if (imageNames != null) {
//       List<Uint8List> images = [];
//       for (final String name in imageNames) {
//         final String? imageData = prefs.getString(name);
//         if (imageData != null) {
//           images.add(base64Decode(imageData));
//         }
//       }
//       setState(() {
//         savedImages = images;
//       });
//     }
//
//     // final prefs = await SharedPreferences.getInstance();
//     //
//     // // convert image URLs to bytes and save as a list of base64-encoded strings
//     // final imageBytes = await Future.wait(_imageUrls.map((url) => _getImageBytes(url)));
//     // final encodedImages = imageBytes.map((bytes) => base64.encode(bytes)).toList();
//     //
//     // // create a map to store the image list data
//     // final imageListData = {
//     //   'name': _listName,
//     //   'images': encodedImages,
//     // };
//     //
//     // // save the image list data as a JSON-encoded string in SharedPreferences
//     // await prefs.setString('imageList', jsonEncode(imageListData));
//   }
//
//   Future<void> _loadImageList() async {
//     final prefs = await SharedPreferences.getInstance();
//
//     // retrieve the image list data from SharedPreferences
//     final json = prefs.getString('imageList');
//     if (json == null) {
//       print('Image list not found.');
//       return;
//     }
//
//     // parse the image list data from JSON
//     final data = jsonDecode(json);
//     final name = data['name'] as String;
//     final encodedImages = (data['images'] as List<dynamic>).cast<String>();
//
//     // convert the base64-encoded strings to bytes
//     final imageBytes = encodedImages.map((encodedImage) => base64.decode(encodedImage)).toList();
//
//     // create an ImageList object
//     final imageList = ImageList(name: name, images: imageBytes);
//     setState(() {
//       _imageList = imageList;
//     });
//
//     // print the image list data to the console
//     print('Image list name: ${imageList.name}');
//     for (int i = 0; i < imageList.images.length; i++) {
//        final bytes = imageList.images[i];
//       print('Image ${i + 1}: ${bytes.length} bytes');
//     }
//   }
//
//   Future<Uint8List> _getImageBytes(String url) async {
//     // TODO: implement image download using http or other library
//     // for demo purposes, return random bytes
//     final random = Random();
//     return Uint8List.fromList(List.generate(1024, (_) => random.nextInt(256)));
//   }
// }
//
// // define a class to represent an image list
// class ImageList {
//   final String name;
//   final List<Uint8List> images;
//
//   ImageList({required this.name, required this.images});
//
//   // convert the image list to a map
//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'images': images.map((image) => image.toList()).toList(),
//     };
//   }
//
//   // create an ImageList object from a map
//   factory ImageList.fromMap(Map<String, dynamic> map) {
//     return ImageList(
//       name: map['name'],
//       images: (map['images'] as List<List<int>>).map((image) => Uint8List.fromList(image)).toList(),
//     );
//   }
// }
//

// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'Image List Demo',
//       home: ImageList(
//           imageURLs: [
//             'https://clientapps.webhopers.com:3069/core/uploads/products/img/CEPOVISE –CV.jpg',
//             "https://clientapps.webhopers.com:3069/core/uploads/products/vis/LUDONAZE-B@@LUDONAZE-LS.jpg"
//           ],
//           listName: 'Avi'),
//     );
//   }
// }
//
// class ImageModel {
//   String name;
//   Uint8List imageBytes;
//
//   ImageModel({
//     required this.name,
//     required this.imageBytes,
//   });
// }
//
// class ImageList extends StatefulWidget {
//   final List<String> imageURLs;
//   final String listName;
//
//   const ImageList({
//     Key? key,
//     required this.imageURLs,
//     required this.listName,
//   }) : super(key: key);
//
//   @override
//   _ImageListState createState() => _ImageListState();
// }
//
// class _ImageListState extends State<ImageList> {
//   List<ImageModel> savedImages = [];
//
//   @override
//   void initState() {
//     super.initState();
//    // getSavedImages();
//   }
//
//   Future<void> saveImage() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String> imageNames = [];
//     for (final String url in widget.imageURLs) {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         print('connected');
//         final imageBytes = response.bodyBytes;
//         final imageName = url.split('/').last;
//         final imageModel = ImageModel(name: imageName, imageBytes: imageBytes);
//         //savedImages.add(imageModel);
//         await prefs.setString(imageName, base64.encode(imageBytes));
//         imageNames.add(imageName);
//       }else{
//         print('not connected');
//       }
//     }
//     await prefs.setStringList(widget.listName, imageNames);
//   }
//
//   Future<void> getSavedImages() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final List<String>? imageNames = prefs.getStringList(widget.listName);
//     if (imageNames != null) {
//       List<ImageModel> images = [];
//       for (final String name in imageNames) {
//         final String? imageData = prefs.getString(name);
//         if (imageData != null) {
//           images.add(
//               ImageModel(
//             name: name,
//             imageBytes: base64Decode(imageData),
//           ));
//         }
//       }
//       setState(() {
//         savedImages = images;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.listName),
//         actions: [
//           IconButton(
//               onPressed: saveImage,
//               icon: Icon(Icons.add)),
//           IconButton(
//               onPressed: (){
//                 savedImages.clear();
//               },
//               icon: Icon(Icons.delete))
//         ],
//       ),
//       body: savedImages.isNotEmpty
//           ? GridView.builder(
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//         ),
//         itemCount: savedImages.length,
//         itemBuilder: (context, index) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(savedImages[index].name),
//               Image.memory(
//                 savedImages[index].imageBytes,
//                 fit: BoxFit.cover,
//               ),
//             ],
//           );
//         },
//       )
//           : const Center(
//         child: Text('No saved images'),
//
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: getSavedImages,
//         tooltip: 'Load Image List',
//         child: Icon(Icons.file_download),
//       ),
//     );
//   }
// }
//

// import 'dart:convert';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class ImageData {
//   String name;
//   String imageUrl;
//
//   ImageData({required this.name, required this.imageUrl});
//
//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'imageUrl': imageUrl,
//     };
//   }
//
//   factory ImageData.fromMap(Map<String, dynamic> map) {
//     return ImageData(
//       name: map['name'],
//       imageUrl: map['imageUrl'],
//     );
//   }
// }
//
// class PresentationData {
//   String name;
//   List<ImageData> images;
//
//   PresentationData({required this.name, required this.images});
//
//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'images': images.map((e) => e.toMap()).toList(),
//     };
//   }
//
//   factory PresentationData.fromMap(Map<String, dynamic> map) {
//     return PresentationData(
//       name: map['name'],
//       images: List<ImageData>.from(map['images'].map((e) => ImageData.fromMap(e))),
//     );
//   }
// }
//
// Future<void> savePresentation(PresentationData presentation) async {
//   final prefs = await SharedPreferences.getInstance();
//   final presentations = prefs.getStringList('presentations') ?? [];
//
//   final presentationMap = presentation.toMap();
//
//   final index = presentations.indexWhere((element) => element == presentationMap['name']);
//   if (index >= 0) {
//     presentations[index] = json.encode(presentationMap);
//   } else {
//     presentations.add(json.encode(presentationMap));
//   }
//
//   await prefs.setStringList('presentations', presentations);
// }
//
// Future<List<PresentationData>> loadPresentations() async {
//   final prefs = await SharedPreferences.getInstance();
//   final presentations = prefs.getStringList('presentations') ?? [];
//
//   return presentations.map((e) => PresentationData.fromMap(json.decode(e))).toList();
// }
//
// class PresentationListScreen extends StatefulWidget {
//
//   @override
//   State<PresentationListScreen> createState() => _PresentationListScreenState();
// }
//
// class _PresentationListScreenState extends State<PresentationListScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Presentations'),
//           actions: [
//             IconButton(
//                 onPressed: () async {
//                   final presentation = PresentationData(
//                     name: 'My Presentation',
//                     images: [
//                       ImageData(name: 'Image 1', imageUrl: "https://clientapps.webhopers.com:3069/core/uploads/products/vis/123.jpg"),
//                       ImageData(name: 'Image 2', imageUrl: "https://clientapps.webhopers.com:3069/core/uploads/products/vis/123.jpg"),
//                     ],
//                   );
//                   await savePresentation(presentation);
//                 },
//                 icon: const Icon(Icons.save))
//           ],
//         ),
//         body: FutureBuilder<List<PresentationData>>(
//         future: loadPresentations(),
//     builder: (context, snapshot) {
//     if (snapshot.hasData) {
//     final presentations = snapshot.data!;
//
//     if (presentations.isEmpty) {
//     return const Center(
//     child: Text('No presentations found.'),
//     );
//     }
//
//     return ListView.builder(
//     itemCount: presentations.length,
//     itemBuilder: (context, index) {
//     final presentation = presentations[index];
//
//     return ListTile(
//     title: Text(presentation.name),
//     subtitle: Text('${presentation.images.length} images'),
//     onTap: () {
//       Navigator.push(context, MaterialPageRoute(builder: (context) => PresentationScreen(presentation: presentation,)));
//       // navigate to a screen to display the presentation
//     },
//     );
//     },
//     );
//     } else if (snapshot.hasError) {
//       return Center(
//         child: Text('Error loading presentations: ${snapshot.error}'),
//       );
//     } else {
//       return const Center(
//         child: CircularProgressIndicator(),
//       );
//     }
//     },
//         ),
//     );
//   }
// }
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Image List Demo',
//       home: PresentationListScreen()
//     );
//   }
// }
//
// class PresentationScreen extends StatelessWidget {
//   final PresentationData presentation;
//
//   const PresentationScreen({Key? key, required this.presentation}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(presentation.name),
//       ),
//       body: PageView(
//         children: presentation.images.map((e) =>
//             CachedNetworkImage(
//               imageUrl: e.imageUrl,
//               placeholder: (context, url) => const CircularProgressIndicator(),
//               errorWidget: (context, url, error) => const Icon(Icons.error),
//             )
//             //Image.network(e.imageUrl)
//       ).toList(),
//       ),
//     );
//   }
// }


// import 'dart:async';
// import 'dart:io' show Platform;
//
// import 'package:baseflow_plugin_template/baseflow_plugin_template.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
//
// /// Defines the main theme color.
// final MaterialColor themeMaterialColor =
// BaseflowPluginExample.createMaterialColor(
//     const Color.fromRGBO(48, 49, 60, 1));
//
// void main() {
//   runApp(const GeolocatorWidget());
// }
//
// /// Example [Widget] showing the functionalities of the geolocator plugin
// class GeolocatorWidget extends StatefulWidget {
//   /// Creates a new GeolocatorWidget.
//   const GeolocatorWidget({Key? key}) : super(key: key);
//
//   /// Utility method to create a page with the Baseflow templating.
//   static ExamplePage createPage() {
//     return ExamplePage(
//         Icons.location_on, (context) => const GeolocatorWidget());
//   }
//
//   @override
//   _GeolocatorWidgetState createState() => _GeolocatorWidgetState();
// }
//
// class _GeolocatorWidgetState extends State<GeolocatorWidget> {
//   static const String _kLocationServicesDisabledMessage =
//       'Location services are disabled.';
//   static const String _kPermissionDeniedMessage = 'Permission denied.';
//   static const String _kPermissionDeniedForeverMessage =
//       'Permission denied forever.';
//   static const String _kPermissionGrantedMessage = 'Permission granted.';
//
//   final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
//   final List<_PositionItem> _positionItems = <_PositionItem>[];
//   StreamSubscription<Position>? _positionStreamSubscription;
//   StreamSubscription<ServiceStatus>? _serviceStatusStreamSubscription;
//   bool positionStreamStarted = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _toggleServiceStatusStream();
//   }
//
//   PopupMenuButton _createActions() {
//     return PopupMenuButton(
//       elevation: 40,
//       onSelected: (value) async {
//         switch (value) {
//           case 1:
//             _getLocationAccuracy();
//             break;
//           case 2:
//             _requestTemporaryFullAccuracy();
//             break;
//           case 3:
//             _openAppSettings();
//             break;
//           case 4:
//             _openLocationSettings();
//             break;
//           case 5:
//             setState(_positionItems.clear);
//             break;
//           default:
//             break;
//         }
//       },
//       itemBuilder: (context) => [
//         if (Platform.isIOS)
//           const PopupMenuItem(
//             child: Text("Get Location Accuracy"),
//             value: 1,
//           ),
//         if (Platform.isIOS)
//           const PopupMenuItem(
//             child: Text("Request Temporary Full Accuracy"),
//             value: 2,
//           ),
//         const PopupMenuItem(
//           child: Text("Open App Settings"),
//           value: 3,
//         ),
//         if (Platform.isAndroid || Platform.isWindows)
//           const PopupMenuItem(
//             child: Text("Open Location Settings"),
//             value: 4,
//           ),
//         const PopupMenuItem(
//           child: Text("Clear"),
//           value: 5,
//         ),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     const sizedBox = SizedBox(
//       height: 10,
//     );
//
//     return BaseflowPluginExample(
//         pluginName: 'Geolocator',
//         githubURL: 'https://github.com/Baseflow/flutter-geolocator',
//         pubDevURL: 'https://pub.dev/packages/geolocator',
//         appBarActions: [
//           _createActions()
//         ],
//         pages: [
//           ExamplePage(
//             Icons.location_on,
//                 (context) => Scaffold(
//               backgroundColor: Theme.of(context).backgroundColor,
//               body: ListView.builder(
//                 itemCount: _positionItems.length,
//                 itemBuilder: (context, index) {
//                   final positionItem = _positionItems[index];
//
//                   if (positionItem.type == _PositionItemType.log) {
//                     return ListTile(
//                       title: Text(positionItem.displayValue,
//                           textAlign: TextAlign.center,
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           )),
//                     );
//                   } else {
//                     return Card(
//                       child: ListTile(
//                         tileColor: themeMaterialColor,
//                         title: Text(
//                           positionItem.displayValue,
//                           style: const TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     );
//                   }
//                 },
//               ),
//               floatingActionButton: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   FloatingActionButton(
//                     child: (_positionStreamSubscription == null ||
//                         _positionStreamSubscription!.isPaused)
//                         ? const Icon(Icons.play_arrow)
//                         : const Icon(Icons.pause),
//                     onPressed: () {
//                       positionStreamStarted = !positionStreamStarted;
//                       _toggleListening();
//                     },
//                     tooltip: (_positionStreamSubscription == null)
//                         ? 'Start position updates'
//                         : _positionStreamSubscription!.isPaused
//                         ? 'Resume'
//                         : 'Pause',
//                     backgroundColor: _determineButtonColor(),
//                   ),
//                   sizedBox,
//                   FloatingActionButton(
//                     child: const Icon(Icons.my_location),
//                     onPressed: _getCurrentPosition,
//                   ),
//                   sizedBox,
//                   FloatingActionButton(
//                     child: const Icon(Icons.bookmark),
//                     onPressed: _getLastKnownPosition,
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ]);
//   }
//
//   Future<void> _getCurrentPosition() async {
//     final hasPermission = await _handlePermission();
//
//     if (!hasPermission) {
//       return;
//     }
//
//     final position = await _geolocatorPlatform.getCurrentPosition();
//     _updatePositionList(
//       _PositionItemType.position,
//       position.toString(),
//     );
//   }
//
//   Future<bool> _handlePermission() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     // Test if location services are enabled.
//     serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled don't continue
//       // accessing the position and request users of the
//       // App to enable the location services.
//       _updatePositionList(
//         _PositionItemType.log,
//         _kLocationServicesDisabledMessage,
//       );
//
//       return false;
//     }
//
//     permission = await _geolocatorPlatform.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await _geolocatorPlatform.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied, next time you could try
//         // requesting permissions again (this is also where
//         // Android's shouldShowRequestPermissionRationale
//         // returned true. According to Android guidelines
//         // your App should show an explanatory UI now.
//         _updatePositionList(
//           _PositionItemType.log,
//           _kPermissionDeniedMessage,
//         );
//
//         return false;
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       _updatePositionList(
//         _PositionItemType.log,
//         _kPermissionDeniedForeverMessage,
//       );
//
//       return false;
//     }
//
//     // When we reach here, permissions are granted and we can
//     // continue accessing the position of the device.
//     _updatePositionList(
//       _PositionItemType.log,
//       _kPermissionGrantedMessage,
//     );
//     return true;
//   }
//
//   void _updatePositionList(_PositionItemType type, String displayValue) {
//     _positionItems.add(_PositionItem(type, displayValue));
//     setState(() {});
//   }
//
//   bool _isListening() => !(_positionStreamSubscription == null ||
//       _positionStreamSubscription!.isPaused);
//
//   Color _determineButtonColor() {
//     return _isListening() ? Colors.green : Colors.red;
//   }
//
//   void _toggleServiceStatusStream() {
//     if (_serviceStatusStreamSubscription == null) {
//       final serviceStatusStream = _geolocatorPlatform.getServiceStatusStream();
//       _serviceStatusStreamSubscription =
//           serviceStatusStream.handleError((error) {
//             _serviceStatusStreamSubscription?.cancel();
//             _serviceStatusStreamSubscription = null;
//           }).listen((serviceStatus) {
//             String serviceStatusValue;
//             if (serviceStatus == ServiceStatus.enabled) {
//               if (positionStreamStarted) {
//                 _toggleListening();
//               }
//               serviceStatusValue = 'enabled';
//             } else {
//               if (_positionStreamSubscription != null) {
//                 setState(() {
//                   _positionStreamSubscription?.cancel();
//                   _positionStreamSubscription = null;
//                   _updatePositionList(
//                       _PositionItemType.log, 'Position Stream has been canceled');
//                 });
//               }
//               serviceStatusValue = 'disabled';
//             }
//             _updatePositionList(
//               _PositionItemType.log,
//               'Location service has been $serviceStatusValue',
//             );
//           });
//     }
//   }
//
//   void _toggleListening() {
//     if (_positionStreamSubscription == null) {
//       final positionStream = _geolocatorPlatform.getPositionStream();
//       _positionStreamSubscription = positionStream.handleError((error) {
//         _positionStreamSubscription?.cancel();
//         _positionStreamSubscription = null;
//       }).listen((position) => _updatePositionList(
//         _PositionItemType.position,
//         position.toString(),
//       ));
//       _positionStreamSubscription?.pause();
//     }
//
//     setState(() {
//       if (_positionStreamSubscription == null) {
//         return;
//       }
//
//       String statusDisplayValue;
//       if (_positionStreamSubscription!.isPaused) {
//         _positionStreamSubscription!.resume();
//         statusDisplayValue = 'resumed';
//       } else {
//         _positionStreamSubscription!.pause();
//         statusDisplayValue = 'paused';
//       }
//
//       _updatePositionList(
//         _PositionItemType.log,
//         'Listening for position updates $statusDisplayValue',
//       );
//     });
//   }
//
//   @override
//   void dispose() {
//     if (_positionStreamSubscription != null) {
//       _positionStreamSubscription!.cancel();
//       _positionStreamSubscription = null;
//     }
//
//     super.dispose();
//   }
//
//   void _getLastKnownPosition() async {
//     final position = await _geolocatorPlatform.getLastKnownPosition();
//     if (position != null) {
//       _updatePositionList(
//         _PositionItemType.position,
//         position.toString(),
//       );
//     } else {
//       _updatePositionList(
//         _PositionItemType.log,
//         'No last known position available',
//       );
//     }
//   }
//
//   void _getLocationAccuracy() async {
//     final status = await _geolocatorPlatform.getLocationAccuracy();
//     _handleLocationAccuracyStatus(status);
//   }
//
//   void _requestTemporaryFullAccuracy() async {
//     final status = await _geolocatorPlatform.requestTemporaryFullAccuracy(
//       purposeKey: "TemporaryPreciseAccuracy",
//     );
//     _handleLocationAccuracyStatus(status);
//   }
//
//   void _handleLocationAccuracyStatus(LocationAccuracyStatus status) {
//     String locationAccuracyStatusValue;
//     if (status == LocationAccuracyStatus.precise) {
//       locationAccuracyStatusValue = 'Precise';
//     } else if (status == LocationAccuracyStatus.reduced) {
//       locationAccuracyStatusValue = 'Reduced';
//     } else {
//       locationAccuracyStatusValue = 'Unknown';
//     }
//     _updatePositionList(
//       _PositionItemType.log,
//       '$locationAccuracyStatusValue location accuracy granted.',
//     );
//   }
//
//   void _openAppSettings() async {
//     final opened = await _geolocatorPlatform.openAppSettings();
//     String displayValue;
//
//     if (opened) {
//       displayValue = 'Opened Application Settings.';
//     } else {
//       displayValue = 'Error opening Application Settings.';
//     }
//
//     _updatePositionList(
//       _PositionItemType.log,
//       displayValue,
//     );
//   }
//
//   void _openLocationSettings() async {
//     final opened = await _geolocatorPlatform.openLocationSettings();
//     String displayValue;
//
//     if (opened) {
//       displayValue = 'Opened Location Settings';
//     } else {
//       displayValue = 'Error opening Location Settings';
//     }
//
//     _updatePositionList(
//       _PositionItemType.log,
//       displayValue,
//     );
//   }
// }
//
// enum _PositionItemType {
//   log,
//   position,
// }
//
// class _PositionItem {
//   _PositionItem(this.type, this.displayValue);
//
//   final _PositionItemType type;
//   final String displayValue;
// }

// import 'dart:convert';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart'as http;
// import 'package:pharma_clients_app/data/model/response_model/products/product_reponse_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class ProductService {
//   static const String apiUrl = 'https://clientapps.webhopers.com:3227/api/app/product/get';
//   static const String cacheKey = 'products';
//
//   Future<List<Products>> getProducts() async {
//     final connectivityResult = await Connectivity().checkConnectivity();
//     if (connectivityResult == ConnectivityResult.none) {
//       // If there is no internet connection, return cached products
//       return getCachedProducts();
//     } else {
//       // If there is an internet connection, load products from the API
//       final products = await loadProductsFromApi();
//       // Cache the products for future use
//       cacheProducts(products);
//       return products;
//     }
//   }
//
//   Future<List<Products>> loadProductsFromApi() async {
//     print('run');
//     final response = await http.post(Uri.parse(apiUrl));
//     if (response.statusCode == 200) {
//       final jsonList = json.decode(response.body) as List<dynamic>;
//       final products = jsonList.map((json) => Products.fromJson(json)).toList();
//       return products;
//     } else {
//       throw Exception('Failed to load products');
//     }
//   }
//
//   Future<List<Products>> getCachedProducts() async {
//     final prefs = await SharedPreferences.getInstance();
//     final jsonString = prefs.getString(cacheKey);
//     if (jsonString != null) {
//       final productsJson = json.decode(jsonString) as List<dynamic>;
//       final products = productsJson.map((json) => Products.fromJson(json)).toList();
//       return products;
//     }
//     return [];
//   }
//
//   Future<void> cacheProducts(List<Products> products) async {
//     final prefs = await SharedPreferences.getInstance();
//     final productsJson = products.map((product) => product.toJson()).toList();
//     final jsonString = json.encode(productsJson);
//     prefs.setString(cacheKey, jsonString);
//   }
// }
//
// class ProductCard extends StatelessWidget {
//   final Products product;
//
//   const ProductCard({Key? key, required this.product}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           //Image.network(product.i),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(product.name!),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class MyApp extends StatelessWidget {
//   final productService = ProductService();
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Product List',
//         theme: ThemeData(
//         primarySwatch: Colors.blue,
//     ),
//     home: Scaffold(
//     appBar: AppBar(
//     title: Text('Product List'),
//     ),
//     body: FutureBuilder<List<Products>>(
//     future: productService.getProducts(),
//     builder: (context, snapshot) {
//     if (snapshot.hasData) {
//     final products = snapshot.data!;
//     return ListView.builder(
//       itemCount: products.length,
//       itemBuilder: (context, index) {
//         final product = products[index];
//         return ProductCard(product: product);
//       },
//     );
//     } else if (snapshot.hasError) {
//       return Center(
//         child: Text('Error: ${snapshot.error}'),
//       );
//     } else {
//       return Center(
//         child: CircularProgressIndicator(),
//       );
//     }
//     },
//     ),
//     ),
//     );}}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharma_clients_app/view_model/afterLogin_viewModel/afterLogin_viewModels.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
   MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ProductViewModel model = ProductViewModel();

  @override
  void initState() {
    model.fetchProductsApi();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductViewModel>.value(value: model)
      ],
      child: MaterialApp(
        home: Products(),
      ),
    );
  }
}

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  ProductViewModel model = ProductViewModel();
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductViewModel>(
      builder: (BuildContext context, value, Widget? child) {
        print(value.products);
        return value.loading ? CircularProgressIndicator(): ListView.builder(
            itemBuilder: (ctx, index){
              return Text(value.products[index].name!);
            });
      },

    );
  }
}
