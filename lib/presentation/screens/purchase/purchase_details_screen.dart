import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:real_estate/data/model/agency/agency_details_model.dart';

import '../../../data/data_provider/remote_url.dart';
import '../../../data/model/add_property_model.dart' as room;
import '../../../logic/cubit/add_property/add_property_cubit.dart';
import '../../router/route_names.dart';
import '../../widget/custom_theme.dart';
import '../../widget/customnetwork_widget.dart';
import '../home/home_screen.dart';
import '../support/contact_us.dart';
import '/presentation/utils/utils.dart';
import '../../../data/model/order/single_order_model.dart';
import '../../../logic/cubit/order/order_cubit.dart';
import '../../utils/constraints.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_test_style.dart';
import '../../widget/loading_widget.dart';

class PurchaseDetailScreen extends StatelessWidget {
  const PurchaseDetailScreen({super.key, required this.propertiesDetails});

  final dynamic propertiesDetails;

  @override
  Widget build(BuildContext context) {
    // final orderCubit = context.read<OrderCubit>();
    // orderCubit.getOrderDetails(propertiesDetails);
    return Scaffold(
      extendBody: true,
      backgroundColor: whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size(
          360,
          200,
        ),
        child: Container(
            width: 360,
            height: 200,
            decoration: BoxDecoration(
              color: CustomTheme.theme.scaffoldBackgroundColor,
              boxShadow: [
                const BoxShadow(
                  color: Color(0x1E000000),
                  blurRadius: 8,
                  offset: Offset(0, 1),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 50.0, left: 16, right: 16),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/Yash/images/ZingCityLogo.png",
                        width: 50.03,
                        height: 35.01,
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RouteNames.addPropertyScreen);
                        },
                        child: Container(
                          width: 155,
                          height: 30.90,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF30469A),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x19000000),
                                blurRadius: 8,
                                offset: Offset(0, 0),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                    "assets/Yash/images/post_ad_button.png"),
                                const SizedBox(width: 5.0),
                                const Text(
                                  'Post Property',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                        ),
                        Text(
                          'Property Details',
                          style: TextStyle(
                            color: Color(0xFF30469A),
                            fontSize: 18,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
      body: propertyDetailsLoaded(
          propertyDetails: propertiesDetails //orderCubit.singleOrder!
          ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            Expanded(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ContactUs(isSendingEnquiry: true,propertyId: propertiesDetails.id.toString())),
                      );

                    },
                    child: const Text(
                      'Send Eqnuiry',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}

class propertyDetailsLoaded extends StatefulWidget {
  const propertyDetailsLoaded({super.key, this.propertyDetails});

  final dynamic propertyDetails;

  @override
  State<propertyDetailsLoaded> createState() => _propertyDetailsLoadedState();
}

class _propertyDetailsLoadedState extends State<propertyDetailsLoaded> {


  List<room.Category> categories = [];
  Set<room.Category> subCategoriesResidential = {};
  Set<room.Category> subCategoriesCommercial = {};
  Set<room.Category> subCategoriesPlotLand = {};
  Set<room.Category> subCategoriesAgricultural = {};

  String PropertyType = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.propertyDetails.purpose == "2"){

      context.read<AddPropertyCubit>().state.staticInfo?.roomType?.forEach((element) {
        debugPrint("element ==> ${element.id}");
      });
      context.read<AddPropertyCubit>().state.staticInfo?.categories?.forEach((category) {
        context.read<AddPropertyCubit>().state.staticInfo?.purpose?.rent?.forEach((rent) {

          if(rent.categoryId == category.id){
            categories.add(category);
          }

          if(rent.categoryId.toString() == context.read<AddPropertyCubit>().state.categoryId && context.read<AddPropertyCubit>().state.categoryId.isNotEmpty){
            context.read<AddPropertyCubit>().changeTypeId(category.name ?? "",(category.id ?? "").toString());
          }
        });
      });


      context.read<AddPropertyCubit>().state.staticInfo?.subcategories!.forEach((key,element) {
        // debugPrint("key ==> $key");

        categories.forEach((categories){
          if(element.purpose!.contains(2)){

            if(element.parentId.toString() == "1" ){

              subCategoriesResidential.add(element);
              if(element.id.toString() ==  widget.propertyDetails.propertyTypeId.toString()){
                PropertyType = element.name ?? "";
              }

            }
            else {
              // debugPrint("Commercial ==> ${element.name}");
              subCategoriesCommercial.add(element);
              if(element.id.toString() ==  widget.propertyDetails.propertyTypeId.toString()){
                PropertyType = element.name ?? "";
              }
              // debugPrint("Else commercial ==> ${subCategoriesCommercial}");
            }
          }

        });



      });
    } else {

      context.read<AddPropertyCubit>().state.staticInfo?.roomType?.forEach((element) {
        debugPrint("element ==> ${element.id}");
      });
      context.read<AddPropertyCubit>().state.staticInfo?.categories?.forEach((category) {
        context.read<AddPropertyCubit>().state.staticInfo?.purpose?.sell?.forEach((rent) {

          if(rent.categoryId == category.id){
            categories.add(category);
          }

          if(rent.categoryId.toString() == context.read<AddPropertyCubit>().state.categoryId && context.read<AddPropertyCubit>().state.categoryId.isNotEmpty){
            context.read<AddPropertyCubit>().changeTypeId(category.name ?? "",(category.id ?? "").toString());
          }
        });
      });


      context.read<AddPropertyCubit>().state.staticInfo?.subcategories!.forEach((key,element) {
        // debugPrint("key ==> $key");

        categories.forEach((categories){
          if(element.purpose!.contains(1)){

            if(element.parentId.toString() == "1" ){

              subCategoriesResidential.add(element);
              if(element.id.toString() ==  widget.propertyDetails.propertyTypeId.toString()){
                PropertyType = element.name ?? "";
              }

            }
            if(element.parentId.toString() == "2"){
              // debugPrint("Commercial ==> ${element.name}");
              subCategoriesCommercial.add(element);
              if(element.id.toString() ==  widget.propertyDetails.propertyTypeId.toString()){
                PropertyType = element.name ?? "";
              }
              // debugPrint("Else commercial ==> ${subCategoriesCommercial}");
            }
            if (element.parentId.toString() == "3"){
              subCategoriesAgricultural.add(element);
              if(element.id.toString() ==  widget.propertyDetails.propertyTypeId.toString()){
                PropertyType = element.name ?? "";
              }
              // debugPrint("Agricultural ==> ${element.name}");
              // debugPrint("Agricultural ==> ${element.name}");
            }
            if (element.parentId.toString() == "4"){
              subCategoriesPlotLand.add(element);
              if(element.id.toString() ==  widget.propertyDetails.propertyTypeId.toString()){
                PropertyType = element.name ?? "";
              }
            }
          }

        });



      });





    }

  }

  @override
  Widget build(BuildContext context) {
    // final user = context.read<OrderCubit>().orders!.user;
    // log("${propertyDetails.isFeatured}", name: "Home");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10.0),
            // CustomNetworkImageWidget(
            //   width: 500,
            //   height: 160.69,
            //   image:
            //   "${RemoteUrls.rootUrl}${propertyDetails.thumbnailImage}",
            // ),
            Container(
              width: double.infinity,
              height: 220,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    "${RemoteUrls.rootUrl}${widget.propertyDetails.thumbnailImage}",
                  ),
                  fit: BoxFit.fill,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: widget.propertyDetails.isFeatured == "enable"
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.end,
                      children: [
                        Visibility(
                          visible: widget.propertyDetails.isFeatured == "enable",
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                              onPressed: () {},
                              child: const Text(
                                'Featured',
                                style: TextStyle(
                                  color: Color(0xFFFAFAFA),
                                  fontSize: 12,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w400,
                                  height: 0.12,
                                ),
                              )),
                        ),
                        // Container(
                        //   width: 32,
                        //   height: 32,
                        //   decoration: const ShapeDecoration(
                        //     color: Colors.white,
                        //     shape: OvalBorder(),
                        //     shadows: [
                        //       BoxShadow(
                        //         color: Color(0x194D5454),
                        //         blurRadius: 15,
                        //         offset: Offset(0, 2),
                        //         spreadRadius: 0,
                        //       )
                        //     ],
                        //   ),
                        //   child: Center(
                        //     child: SvgPicture.asset(
                        //         "assets/Yash/images/heartShape.svg"),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 20.h,
            ),

            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // SvgPicture.asset("assets/Yash/images/banglowIcon.svg"),
                  // const SizedBox(
                  //   width: 5,
                  // ),
                  Expanded(
                    child: Text(
                      widget.propertyDetails.purpose.toString() == "1"?"Purpose: For Sell":"Purpose: For Rent",
                      style: TextStyle(
                        color: Color(0x7F4D5454),
                        fontSize: 14,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w400,
                        height: 0.10,
                      ),
                    ),
                  ),]),

            Visibility(
              visible: PropertyType.isNotEmpty,
              child: SizedBox(
                height: 15.h,
              ),
            ),
            Visibility(
              visible: PropertyType.isNotEmpty,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset("assets/Yash/images/banglowIcon.svg"),
                  const SizedBox(
                    width: 5,
                  ),
                   Expanded(
                    child: Text(
                      PropertyType.toString(),
                      style: TextStyle(
                        color: Color(0x7F4D5454),
                        fontSize: 14,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w400,
                        height: 0.10,
                      ),
                    ),
                  ),]),
            ),
            //     // const Spacer(),
            //     //  Text(
            //     //   propertyDetails.,
            //     //   style: TextStyle(
            //     //     color: Color(0x7F4D5454),
            //     //     fontSize: 14,
            //     //     fontFamily: 'DM Sans',
            //     //     fontWeight: FontWeight.w400,
            //     //     height: 0.10,
            //     //   ),
            //     // ),
            //   ],
            // ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.propertyDetails.title,
                    style: const TextStyle(
                      color: Color(0xFF4D5454),
                      fontSize: 16,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w400,
                      height: 0.09,
                    ),
                  ),
                ),
                // const Text(
                //   '4 months ago',
                //   style: TextStyle(
                //     color: Color(0x7F4D5454),
                //     fontSize: 10,
                //     fontFamily: 'Manrope',
                //     fontWeight: FontWeight.w400,
                //     height: 0.14,
                //   ),
                // )
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '₹${widget.propertyDetails.price}',
                    style: const TextStyle(
                      color: Color(0xFF30469A),
                      fontSize: 16,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w600,
                      height: 0.09,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            const Row(
              children: [
                Expanded(
                  child: Text(
                    'About this Property',
                    style: TextStyle(
                      color: Color(0xFF4D5454),
                      fontSize: 16,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w600,
                      height: 0.09,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 10,
            ),
            ReadMoreText(
              text: removeHtmlTags(widget.propertyDetails.description),
              style: const TextStyle(
                color: Color(0x7F4D5454),
                fontSize: 14,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w400,
                height: 1,
              ),
            ),
            Visibility(
              visible: (widget.propertyDetails.totalBedroom ?? "").isNotEmpty || (widget.propertyDetails.totalBathroom ?? "").isNotEmpty,
              child: const SizedBox(
                height: 15,
              ),
            ),

            Visibility(
              visible: (widget.propertyDetails.totalBedroom ?? "").isNotEmpty || (widget.propertyDetails.totalBathroom ?? "").isNotEmpty,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: (widget.propertyDetails.totalBedroom ?? "").isNotEmpty,
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: ShapeDecoration(
                            color: const Color(0x19087C7C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: SvgPicture.asset("assets/Yash/images/BedRoom.svg"),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Bedroom',
                              style: TextStyle(
                                color: Color(0x7F4D5454),
                                fontSize: 12,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w400,
                                height: 0.12,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              '${widget.propertyDetails.totalBedroom} Rooms',
                              style: const TextStyle(
                                color: Color(0xFF4D5454),
                                fontSize: 14,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w400,
                                height: 0.10,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: (widget.propertyDetails.totalBathroom ?? "").isNotEmpty,
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: ShapeDecoration(
                            color: const Color(0x19087C7C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child:
                              SvgPicture.asset("assets/Yash/images/Bathroom.svg"),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Bathroom',
                              style: TextStyle(
                                color: Color(0x7F4D5454),
                                fontSize: 12,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w400,
                                height: 0.12,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              '${widget.propertyDetails.totalBathroom} Rooms',
                              style: const TextStyle(
                                color: Color(0xFF4D5454),
                                fontSize: 14,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w400,
                                height: 0.10,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                  // SizedBox(
                  //   width: 0,
                  // )
                ],
              ),
            ),
            Visibility(
              visible: (widget.propertyDetails.totalGarage ?? "").isNotEmpty || (widget.propertyDetails.totalKitchen ?? "").isNotEmpty,
              child: const SizedBox(
                height: 15,
              ),
            ),
            Visibility(
              visible: (widget.propertyDetails.totalGarage ?? "").isNotEmpty || (widget.propertyDetails.totalKitchen ?? "").isNotEmpty,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: (widget.propertyDetails.totalGarage ?? "").isNotEmpty,
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: ShapeDecoration(
                            color: const Color(0x19087C7C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: SvgPicture.asset("assets/Yash/images/Garage.svg"),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Garage',
                              style: TextStyle(
                                color: Color(0x7F4D5454),
                                fontSize: 12,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w400,
                                height: 0.12,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              '${widget.propertyDetails.totalGarage} Rooms',
                              style: const TextStyle(
                                color: Color(0xFF4D5454),
                                fontSize: 14,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w400,
                                height: 0.10,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: (widget.propertyDetails.totalKitchen ?? "").isNotEmpty,
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: ShapeDecoration(
                            color: const Color(0x19087C7C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: SvgPicture.asset("assets/Yash/images/kitchen.svg"),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Kitchen',
                              style: TextStyle(
                                color: Color(0x7F4D5454),
                                fontSize: 12,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w400,
                                height: 0.12,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              '${widget.propertyDetails.totalKitchen} Rooms',
                              style: const TextStyle(
                                color: Color(0xFF4D5454),
                                fontSize: 14,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w400,
                                height: 0.10,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                  // SizedBox(
                  //   width: 0,
                  // )
                ],
              ),
            ),
            // GridView.builder(
            //   padding: EdgeInsets.zero,
            //   shrinkWrap: true,
            //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 2, // 3 columns
            //     childAspectRatio: 7 / 2, // Adjust as needed to fit your design
            //     mainAxisSpacing: 10,
            //     crossAxisSpacing: 50,
            //   ),
            //   itemCount: 4,
            //   // Total items (2 rows * 3 columns)
            //   itemBuilder: (context, index) {
            //     return Container(
            //       decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //       child: Row(
            //         children: [
            //           Container(
            //             width: 36,
            //             height: 36,
            //             decoration: ShapeDecoration(
            //               color: const Color(0x19087C7C),
            //               shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(10),
            //               ),
            //             ),
            //             child: SvgPicture.asset(
            //                 "assets/Yash/images/available${index + 1}.svg"),
            //           ),
            //           const SizedBox(
            //             width: 5,
            //           ),
            //           const Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Text(
            //                 'Bedrooms',
            //                 style: TextStyle(
            //                   color: Color(0x7F4D5454),
            //                   fontSize: 12,
            //                   fontFamily: 'DM Sans',
            //                   fontWeight: FontWeight.w400,
            //                   height: 0.12,
            //                 ),
            //               ),
            //               SizedBox(
            //                 height: 15,
            //               ),
            //               Text(
            //                 '4 Rooms',
            //                 style: TextStyle(
            //                   color: Color(0xFF4D5454),
            //                   fontSize: 14,
            //                   fontFamily: 'DM Sans',
            //                   fontWeight: FontWeight.w400,
            //                   height: 0.10,
            //                 ),
            //               )
            //             ],
            //           ),
            //         ],
            //       ),
            //     );
            //   },
            // ),

            // Row(
            //   children: [
            //      Expanded(
            //       child: Text(
            //         ReadMoreText(text: removeHtmlTags(propertyDetails.description),),
            //         style: TextStyle(
            //           color: Color(0x7F4D5454),
            //           fontSize: 14,
            //           fontFamily: 'DM Sans',
            //           fontWeight: FontWeight.w400,
            //           height: 1,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(
            //   height: 16,
            // ),
            // const SizedBox(
            //   width: 339,
            //   child: Text(
            //     'Read More',
            //     style: TextStyle(
            //       color: Color(0xFF30469A),
            //       fontSize: 14,
            //       fontFamily: 'DM Sans',
            //       fontWeight: FontWeight.w400,
            //       height: 0.10,
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 25,
            // ),
            // const SizedBox(
            //   width: 339,
            //   child: Text(
            //     'Outdoor facilities',
            //     style: TextStyle(
            //       color: Color(0xFF4D5454),
            //       fontSize: 16,
            //       fontFamily: 'DM Sans',
            //       fontWeight: FontWeight.w600,
            //       height: 0.09,
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 25,
            // ),
            // SizedBox(
            //   height: 100,
            //   child: ListView.builder(
            //       itemCount: 3,
            //       shrinkWrap: true,
            //       scrollDirection: Axis.horizontal,
            //       itemBuilder: (context, index) {
            //         return Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 15),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             children: [
            //               Container(
            //                 width: 36,
            //                 height: 36,
            //                 decoration: ShapeDecoration(
            //                   color: const Color(0x19087C7C),
            //                   shape: RoundedRectangleBorder(
            //                     borderRadius: BorderRadius.circular(10),
            //                   ),
            //                 ),
            //                 child: SvgPicture.asset(
            //                     "assets/Yash/images/available${index + 1}.svg"),
            //               ),
            //               const SizedBox(
            //                 height: 10,
            //               ),
            //               const Row(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   SizedBox(
            //                     width: 100,
            //                     child: Text(
            //                       'Swimming Pool',
            //                       textAlign: TextAlign.center,
            //                       style: TextStyle(
            //                         color: Color(0xFF4D5454),
            //                         fontSize: 14,
            //                         fontFamily: 'DM Sans',
            //                         fontWeight: FontWeight.w400,
            //                         height: 1,
            //                       ),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //               const SizedBox(
            //                 height: 8,
            //               ),
            //               const Row(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   SizedBox(
            //                     width: 104,
            //                     height: 17,
            //                     child: Text(
            //                       '2 KM',
            //                       textAlign: TextAlign.center,
            //                       style: TextStyle(
            //                         color: Color(0x7F4D5454),
            //                         fontSize: 12,
            //                         fontFamily: 'DM Sans',
            //                         fontWeight: FontWeight.w400,
            //                         height: 0.12,
            //                       ),
            //                     ),
            //                   )
            //                 ],
            //               ),
            //             ],
            //           ),
            //         );
            //       }),
            // ),
            const SizedBox(
              height: 25,
            ),
            const Row(
              children: [
                Expanded(
                  child: Text(
                    ' Location',
                    style: TextStyle(
                      color: Color(0xFF4D5454),
                      fontSize: 16,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w600,
                      height: 0.09,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15.0),
            Row(
              children: [
                SvgPicture.asset("assets/Yash/images/locationIcon.svg"),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    "${widget.propertyDetails.address}",
                    maxLines: 2,
                    style: const TextStyle(
                      color: Color(0x7F4D5454),
                      fontSize: 14,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w400,
                      height: 1,
                    ),
                  ),
                ),
              ],
            ),
           SizedBox(
             height: 10,
           ),
           Text("Aminities"),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              height: 35,
              child: ListView.builder(
                itemCount: widget.propertyDetails.aminityItemDto.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      // width: 150,
                      // height: 150,
                      decoration: ShapeDecoration(
                        color: const Color(0x19087C7C),
                        // image: DecorationImage(
                        //   image: NetworkImage(
                        //     "${RemoteUrls.rootUrl}${widget.propertyDetails.images![int].image}",
                        //   ),
                        //   fit: BoxFit.fill,
                        // ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: Center(child: Text(widget.propertyDetails.aminityItemDto[index].aminity.aminity)),
                    );
                  }),
            ),
            const SizedBox(height: 80.0),
            // Container(
            //   width: double.infinity,
            //   height: 175,
            //   decoration: ShapeDecoration(
            //     image: const DecorationImage(
            //       image: AssetImage("assets/Yash/images/mapImage.png"),
            //       fit: BoxFit.fill,
            //     ),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(18),
            //     ),
            //   ),
            //   child: Container(
            //     width: double.infinity,
            //     height: 175,
            //     decoration: ShapeDecoration(
            //       color: const Color(0x354D5454),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(18),
            //       ),
            //     ),
            //     child: Center(
            //       child: ElevatedButton(
            //           style: ElevatedButton.styleFrom(
            //               backgroundColor: primaryColor,
            //               shape: RoundedRectangleBorder(
            //                   borderRadius: BorderRadius.circular(10.0))),
            //           onPressed: () {},
            //           child: const Text(
            //             'View on map',
            //             style: TextStyle(
            //               color: Colors.white,
            //               fontSize: 12,
            //               fontFamily: 'DM Sans',
            //               fontWeight: FontWeight.w400,
            //               height: 0.12,
            //             ),
            //           )),
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }

  String getRemainingDay(String date) {
    if (date.contains('/') || date.contains('-') || date.contains(':')) {
      return Utils.formatDate(date);
    } else {
      return date;
    }
  }

  Widget tableContent(String text, String value, {bool isLast = false}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0)
              .copyWith(bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //  crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextStyle(
                text: text,
                fontWeight: FontWeight.w500,
                fontSize: 15.0,
              ),
              CustomTextStyle(
                text: value,
                fontWeight: FontWeight.w500,
                fontSize: 15.0,
              ),
            ],
          ),
        ),
        Container(
          height: 1.0,
          width: double.infinity,
          color: isLast ? transparent : borderColor,
        ),
      ],
    );
  }

  Widget paymentContent(String text, String value, {bool isLast = false}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0)
              .copyWith(bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //  crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextStyle(
                text: text,
                fontWeight: FontWeight.w500,
                fontSize: 15.0,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                decoration: BoxDecoration(
                    color: value == 'success' ? greenColor : redColor,
                    borderRadius: borderRadius),
                child: CustomTextStyle(
                  text: value,
                  color: whiteColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 1.0,
          width: double.infinity,
          color: isLast ? transparent : borderColor,
        ),
      ],
    );
  }

  Widget _addressComponent(String text, String value) {
    return Row(
      children: [
        CustomTextStyle(
          text: '$text: ',
          color: blackColor,
          fontSize: 15.0,
        ),
        CustomTextStyle(
          text: value,
          color: grayColor,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        )
      ],
    );
  }

  Widget _propertyComponent(String text, String value) {
    return Row(
      children: [
        CustomTextStyle(
          text: '$text: ',
          color: blackColor,
          fontSize: 15.0,
        ),
        CustomTextStyle(
          text: value,
          color: primaryColor,
          fontSize: 16.0,
          maxLine: 2,
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w600,
        )
      ],
    );
  }
}

class ReadMoreText extends StatefulWidget {
  final String text;
  final int maxLines;
  final TextStyle style;

  const ReadMoreText({
    Key? key,
    required this.text,
    this.maxLines = 3,
    required this.style,
  }) : super(key: key);

  @override
  _ReadMoreTextState createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: widget.style,
          maxLines: _isExpanded ? null : widget.maxLines,
          overflow: TextOverflow.ellipsis,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Text(
            _isExpanded ? 'Read Less' : 'Read More',
            style: TextStyle(
              color: Colors.blue,
              fontSize: widget.style.fontSize ?? 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
