import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pharma_clients_app/data/model/requested_data_model/firmEntity.dart';
import 'package:pharma_clients_app/utils/button.dart';
import 'package:pharma_clients_app/view_model/afterLogin_viewModel/afterLogin_viewModels.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../data/response/status.dart';
import '../../resources/app_colors.dart';
import '../../resources/constant_strings.dart';
import '../../utils/Dialogue/error_dialogue.dart';
import '../../utils/TextInputFields/text_field.dart';
import '../../utils/text_style.dart';
import '../register_screen.dart';

class EditFirmScreen extends StatefulWidget {
  const EditFirmScreen({Key? key}) : super(key: key);

  @override
  State<EditFirmScreen> createState() => _EditFirmScreenState();
}

class _EditFirmScreenState extends State<EditFirmScreen> {

  TextEditingController firmName = TextEditingController();
  TextEditingController gst = TextEditingController();
  TextEditingController drugLicence = TextEditingController();
  TextEditingController firmPhone = TextEditingController();
  TextEditingController firmEmail = TextEditingController();
  TextEditingController firmAddress = TextEditingController();
 // TextEditingController division = TextEditingController();
  TextEditingController bankName = TextEditingController();
  TextEditingController bankIFSC = TextEditingController();
  TextEditingController bankAccNumber = TextEditingController();
  TextEditingController payeeName = TextEditingController();

  FocusNode firmNameFocusNode = FocusNode();
  FocusNode gstFocusNode = FocusNode();
  FocusNode drugLicenceFocusNode = FocusNode();
  FocusNode firmPhoneFocusNode = FocusNode();
  FocusNode firmEmailFocusNode = FocusNode();
  FocusNode firmAddressFocusNode = FocusNode();
  FocusNode divisionFocusNode = FocusNode();
  FocusNode stateFocusNode = FocusNode();
  FocusNode cityFocusNode = FocusNode();
  FocusNode bankNameFocusNode = FocusNode();
  FocusNode bankIfSCFocusNode = FocusNode();
  FocusNode bankAccNumberFocusNode = FocusNode();
  FocusNode payeeNameFocusNode = FocusNode();

  FirmViewModel model = FirmViewModel();
  StatesViewModel stateModel = StatesViewModel();
  CitiesViewModel citiesModel = CitiesViewModel();


  final List<Division> division = [];

  var state;
  String? newState;
  var city;
  String? newCity;
  int _selectedCityIndex = 0;


