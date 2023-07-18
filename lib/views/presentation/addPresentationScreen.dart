import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharma_clients_app/data/model/response_model/visual_aids_response_model.dart';
import 'package:pharma_clients_app/resources/constant_strings.dart';
import 'package:pharma_clients_app/utils/TextInputFields/text_field.dart';
import 'package:pharma_clients_app/utils/text_style.dart';
import 'package:pharma_clients_app/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/model/requested_data_model/presentaionData.dart';
import '../../data/response/status.dart';
import '../../resources/app_colors.dart';
import '../../resources/constant_imageString.dart';
import '../../utils/Dialogue/error_dialogue.dart';
import '../../view_model/afterLogin_viewModel/afterLogin_viewModels.dart';

class AddPresentationScreen extends StatefulWidget {
  const AddPresentationScreen({Key? key}) : super(key: key);

  @override
  State<AddPresentationScreen> createState() => _AddPresentationScreenState();
}

class _AddPresentationScreenState extends State<AddPresentationScreen> {

  VisualAidsViewModel model = VisualAidsViewModel();
  Presentation prefs = Presentation();
  TextEditingController controller = TextEditingController();
  TextEditingController title = TextEditingController();

  FocusNode titleFocusNode = FocusNode();

  @override
  void initState() {
    model.fetchVisualAids();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWithStyle.appBarTitle(context, ConstantStrings.addPresentationHeading),
        elevation: 0,
        toolbarHeight: 6.h,
        centerTitle: false,
        actions: [
          Container(
                margin: const EdgeInsets.only(right: 20,top: 5,bottom: 5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(15)))
                  ),
                    onPressed: () async {
                      if(model.selectedVisualAids.isNotEmpty && title.text.isNotEmpty){
                        final presentation = PresentationData(
                            name: title.text,
                            images: model.selectedVisualAids.map((e) =>
                                ImageData(name: e.name!, imageUrl: e.url!))
                                .toList()
                        );
                        await prefs.savePresentation(presentation);
                        Utils.flushBarSuccessMessage('Presentaion Added', context);
                        model.clearSelection();
                        title.clear();
                      }else{
                        if(title.text.isEmpty){
                          Utils.flushBarErrorMessage("Please Add Title!", context);
                        }else{
                          Utils.flushBarErrorMessage("Please Add VisualAids!", context);
                        }
                      }},
                  child: Text('Save',style: TextStyle(fontSize: 16.sp,color: Colors.white,letterSpacing: 1),),
                ),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(left: 1.h,right: 1.h),
        child: Column(
          children: [
            Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 2.h,top: 2.h),
                child: TextWithStyle.containerTitle(context,'Title of Presentation:')),
            Container(
                margin: EdgeInsets.only(left: 3.w,top: 3.w,right: 3.w),
                child: TextInputField(
                  title: title,
                  node: titleFocusNode,
                  hintText: 'Enter Title',
                  labelText: 'Title',
                  icon: Icons.edit_note,
                )
            ),
            Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 2.h,right: 2.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    TextWithStyle.containerTitle(context,'Select Images:'),
                    InkWell(
                      onTap: (){
                        model.clearSelection();
                      },
                      child: TextWithStyle.containerTitle(context,'Clear'),
                    )
                  ],
                )),
            Container(
              margin: EdgeInsets.all(3.w),
              child: TextFormField(
                style: TextStyle(fontSize: 16.sp),
                controller: controller,
                onChanged: (value){
                  model.filteredVisuals(value.toLowerCase());
                },
                decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.primaryColor.withOpacity(0.1),
                    enabledBorder: const OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(15)),
                        borderSide:
                        BorderSide(color: Colors.white)),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(
                            color: Colors.white)),
                    contentPadding: EdgeInsets.all(2.5.h),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 1.h,right: 1.h),
                      child: Icon(CupertinoIcons.search,size: 3.h,),
                    ),
                    border: InputBorder.none,
                    hintText: "Search by Name,Categories & Division"),
              ),
            ),
            Expanded(
              child: ChangeNotifierProvider<VisualAidsViewModel>(
                create: (BuildContext context) => model,
                child: Consumer<VisualAidsViewModel>(
                  builder: (context,value,_){
                    switch(value.visualaidsList.status!){
                      case Status.loading:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case Status.error:
                        return ErrorDialogue(message: value.visualaidsList.message);
                      case Status.completed:
                        return value.visualAids.isNotEmpty
                            ? GridView.builder(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2
                                ),
                                itemCount: value.visualAids.length,
                                itemBuilder: (context, index){
                                  final isSelected = value.isSelected(value.visualAids[index]);
                                  return InkWell(
                                          onLongPress: (){
                                            model.toggleSelection(value.visualAids[index]);
                                          },
                                          onTap: (){
                                            if(value.isSelectionMode){
                                              model.toggleSelection(value.visualAids[index]);
                                            }else{
                                              Utils.flushBarErrorMessage(ConstantStrings.visualError, context);
                                            }
                                          },
                                          child: Card(
                                            margin: EdgeInsets.only(left: 1.w,right: 1.w,top: 2.w),
                                            elevation: 2.w,
                                            shadowColor: Colors.black54,
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(2.h))),
                                            child: Stack(
                                              alignment: Alignment.topRight,
                                              children: [
                                                Center(
                                                  child: FadeInImage.assetNetwork(
                                                    placeholder: 'assets/images/png/loading.gif',
                                                    image: '${value.visualAids[index].url}',
                                                  ),
                                                ),
                                                if(isSelected)
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                      right: 3.w,
                                                    ),
                                                    child: Icon(
                                                      CupertinoIcons
                                                          .check_mark_circled_solid,
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          )
                                      );
                                    },
                                  )
                            : Center(
                              child: SingleChildScrollView(
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
                              ),
                            );}
                  },
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}

class Presentation extends ChangeNotifier {

  Future<void> savePresentation(PresentationData presentation) async {
    final prefs = await SharedPreferences.getInstance();
    final presentations = prefs.getStringList('presentations') ?? [];

    final presentationMap = presentation.toMap();

    final index = presentations.indexWhere((element) => element == presentationMap['name']);
    if (index >= 0) {
      presentations[index] = json.encode(presentationMap);
    } else {
      presentations.add(json.encode(presentationMap));
    }

    await prefs.setStringList('presentations', presentations);
  }

  Future<List<PresentationData>> loadPresentations() async {
    final prefs = await SharedPreferences.getInstance();
    final presentations = prefs.getStringList('presentations') ?? [];

    return presentations.map((e) => PresentationData.fromMap(json.decode(e))).toList();
  }

  Future<void> removepresentation(String presentationName) async {
    final prefs = await SharedPreferences.getInstance();
    final presentations = prefs.getStringList('presentations') ?? [];

    final index = presentations.indexWhere((element) {
      final presentationMap = json.decode(element);
      return presentationMap['name'] == presentationName;
    });

    if (index >= 0) {
      presentations.removeAt(index);
      await prefs.setStringList('presentations', presentations);
    }
  }

  Future<void> updatePresentation(String oldName, PresentationData updatedPresentation) async {
    final prefs = await SharedPreferences.getInstance();
    final presentations = prefs.getStringList('presentations') ?? [];

    final updatedPresentationMap = updatedPresentation.toMap();

    final index = presentations.indexWhere((element) {
      final presentationMap = json.decode(element);
      return presentationMap['name'] == oldName;
    });

    if (index >= 0) {
      final existingPresentationMap = json.decode(presentations[index]);
      existingPresentationMap['name'] = updatedPresentationMap['name'];
      existingPresentationMap['images'] = updatedPresentationMap['images'];
      presentations[index] = json.encode(existingPresentationMap);
      await prefs.setStringList('presentations', presentations);
    }
  }

  Future<bool> removePresentation()async{
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('presentations');
    return true;
  }

}


