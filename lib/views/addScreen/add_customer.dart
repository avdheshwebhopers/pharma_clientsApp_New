import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pharma_clients_app/data/model/requested_data_model/customer/addCustomer_entity.dart';
import 'package:pharma_clients_app/utils/TextInputFields/password_inputField.dart';
import 'package:pharma_clients_app/utils/TextInputFields/text_field.dart';
import 'package:pharma_clients_app/utils/button.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../resources/app_colors.dart';
import '../../resources/constant_strings.dart';
import '../../utils/text_style.dart';
import '../../view_model/afterLogin_viewModel/afterLogin_viewModels.dart';

class AddCustomerScreen extends StatefulWidget {
  const AddCustomerScreen({Key? key}) : super(key: key);

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController profession = TextEditingController();
  TextEditingController hospitalName = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController weddingDate = TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode professionFocusNode = FocusNode();
  FocusNode stateFocusNode = FocusNode();
  FocusNode cityFocusNode = FocusNode();
  FocusNode hospitalNameFocusNode = FocusNode();
  FocusNode dobFocusNode = FocusNode();
  FocusNode weddingDateFocusNode = FocusNode();

  StatesViewModel stateModel = StatesViewModel();
  CitiesViewModel citiesModel = CitiesViewModel();

  var currentTime = '${DateTime.now().hour + DateTime.now().second}';
  DateTime selectedTime = DateTime.now();

  final _formKey = GlobalKey<FormState>();

  Future<void> _selectDate(BuildContext context, date) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedTime,
        firstDate: DateTime(1900, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        currentTime = DateFormat.yMMMd().format(selectedTime);
        date.text = currentTime;
      });
    }
  }

  String? newState;
  var state;
  var city;
  String? newCity;
  int _selectedCityIndex = 0;

  @override
  void initState() {
    stateModel.states(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final addcustomer = Provider.of<AddCustomerViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: TextWithStyle.appBarTitle(
            context, ConstantStrings.addCustomerheading),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 1.h,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 1.5.h, right: 1.5.h),
                padding: EdgeInsets.all(2.h),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 0),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    TextInputField(
                      title: name,
                      node: nameFocusNode,
                      hintText: 'Enter your name',
                      labelText: 'Name',
                      icon: CupertinoIcons.person_alt,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your Name';
                        }
                        return null;
                      },
                    ),
                    TextInputField(
                      title: email,
                      node: emailFocusNode,
                      icon: CupertinoIcons.mail_solid,
                      hintText: 'Enter your email',
                      labelText: 'Email',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your Email';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      style: TextStyle(fontSize: 18.sp),
                      controller: phone,
                      focusNode: phoneFocusNode,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your Phone';
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
                                BorderSide(color: AppColors.primaryColor)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            borderSide:
                                BorderSide(color: AppColors.primaryColor)),
                        errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.red.shade700)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.red.shade700)),
                        contentPadding: const EdgeInsets.all(20),
                        border: InputBorder.none,
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(2.w),
                          child: Icon(CupertinoIcons.phone_fill,size: 3.h,),
                        ),
                        hintText: 'Enter your phone number',
                        labelText: 'Phone',
                        //prefixIcon: Icon(Icons.alternate_email)
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    TextInputField(
                      title: address,
                      node: addressFocusNode,
                      icon: CupertinoIcons.placemark_fill,
                      hintText:'Enter your Address',
                      labelText: 'Address',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your Address';
                        }
                        return null;
                      },
                    ),
                    TextInputField(
                      title: profession,
                      node:  professionFocusNode,
                      icon: CupertinoIcons.briefcase_fill,
                      hintText: 'Enter your profession',
                      labelText: 'Profession',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your Profession';
                        }
                        return null;
                      },
                    ),
                    ChangeNotifierProvider<StatesViewModel>(
                        create: (BuildContext context) => stateModel,
                        child: Consumer<StatesViewModel>(
                          builder: (BuildContext context, value,
                              Widget? child) {
                            return DropdownButtonFormField(
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
                      title: hospitalName,
                      node: hospitalNameFocusNode,
                      icon: Icons.home_work_outlined,
                      hintText:  'Enter your Hospital Name',
                      labelText: 'Hospital Name',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your Hospital';
                        }
                        return null;
                      },
                    ),
                    PasswordInputField(
                      title: dob,
                      node: dobFocusNode,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your Date of Birth';
                        }
                        return null;
                      },
                      obSecure: false,
                      icon: Icons.person_pin_outlined,
                      hintText: 'Enter your Date of Birth ',
                      labelText: 'D.O.B',
                      suffixIcon: InkWell(
                          onTap: () {
                            _selectDate(context, dob);
                          },
                          child: const Icon(Icons.date_range)),
                    ),
                    PasswordInputField(
                      title: weddingDate,
                      node: weddingDateFocusNode,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your Date of Birth';
                        }
                        return null;
                      },
                      obSecure: false,
                      icon: CupertinoIcons.heart_circle,
                      hintText: 'Enter your Wedding Anniversary',
                      labelText: 'Wedding Anniversary',
                      suffixIcon: InkWell(
                          onTap: () {
                            _selectDate(context, weddingDate);
                          },
                          child: const Icon(Icons.date_range)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Consumer<AddCustomerViewModel>(
                builder: (BuildContext context, value, Widget? child) {
                  return Button(
                    title: 'Add Customer',
                    loading: value.loading,
                    onPress: () {
                      setState(() {
                        final isValid = _formKey.currentState?.validate();
                        if (!isValid!) {
                          return;
                        }
                        _formKey.currentState?.save();
                        AddCustomerEntity entity = AddCustomerEntity();
                        entity.name = name.text.toString();
                        entity.email = email.text.toString();
                        entity.phone = phone.text.toString();
                        entity.address = address.text.toString();
                        entity.profession = profession.text.toString();
                        entity.state = state.name.toString();
                        entity.city = city.toString();
                        entity.workingPlace = hospitalName.text.toString();
                        entity.dob = dob.text.toString();
                        entity.weddingAnniversary = weddingDate.text.toString();
                        addcustomer.addCustomers(
                            entity,
                            context,
                            name,
                            email,
                            phone,
                            address,
                            profession,
                            hospitalName,
                            dob,
                            weddingDate);
                      });
                    },
                  );
                },
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
