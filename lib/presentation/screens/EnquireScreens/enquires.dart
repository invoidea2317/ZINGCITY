import 'package:real_estate/logic/cubit/add_property/add_property_state_model.dart';

import '../../../data/data_provider/remote_url.dart';
import '../../../data/model/agency/agency_details_model.dart';
import '../../../state_inject_package_names.dart';
import '../../router/route_names.dart';
import '../../widget/customnetwork_widget.dart';
import '../home/home_screen.dart';

class EnquiryScreen extends StatefulWidget {
 final List<dynamic> properties;
 final bool isRequest;
  const EnquiryScreen({super.key, required this.properties, required this.isRequest});

  @override
  State<EnquiryScreen> createState() => _EnquiryScreenState();
}

class _EnquiryScreenState extends State<EnquiryScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // context.read<AddPropertyCubit>().getProperties();
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyCubit, AddPropertyModel>(
      builder: (context, state) {

        // final update = widget.addState;
        // if (update is ProfileUpdateLoading) {
        //   log(_className, name: update.toString());
        // } else if (update is ProfileUpdateError) {
        //   Utils.errorSnackBar(context, update.message);
        // } else if (update is ProfileUpdateLoaded) {
        //   Navigator.of(context).pop();
        //   //Utils.showSnackBar(context, update.message);
        // }


        // if (update is AddPropertyLoaded) {
        //   WidgetsBinding.instance.addPostFrameCallback((_) {
        //     ScaffoldMessenger.of(context).clearSnackBars();
        //     Navigator.of(context).pop();
        //     // ScaffoldMessenger.of(context).showSnackBar(
        //     //     SnackBar(content: Text(update.message)));
        //   });
        //
        //   // return CircularProgressIndicator();
        // }
        //
        // if (update is AddPropertyLoading) {
        //   WidgetsBinding.instance.addPostFrameCallback((_) {
        //     ScaffoldMessenger.of(context).clearSnackBars();
        //     Utils.loadingDialog(context);
        //     // ScaffoldMessenger.of(context).showSnackBar(
        //     //     SnackBar(content: Text(update.message)));
        //   });
        //
        //   // return CircularProgressIndicator();
        // } else {
        //   Utils.closeDialog(context);
        //   if (update is AddPropertyError) {
        //
        //     if (update.statusCode == 401) {
        //       Utils.logout(context);
        //     } else {
        //
        //       debugPrint("This is the Error ${update.message}");
        //       WidgetsBinding.instance.addPostFrameCallback((_) {
        //         ScaffoldMessenger.of(context).clearSnackBars();
        //         ScaffoldMessenger.of(context).showSnackBar(
        //             SnackBar(content: Text(update.message)));
        //       });
        //
        //       // Utils.errorSnackBar(context, update.message);
        //     }
        //
        //   } else if (update is AddPropertyLoaded) {
        //     // Navigator.of(context).pop();
        //     ScaffoldMessenger.of(context).clearSnackBars();
        //     WidgetsBinding.instance.addPostFrameCallback((_) {
        //       ScaffoldMessenger.of(context).showSnackBar(
        //           SnackBar(content: Text(update.message)));
        //     });
        //
        //   }
        // }


        return Scaffold(
          extendBody: true,
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: const Size(
              360,
              120,
            ),
            child: Container(
                width: 360,
                height: 200,
                decoration: const BoxDecoration(
                  color: Color(0xFFE7EBF4),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x1E000000),
                      blurRadius: 8,
                      offset: Offset(0, 1),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.only(top: 10.0, left: 16, right: 16),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/Yash/images/ZingCityLogo.png",
                            width: 50.03,
                            height: 35.01,
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
                          // if (pageController.page == 0) {
                          //   Navigator.pop(context);
                          // } else {
                          //   pageController.previousPage(
                          //       duration: const Duration(milliseconds: 300),
                          //       curve: Curves.easeIn);
                          // }
                        },
                        child:  Row(
                          children: [
                            Icon(
                              Icons.arrow_back_ios,
                            ),
                            Text(
                              widget.isRequest?'Enquiries Requests':'Your Enquiries',
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                    physics:
                    const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14),
                    shrinkWrap: true,
                    itemCount: widget.properties.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                        const EdgeInsets.only(top: 10.0,),
                        child: GestureDetector(
                          onTap: (){

                            Navigator.pushNamed(context,
                                RouteNames.purchaseDetailsScreen,
                                arguments: widget.properties[index]);
                            // Navigator.pushNamed(
                            //     context, RouteNames.purchaseDetailsScreen,arguments: index.toString());
                          },
                          child: Container(
                            width: 324,
                            height: 68,
                            decoration: ShapeDecoration(
                              color: const Color(0x0C398BCB),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(10),
                              ),
                            ),
                            child: Row(
                              children: [
                                // Container(
                                //   width: 78.93,
                                //   height: 78.93,
                                //   decoration: ShapeDecoration(
                                //     image:
                                //          DecorationImage(
                                //       image: NetworkImage(
                                //         "${RemoteUrls.rootUrl}${homeCubit
                                //             .homeModel!
                                //             .latestProperty![index]
                                //             .thumbnailImage}"),
                                //       fit: BoxFit.fill,
                                //     ),
                                //     shape:
                                //         RoundedRectangleBorder(
                                //       borderRadius:
                                //           BorderRadius.circular(
                                //               10),
                                //     ),
                                //   ),
                                // ),

                                CustomNetworkImageWidget(
                                  width: 78.93,
                                  height: 78.93,
                                  image:
                                  "${RemoteUrls.rootUrl}${widget.properties[index].thumbnailImage}",
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(
                                      left: 15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                    children: [
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            widget.properties[index].title,
                                            style: const TextStyle(
                                              color:
                                              Colors.black,
                                              fontSize: 14,
                                              fontFamily:
                                              'DM Sans',
                                              fontWeight:
                                              FontWeight
                                                  .w700,
                                              height: 0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .start,
                                        children: [
                                          const Icon(
                                            Icons
                                                .location_on_sharp,
                                            size: 12,
                                          ),
                                          SizedBox(
                                            width: 200,
                                            child: Text(
                                              removeHtmlTags( widget.properties[index].address),
                                              maxLines: 1,
                                              style: const TextStyle(
                                                color:
                                                Colors.black,
                                                fontSize: 14,
                                                fontFamily:
                                                'DM Sans',
                                                fontWeight:
                                                FontWeight
                                                    .w300,
                                                height: 0,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      // const SizedBox(
                                      //   height: 5,
                                      // ),
                                      // Row(
                                      //   children: [
                                      //     Image.asset(
                                      //       "assets/images/iconamoon_profile-light.png",
                                      //       height: 12,
                                      //     ),
                                      //     const SizedBox(
                                      //       width: 5,
                                      //     ),
                                      //      Text(
                                      //       widget.homeDataLoaded?.latestProperties?[index]. ?? "",
                                      //       style: TextStyle(
                                      //         color:
                                      //             Colors.black,
                                      //         fontSize: 13,
                                      //         fontFamily:
                                      //             'DM Sans',
                                      //         fontWeight:
                                      //             FontWeight
                                      //                 .w300,
                                      //         height: 0,
                                      //       ),
                                      //     )
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                ),
                                // Spacer(),
                                // GestureDetector(
                                //   onTap: () {
                                //     Navigator.push(
                                //         context, MaterialPageRoute(builder: (context) =>  AddPropertyScreen(property: widget.properties?[index],)));
                                //   },
                                //   child: const Icon(
                                //     Icons.edit,
                                //     color: Color(0xFF30469A),
                                //   ),
                                // ),
                                // SizedBox(
                                //   width: 10,
                                // ),
                                // GestureDetector(
                                //   onTap: () {
                                //     // Navigator.pushNamed(
                                //     //     context, RouteNames.purchaseDetailsScreen,arguments: index.toString());
                                //   },
                                //   child: const Icon(
                                //     Icons.delete,
                                //     color: Color(0xFF30469A),
                                //   ),
                                // ),
                                // SizedBox(
                                //   width: 10,
                                // ),
                                // Column(
                                //   crossAxisAlignment: CrossAxisAlignment.end,
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     GestureDetector(
                                //       onTap: () {
                                //         // Navigator.pushNamed(
                                //         //     context, RouteNames.purchaseDetailsScreen,arguments: index.toString());
                                //       },
                                //       child: const Icon(
                                //         Icons.edit,
                                //         color: Color(0xFF30469A),
                                //       ),
                                //     ),
                                //    SizedBox(
                                //       height: 10,
                                //    ),
                                //      GestureDetector(
                                //       onTap: () {
                                //         // Navigator.pushNamed(
                                //         //     context, RouteNames.purchaseDetailsScreen,arguments: index.toString());
                                //       },
                                //       child: const Icon(
                                //         Icons.delete,
                                //         color: Color(0xFF30469A),
                                //       ),
                                //     ),
                                //
                                //
                                //
                                //     // IconButton(
                                //     //   onPressed: () {
                                //     //     // Navigator.pushNamed(
                                //     //     //     context, RouteNames.purchaseDetailsScreen,arguments: index.toString());
                                //     //   },
                                //     //   icon: const Icon(
                                //     //     Icons.edit,
                                //     //     color: Color(0xFF30469A),
                                //     //   ),
                                //     // ),
                                //     // IconButton(
                                //     //   onPressed: () {
                                //     //     // Navigator.pushNamed(
                                //     //     //     context, RouteNames.purchaseDetailsScreen,arguments: index.toString());
                                //     //   },
                                //     //   icon: const Icon(
                                //     //     Icons.delete,
                                //     //     color: Color(0xFF30469A),
                                //     //   ),
                                //     // ),
                                //   ],
                                // )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}