  @override
  void initState() {
    // TODO: implement initState
    model.fetchFirm();
    division.clear();
    stateModel.states(context);
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    division.clear();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<DivisionProvider>(context,listen: false);
    final update = Provider.of<UpdateFirmViewModel>(context,listen: false);
    provider.selectedDivisions.clear();

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: TextWithStyle.appBarTitle(
              context, ConstantStrings.updateFirmHeading),
          elevation: 0,
        ),
        body: ChangeNotifierProvider<FirmViewModel>(
            create: (BuildContext context) => model,
            child: Consumer<FirmViewModel>(
                builder: (BuildContext context, value, _) {
                  switch (value.firm.status!) {
                    case Status.loading:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case Status.error:
                      if (kDebugMode) {
                        print(value.firm.message.toString());
                      }
                      return ErrorDialogue(
                        message: value.firm.message.toString(),
                      );
                    case Status.completed:
                      var firm = value.firm.data!.data;
                      for(var element  in firm!.divisions!){
                        division.add(Division(id: element.id!, name: element.name!));
                      }
                      firmName.text = firm.name ?? 'Na';
                      gst.text = firm.gstNumber ?? 'Na';
                      drugLicence.text = firm.drugLicense ?? 'Na';
                      StringBuffer sb = StringBuffer();
                      if (firmPhone != null) {
                        sb.write(
                            value.firm.data!.data?.phone!
                                .replaceAll(RegExp(r'\D'), '')
                                .replaceAll(RegExp('91'), '')
                                .replaceAll(RegExp('^0+'), '')
                        );
                        firmPhone.text = sb.toString();
                      }
                      firmEmail.text = firm.email ?? 'Na';
                      firmAddress.text = firm.address ?? 'Na';
                      newState = firm.state ?? 'Na';
                      newCity = firm.district ?? 'Na';
                      bankName.text = firm.bankName ?? 'Na';
                      bankIFSC.text = firm.bankIfsc ?? 'Na';
                      bankAccNumber.text = firm.bankAccNo ?? 'Na';
                      payeeName.text = firm.bankPayeeName ?? 'Na';

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
                              margin: EdgeInsets.only(
                                  left: 1.5.h, right: 1.5.h),
                              padding: EdgeInsets.all(2.h),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius
                                    .circular(20)),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primaryColor.withOpacity(
                                        0.1),
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: const Offset(0, 0),
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  TextInputField(
                                    title: firmName,
                                    node: firmNameFocusNode,
                                    hintText: 'Enter your Firm Name',
                                    labelText: 'Firm Name',
                                    icon: Icons.house_sharp,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your Firm Name';
                                      }
                                      return null;
                                    },
                                  ),
                                  TextInputField(
                                    title: gst,
                                    node: gstFocusNode,
                                    icon: CupertinoIcons.doc_text_fill,
                                    hintText: 'Enter your GST Number',
                                    labelText: 'GST Number',
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your GST Number';
                                      }
                                      return null;
                                    },
                                  ),
                                  TextInputField(
                                    title: drugLicence,
                                    node: drugLicenceFocusNode,
                                    icon: CupertinoIcons.doc_checkmark_fill,
                                    hintText: 'Enter your Drug Licence',
                                    labelText: 'Drug Licence Number',
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your Drug Licence Number';
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    style: TextStyle(fontSize: 18.sp),
                                    controller: firmPhone,
                                    focusNode: firmPhoneFocusNode,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(10),
                                    ],
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your  Firm Phone';
                                      } else if (value.length != 10) {
                                        return 'Please Enter 10 digits';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                          borderSide:
                                          BorderSide(
                                              color: AppColors.primaryColor)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                          const BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide:
                                          BorderSide(
                                              color: AppColors.primaryColor)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                          borderSide: BorderSide(
                                              color: Colors.red.shade700)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                          borderSide: BorderSide(
                                              color: Colors.red.shade700)),
                                      contentPadding: const EdgeInsets.all(20),
                                      border: InputBorder.none,
                                      prefixIcon:
                                      const Icon(CupertinoIcons.phone_fill),
                                      hintText: 'Enter your phone Firm number',
                                      labelText: 'Firm Phone Number',
                                      //prefixIcon: Icon(Icons.alternate_email)
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  TextInputField(
                                    title: firmEmail,
                                    node: firmEmailFocusNode,
                                    icon: CupertinoIcons.mail_solid,
                                    hintText: 'Enter your Firm Email',
                                    labelText: 'Firm Email',
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your Firm Email';
                                      }
                                      return null;
                                    },
                                  ),
                                  TextInputField(
                                    title: firmAddress,
                                    node: firmAddressFocusNode,
                                    icon: CupertinoIcons.location_solid,
                                    hintText: 'Enter your Firm Address',
                                    labelText: 'Firm Address',
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your Firm Address';
                                      }
                                      return null;
                                    },
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text('Select Divisions'),
                                            content: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: division.map((division) {
                                                  // provider._selectedDivisions.clear();
                                                  return Consumer<DivisionProvider>(
                                                    builder: (BuildContext context,
                                                        value, Widget? child) {
                                                      return CheckboxListTile(
                                                        title: Text(division.name),
                                                        value: value.isSelected(division),
                                                        onChanged: (value) {
                                                          if (value!) {
                                                            provider.addDivision(division);
                                                          } else {
                                                            provider.removeDivision(division);
                                                          }
                                                        },
                                                      );
                                                    },
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                            actions: [
                                              Consumer<DivisionProvider>(
                                                builder: (BuildContext context, value,
                                                    Widget? child) {
                                                  return ElevatedButton(
                                                    child: Text('OK'),
                                                    onPressed: () {
                                                      print(value.selectedDivisions
                                                          .map((e) => e.id));
                                                      Navigator.of(context).pop();
                                                    },
                                                  );
                                                },
                                              ),
                                            ],
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
                                              context, "Select Divisions"),
                                          Icon(CupertinoIcons.chevron_down_circle,
                                              size: 2.9.h,
                                              color: AppColors.primaryColor),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    thickness: 0.3.h,
                                    height: 2.h,
                                  ),
                                  Consumer<DivisionProvider>(
                                    builder:
                                        (BuildContext context, value, Widget? child) {
                                      return Wrap(
                                          spacing: 5,
                                          children: value.selectedDivisions.length != 0
                                              ? value.selectedDivisions.map((e) => Chip(label: Text(e.name))).toList()
                                              : division.map((e) => Chip(label: Text(e.name))).toList()
                                      );},
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  ChangeNotifierProvider<StatesViewModel>(
                                      create: (BuildContext context) => stateModel,
                                      child: Consumer<StatesViewModel>(
                                        builder: (BuildContext context, value,
                                            Widget? child) {
                                          return DropdownButtonFormField(
                                            hint: SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                    1.8,
                                                child: Text(
                                                  newState!,
                                                  style: const TextStyle(
                                                      color: Colors.black
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                )),
                                            value: state,
                                            elevation: 8,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(2.h)),
                                            menuMaxHeight: 40.h,
                                            style: TextStyle(
                                              fontSize: 18.sp,
                                              color: Colors.black,
                                            ),
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
                                              border: InputBorder.none,
                                              prefixIcon: Padding(
                                                padding: EdgeInsets.all(2.w),
                                                child: Icon(
                                                  Icons.add_home_work_sharp,
                                                  size: 3.h,
                                                ),
                                              ),
                                              contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  0, 20, 20, 20),
                                              hintText: 'Enter your State',
                                              labelText: 'State',
                                              labelStyle: TextStyle(
                                                fontSize: 18.sp,
                                                color: Colors.black,
                                              ),
                                            ),
                                            items: value.state
                                                .map<DropdownMenuItem>((value) {
                                              return DropdownMenuItem(
                                                value: value,
                                                child: SizedBox(
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                        1.8,
                                                    child: Text(
                                                      value.name!,
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                    )),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              state = value;
                                              citiesModel.cities(
                                                  state.id, context);
                                            },
                                            validator: (value) {
                                              if (state == null) {
                                                return 'Please enter your State';
                                              }
                                              return null;
                                            },
                                          );
                                        },
                                      )
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  ChangeNotifierProvider<CitiesViewModel>(
                                      create: (BuildContext context) => citiesModel,
                                      child: Consumer<CitiesViewModel>(
                                        builder: (BuildContext context, value,
                                            Widget? child) {
                                          return DropdownButtonFormField(
                                            hint: SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                    1.8,
                                                child: Text(
                                                  newCity!,
                                                  style: const TextStyle(
                                                      color: Colors.black
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                )),
                                            value: value.city.isEmpty
                                                ? 'NA'
                                                : value.city[_selectedCityIndex],
                                            elevation: 8,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(2.h)),
                                            menuMaxHeight: 40.h,
                                            style: TextStyle(
                                              fontSize: 18.sp,
                                              color: Colors.black,
                                            ),
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
                                              border: InputBorder.none,
                                              prefixIcon: Padding(
                                                padding: EdgeInsets.all(2.w),
                                                child: Icon(
                                                  CupertinoIcons.house_alt_fill,
                                                  size: 3.h,
                                                ),
                                              ),
                                              contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  0, 20, 20, 20),
                                              hintText: 'Enter your Cities',
                                              labelText: 'Cities',
                                              labelStyle: TextStyle(
                                                fontSize: 18.sp,
                                                color: Colors.black,
                                              ),
                                            ),
                                            items: value.city
                                                .map<DropdownMenuItem>((val) {
                                              return DropdownMenuItem(
                                                value: val,
                                                child: SizedBox(
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                        1.8,
                                                    child: Text(
                                                      val,
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                    )),
                                              );
                                            }).toList(),
                                            onChanged: (val) {
                                              city = val;
                                            },
                                            validator: (val) {
                                              if (city == null) {
                                                return 'Please enter your City';
                                              }
                                              return null;
                                            },
                                          );
                                        },
                                      )),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  TextInputField(
                                    title: bankName,
                                    node: bankNameFocusNode,
                                    icon: CupertinoIcons
                                        .money_dollar_circle_fill,
                                    hintText: 'Enter your Bank Name',
                                    labelText: 'Bank Name (Optional)',
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your Bank Name';
                                      }
                                      return null;
                                    },
                                  ),
                                  TextInputField(
                                    title: bankAccNumber,
                                    node: bankAccNumberFocusNode,
                                    icon: CupertinoIcons.doc_text_fill,
                                    hintText: 'Enter your Account Number',
                                    labelText: 'Account Number(Optional)',
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your Bank Account Number';
                                      }
                                      return null;
                                    },
                                  ),
                                  TextInputField(
                                    title: bankIFSC,
                                    node: bankIfSCFocusNode,
                                    icon: CupertinoIcons.doc_text,
                                    hintText: 'Enter your IFSC Code',
                                    labelText: 'IFSC Code(Optional)',
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your Operation Area';
                                      }
                                      return null;
                                    },
                                  ),
                                  TextInputField(
                                    title: payeeName,
                                    node: payeeNameFocusNode,
                                    icon: CupertinoIcons.person_fill,
                                    hintText: 'Enter your Payee Name',
                                    labelText: 'Payee Name (Optional)',
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your Payee Name';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Consumer<DivisionProvider>(
                              builder: (BuildContext context, value, Widget? child) {
                                return Button(
                                  title: 'Update',
                                  onPress: () {

                                    FirmEntity entity = FirmEntity();
                                    entity.name = firmName.text;
                                    entity.gst_number = gst.text;
                                    entity.drug_license = drugLicence.text;
                                    entity.phone = firmPhone.text;
                                    entity.email = firmEmail.text;
                                    entity.address = firmAddress.text;
                                    entity.state = state.name.toString();
                                    entity.district = city.toString();
                                    entity.bank_name = bankName.text;
                                    entity.bank_acc_no = bankAccNumber.text;
                                    entity.bank_payee_name = payeeName.text;
                                    entity.divisions = value.selectedDivisions.isEmpty
                                        ? division.map((e) => e.id).toList()
                                        : value.selectedDivisions.map((e) => e.id).toList();

                                    update.updateFirm(entity,
                                        context,
                                        firmName,
                                        gst,
                                        drugLicence,
                                        firmPhone,
                                        firmEmail,
                                        firmAddress,
                                        bankName,
                                        bankAccNumber,
                                        bankIFSC,
                                        payeeName
                                    );
                                  }, loading: false,
                                );
                              },
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                          ],
                        ),
                      );
                  }
                })));
  }
}
