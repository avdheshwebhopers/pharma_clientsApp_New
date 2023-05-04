import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pharma_clients_app/data/model/response_model/customers/customers_responseModel.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../data/model/requested_data_model/customer/addCustomer_entity.dart';
import '../../data/model/requested_data_model/customer/updateCustomerEntity.dart';
import '../../resources/app_colors.dart';
import '../../resources/constant_strings.dart';
import '../../utils/TextInputFields/password_inputField.dart';
import '../../utils/TextInputFields/text_field.dart';
import '../../utils/text_style.dart';
import '../../view_model/afterLogin_viewModel/afterLogin_viewModels.dart';

class CustomersProfileScreen extends StatefulWidget {
  CustomersProfileScreen({Key? key , required this.profile}) : super(key: key);

  List<Customers> profile;

  @override
  State<CustomersProfileScreen> createState() => _CustomersProfileScreenState();
}

class _CustomersProfileScreenState extends State<CustomersProfileScreen> {

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
  CustomersViewModel model = CustomersViewModel();

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
  void dispose() {
    widget.profile.clear();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    name.text = widget.profile[0].name ?? 'NA';
    email.text = widget.profile[0].email?? 'NA';
    StringBuffer sb = StringBuffer();
    if (phone != null) {
      sb.write(
          widget.profile[0].phone!.toString()
              .replaceAll(RegExp(r'\D'), '')
              .replaceAll(RegExp('91'), '')
              .replaceAll(RegExp('^0+'), '')
      );
      phone.text = sb.toString();
    }
    address.text = widget.profile[0].address?? 'NA';
    profession.text = widget.profile[0].profession?? 'NA';
    newState = widget.profile[0].state?? 'NA';
    newCity = widget.profile[0].city?? 'NA';
    hospitalName.text = widget.profile[0].workingPlace?? 'NA';
    dob.text = widget.profile[0].dob?? 'NA';
    weddingDate.text = widget.profile[0].weddingAnniversary?? 'NA';

    final update = Provider.of<AddCustomerViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          title: TextWithStyle.appBarTitle(
              context, ConstantStrings.customerProfileHeading)
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
                      icon: CupertinoIcons.person,
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
                      icon: CupertinoIcons.mail,
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
                        prefixIcon:
                        const Icon(CupertinoIcons.device_phone_portrait),
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
                      icon: CupertinoIcons.placemark,
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
                      icon: CupertinoIcons.briefcase,
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
                                if (state == null && newState == null) {
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
                                if (city == null && newCity == null ) {
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
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      final isValid = _formKey.currentState?.validate();
                      if (!isValid!) {
                        return;
                      }
                      _formKey.currentState?.save();

                      UpdateCustomerEntity entity = UpdateCustomerEntity();
                      entity.id = widget.profile[0].id;
                      entity.name = name.text.toString();
                      entity.email = email.text.toString();
                      entity.phone = phone.text.toString();
                      entity.address = address.text.toString();
                      entity.profession = profession.text.toString();
                      entity.state = state == null ? newState : state.name.toString();
                      entity.city = city == null ? newCity :city.toString();
                      entity.workingPlace = hospitalName.text.toString();
                      entity.dob = dob.text.toString();
                      entity.weddingAnniversary = weddingDate.text.toString();

                      update.updateCustomers(
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
                      //model.fetchCustomers();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      minimumSize: Size(MediaQuery.of(context).size.width / 2,
                          MediaQuery.of(context).size.width / 7),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(2.h)))),
                  child: Text(
                    'Add Customer',
                    style: GoogleFonts.workSans(
                        color: Colors.white,
                        textStyle: Theme.of(context).textTheme.bodyMedium,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w400),
                  )),
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
