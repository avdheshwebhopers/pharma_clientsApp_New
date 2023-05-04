import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharma_clients_app/data/model/response_model/about_company/about_company_response_model.dart';
import 'package:pharma_clients_app/resources/constant_strings.dart';
import 'package:pharma_clients_app/utils/text_style.dart';
import 'package:pharma_clients_app/views/Screens/certificates.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// ignore: must_be_immutable
class AboutCompnay extends StatefulWidget {
  AboutCompnay({Key? key,

    required this.value

  }) : super(key: key);

  List<AboutCompany> value;

  @override
  State<AboutCompnay> createState() => _AboutCompnayState();
}

class _AboutCompnayState extends State<AboutCompnay> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
}

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: TextWithStyle.appBarTitle(context, ConstantStrings.aboutusHeading),
        elevation: 0,
        centerTitle: false,
        actions: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> CertificateScreen(value: widget.value)));
            },
            child: Image.asset(
              'assets/images/png/certificate.png',
              height: 3.h,
              width: 3.h,
            ),
          ),
          SizedBox(width: 2.h,)
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(1.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: widget.value[0].aboutImg != null
                    ? Image.network(widget.value[0].aboutImg!)
                    : Image.asset('assets/images/png/no_image.png',
                  height: 20.h,),
              ),
              SizedBox(height: 2.h,),
              Text(widget.value[0].about!,
                  textAlign: TextAlign.justify,
                style: GoogleFonts.poppins(
                    fontSize: 17.sp,
                )),
            ],
          ),
        )
      )
    );
  }
}
