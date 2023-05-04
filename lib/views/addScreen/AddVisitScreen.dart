import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:pharma_clients_app/data/model/requested_data_model/addVisitEntity.dart';
import 'package:pharma_clients_app/utils/TextInputFields/text_field.dart';
import 'package:pharma_clients_app/utils/button.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../data/response/status.dart';
import '../../resources/app_colors.dart';
import '../../resources/constant_strings.dart';
import '../../utils/Dialogue/error_dialogue.dart';
import '../../utils/text_style.dart';
import '../../view_model/afterLogin_viewModel/afterLogin_viewModels.dart';

class AddVisitScreen extends StatefulWidget {
  const AddVisitScreen({Key? key}) : super(key: key);

  @override
  State<AddVisitScreen> createState() => _AddVisitScreenState();
}

class _AddVisitScreenState extends State<AddVisitScreen> {

  TextEditingController timeinput = TextEditingController();
  TextEditingController currentAddress = TextEditingController();
  TextEditingController message = TextEditingController();
  CustomersViewModel model = CustomersViewModel();
  ProductViewModel product = ProductViewModel();

  String? dropDownValue;
  var _chosenValue;
  Position? _currentPosition;

  _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
          _currentPosition = position;
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
        currentAddress.text = '${place.street}, '
            '${place.subLocality},'
            ' ${place.subAdministrativeArea}, '
            '${place.administrativeArea},'
            ' ${place.postalCode}';
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  void initState() {
    model.fetchCustomers();
    product.fetchProductsApi();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final addVisit = Provider.of<AddVisitViewModel>(context,listen: false);
    final provider = Provider.of<ProProvider>(context,listen: false);
    provider.selectedProducts.clear();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        title: TextWithStyle.appBarTitle(
            context, ConstantStrings.addVisitHeading),
        actions: [
          IconButton(
              onPressed: _getCurrentPosition,
              icon: Icon(Icons.my_location_outlined)
          )
        ],
      ),
      body: ChangeNotifierProvider(
        create: (BuildContext context) => product,
        child: Consumer<ProductViewModel>(
          builder: (BuildContext context, value, Widget? child) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 1.h,
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        margin: EdgeInsets.only(left: 1.5.h, right: 1.5.h),
                        padding: EdgeInsets.all(2.h),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(20)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryColor
                                  .withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            TextFormField(
                              style: TextStyle(fontSize: 18.sp),
                              controller: currentAddress,
                              maxLines: null,
                              textInputAction: TextInputAction.next,
                              onTap: (){
                                if(currentAddress.text.isEmpty){
                                  _getCurrentPosition();
                                }else{
                                  return;
                                }
                              },
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    const BorderRadius.all(
                                        Radius.circular(20)),
                                    borderSide: BorderSide(
                                        color: AppColors.primaryColor)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    const BorderRadius.all(
                                        Radius.circular(20)),
                                    borderSide: BorderSide(
                                        color: AppColors.primaryColor)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius:
                                    const BorderRadius.all(
                                        Radius.circular(20)),
                                    borderSide: BorderSide(
                                        color: Colors.red.shade700)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                    const BorderRadius.all(
                                        Radius.circular(20)),
                                    borderSide: BorderSide(
                                        color: Colors.red.shade700)),
                                contentPadding:
                                const EdgeInsets.fromLTRB(
                                    0, 20, 10, 20),
                                border: InputBorder.none,
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(2.w),
                                  child: Icon(
                                    CupertinoIcons.location_solid,
                                    size: 3.h,
                                  ),
                                ),
                                hintText: 'Enter your location',
                                labelText: 'Location',
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            TextFormField(
                              style: TextStyle(fontSize: 18.sp),
                              controller: timeinput,
                              readOnly: true,
                              onTap: () async {
                                TimeOfDay? pickedTime = await showTimePicker(
                                  initialTime: TimeOfDay.now(),
                                  context: context,
                                );
                                if (pickedTime != null) {
                                  DateTime parsedTime = DateTime(
                                    DateTime
                                        .now()
                                        .year,
                                    DateTime
                                        .now()
                                        .month,
                                    DateTime
                                        .now()
                                        .day,
                                    pickedTime.hour,
                                    pickedTime.minute,
                                  );
                                  String formattedTime = DateFormat('HH:mm:ss')
                                      .format(parsedTime);
                                  timeinput.text = formattedTime;
                                } else {
                                  if (kDebugMode) {
                                    print("Time is not selected");
                                  }
                                }
                              },
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    const BorderRadius.all(
                                        Radius.circular(20)),
                                    borderSide: BorderSide(
                                        color: AppColors.primaryColor)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    const BorderRadius.all(
                                        Radius.circular(20)),
                                    borderSide: BorderSide(
                                        color: AppColors.primaryColor)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius:
                                    const BorderRadius.all(
                                        Radius.circular(20)),
                                    borderSide: BorderSide(
                                        color: Colors.red.shade700)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                    const BorderRadius.all(
                                        Radius.circular(20)),
                                    borderSide: BorderSide(
                                        color: Colors.red.shade700)),
                                contentPadding:
                                const EdgeInsets.fromLTRB(
                                    0, 20, 10, 20),
                                border: InputBorder.none,
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(2.w),
                                  child: Icon(
                                    Icons.timer,
                                    size: 3.h,
                                  ),
                                ),
                                hintText: "Enter Time",
                                labelText: "Time",
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            TextInputField(
                              title: message,
                              icon: CupertinoIcons.mail_solid,
                              labelText: 'Message',
                              hintText: 'Enter your message',
                            ),
                            ChangeNotifierProvider<CustomersViewModel>(
                              create: (BuildContext context) => model,
                              child: Consumer<CustomersViewModel>(
                                builder: (BuildContext context, value,
                                    Widget? child) {
                                    switch (value.customersList.status!) {
                                      case Status.loading:
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      case Status.error:
                                        return ErrorDialogue(
                                            message: value.customersList.message);
                                      case Status.completed:
                                        return DropdownButtonFormField(
                                          value: _chosenValue,
                                          style: TextStyle(
                                              fontSize: 18.sp,
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20)),
                                                borderSide: BorderSide(
                                                    color: AppColors
                                                        .primaryColor)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20)),
                                                borderSide: BorderSide(
                                                    color: AppColors
                                                        .primaryColor)),
                                            errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20)),
                                                borderSide: BorderSide(
                                                    color: Colors.red.shade700)),
                                            focusedErrorBorder: OutlineInputBorder(
                                                borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20)),
                                                borderSide: BorderSide(
                                                    color: Colors.red.shade700)),
                                            border: InputBorder.none,
                                            prefixIcon: Padding(
                                              padding: EdgeInsets.all(2.w),
                                              child: Icon(
                                                Icons.people,
                                                size: 3.h,
                                              ),
                                            ),
                                            hintText: 'Select Customer',
                                            labelText: 'Customer',
                                          ),
                                          items: value.customersList.data!.data!
                                              .map<DropdownMenuItem>((value) {
                                            return DropdownMenuItem(
                                              value: value,
                                              child: Text(value.name!),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            _chosenValue = value;
                                          },
                                        );
                                    }},
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            InkWell(
                              onTap: () {
                                showModalBottomSheet<void>(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(5.h)
                                      )),
                                  isScrollControlled: true,
                                  isDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      height: 50.h,
                                      margin: EdgeInsets.fromLTRB(
                                          3.h, 5.h, 3.h, 5.h),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceAround,
                                        children: [
                                          TextWithStyle.customerName(
                                              context, 'Please Select Products:'),
                                          SizedBox(height: 1.h,),
                                          Expanded(
                                              child: ListView.builder(
                                                itemCount: value.products.length,
                                                itemBuilder: (BuildContext context, int index) {
                                                  final product = value.products[index];
                                                  return Consumer<ProProvider>(
                                                    builder: (BuildContext context, value, Widget? child) {
                                                      return CheckboxListTile(
                                                        activeColor: AppColors.primaryColor,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(2.h),
                                                        ),
                                                        checkboxShape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(2.h),
                                                        ),
                                                        title: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text(product.name!,
                                                                style: TextStyle(color: Colors.black54, fontSize: 18.sp)),
                                                            // TextWithStyle.productPrice(
                                                            //     context,
                                                            //     order.price?.toString() ?? '0'),
                                                          ],
                                                        ),
                                                        value: value.isSelected(product),
                                                        onChanged: (value){
                                                          if (value!) {
                                                            provider.addDivision(
                                                                product);
                                                          } else {
                                                            provider
                                                                .removeDivision(
                                                                product);
                                                          }
                                                          // selectPacking.toggleSelection(order);
                                                        },
                                                        //groupValue: value.isSelectionMode,
                                                      );
                                                    },
                                                  );
                                                },
                                              )),
                                          ElevatedButton(
                                            child: TextWithStyle
                                                .containerTitle(
                                                context, 'Ok'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          // Expanded(
                                          //     child: (product[index].packingVarient != null &&
                                          //         product[index].packingVarient?.length != 0)
                                          //         ? SingleChildScrollView(
                                          //       child: Consumer<SelectPacking>(
                                          //         builder: (BuildContext context, value, Widget? child) {
                                          //           return Column(
                                          //             mainAxisAlignment: MainAxisAlignment.center,
                                          //             mainAxisSize: MainAxisSize.min,
                                          //             children: product[index].packingVarient!.map((order){
                                          //               return CheckboxListTile(
                                          //                 activeColor: AppColors.primaryColor,
                                          //                 shape: RoundedRectangleBorder(
                                          //                   borderRadius: BorderRadius.circular(2.h),
                                          //                 ),
                                          //                 checkboxShape: RoundedRectangleBorder(
                                          //                   borderRadius: BorderRadius.circular(2.h),
                                          //                 ),
                                          //                 title: Row(
                                          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          //                   children: [
                                          //                     Expanded(
                                          //                       child: Text('${order.packingType!.label!}    (${order.packing})',
                                          //                           style: TextStyle(color: Colors.black54, fontSize: 18.sp)),
                                          //                     ),
                                          //                     TextWithStyle.productPrice(
                                          //                         context,
                                          //                         order.price?.toString() ?? '0'),
                                          //                   ],
                                          //                 ),
                                          //                 value: value.isSelected(order),
                                          //                 onChanged: (value){
                                          //                   selectPacking.toggleSelection(order);
                                          //                 },
                                          //                 //groupValue: value.isSelectionMode,
                                          //               );
                                          //             }).toList(),
                                          //           );
                                          //         },
                                          //       ),
                                          //     )
                                          //         : Text(product[index].packing ?? 'Na')
                                          // ),
                                          // Consumer<SelectPacking>(
                                          //   builder: (BuildContext context, value, Widget? child) {
                                          //     return Button(
                                          //       title: 'add',
                                          //       onPress: (){
                                          //         if(value._selectedProducts.isEmpty){
                                          //           Utils.flushBarErrorMessage('Please Select a Packing Type!!!', context);
                                          //         }else{
                                          //           final cart = context.read<Cart>();
                                          //           cart.addItem(
                                          //             CartEntity(
                                          //               id: product[index].id!,
                                          //               name: product[index].name!,
                                          //               price: value._selectedProducts[0].price ?? 0,
                                          //               packing: value._selectedProducts[0].packing ?? '',
                                          //               packingType: value._selectedProducts[0].packingType!.label ??'',
                                          //             ),);
                                          //           Navigator.pop(context);
                                          //           // selectPacking.selectedProducts.clear();
                                          //         }
                                          //       }, loading: false,
                                          //     );
                                          //   },
                                          // )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(1.h),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextWithStyle.containerTitle(
                                        context, "Select Products"),
                                    Icon(
                                        CupertinoIcons
                                            .chevron_down_circle,
                                        size: 2.9.h,
                                        color: AppColors.primaryColor),
                                  ],
                                ),
                              ),
                            ),
                            Consumer<ProProvider>(
                              builder: (BuildContext context, value, Widget? child) {
                                return  Wrap(
                                    spacing: 5,
                                    children: value.selectedProducts
                                        .map((e) =>
                                        Chip(label: Text(e.name!,style: TextStyle(fontSize: 17.sp),)))
                                        .toList()
                                  // divisions.map((e) => Chip(label: Text(e.name))).toList(),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Consumer2<ProProvider, AddVisitViewModel>(
                        builder: (BuildContext context, value, value2,
                            Widget? child) {
                          return Button(
                            title: 'Submit',
                            onPress: () {
                              AddVisitEntity entity = AddVisitEntity();
                              entity.customerId = _chosenValue.id;
                              entity.place = currentAddress.text;
                              entity.time = timeinput.text;
                              entity.remark = message.text;
                              entity.products = value.selectedProducts
                                  .map((e) => e.id!)
                                  .toList();
                              addVisit.addVisits(context,
                                  entity,
                                timeinput,
                                currentAddress,
                                message,
                              );
                            },
                            loading: value2.loading,
                          );
                        },
                      )
                    ],
                  ),
                );
            },),
      )
    );
  }
}
