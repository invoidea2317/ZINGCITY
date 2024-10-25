import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

import '../../../../../logic/cubit/home/cubit/property_details_cubit.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_test_style.dart';

class PropertyDetailsTab extends StatelessWidget {
  PropertyDetailsTab({super.key});
  List<String> locations = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PropertyDetailsCubit, PropertyDetailsState>(
      builder: (context, state) {
        if (state is PropertyDetailsLoaded) {
          final detail = state.singlePropertyModel.propertyItemModel;
          final additional = state.singlePropertyModel;
          if (additional.nearestLocations!.isNotEmpty) {
            for (int i = 0; i < additional.nearestLocations!.length; i++) {
              if (additional.nearestLocations![i].location != null) {
                String notNullLocation =
                    additional.nearestLocations![i].location!.location;
                //print('notNullLocation $notNullLocation');
                locations.add(notNullLocation);
              } else {
                // print('NullLocation');
                locations.add('No Location');
              }
            }
          }
          return Column(
            children: [
              ReadMoreText(
                Utils.htmlTextConverter(detail!.description),
                trimLines: 4,
                trimCollapsedText: 'Read More',
                trimExpandedText: 'Show Less',
                trimLength: 180,
                moreStyle: GoogleFonts.poppins(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: primaryColor),
                lessStyle: GoogleFonts.poppins(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: primaryColor),
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: grayColor),
              ),
              Utils.verticalSpace(20),
              InfoSection(
                  title: "Additional Details",
                  listWidget: Wrap(
                    runAlignment: WrapAlignment.spaceEvenly,
                    children: [
                      ...List.generate(
                        additional.additionalInformations!.length,
                        (index) => AdditionalInfo(
                          title1:
                              additional.additionalInformations![index].addKey,
                          value1: additional
                              .additionalInformations![index].addValue,
                        ),
                      ),
                    ],
                  )),
              Utils.verticalSpace(20),
              InfoSection(
                  title: "Nearest Location",
                  listWidget: Wrap(
                    runAlignment: WrapAlignment.spaceEvenly,
                    children: [
                      ...List.generate(
                        additional.nearestLocations!.length,
                        (index) {
                          return AdditionalInfo(
                            title1: locations[index],
                            value1:
                                '${additional.nearestLocations![index].distance ?? ''}KM',
                          );
                        },
                      ),
                    ],
                  )),
              Utils.verticalSpace(20),
              InfoSection(
                  title: "Aminites",
                  listWidget: Wrap(
                    runAlignment: WrapAlignment.spaceEvenly,
                    children: [
                      ...List.generate(
                        additional.aminities!.length,
                        (index) => Row(children: [
                          const Icon(Icons.done),
                          Utils.horizontalSpace(6),
                          Text(additional.aminities![index].aminity!.aminity)
                        ]),
                      ),
                    ],
                  )),
              Utils.verticalSpace(40),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class InfoSection extends StatelessWidget {
  const InfoSection({
    super.key,
    required this.title,
    required this.listWidget,
  });

  final String title;
  final Widget listWidget;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: primaryColor,
      dashPattern: const [6, 6, 6],
      borderPadding: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      radius: const Radius.circular(4),
      child: Container(
        decoration: BoxDecoration(
            color: scaffoldBackground, borderRadius: borderRadius),
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextStyle(
              text: title,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: primaryColor,
            ),
            Utils.verticalSpace(12),
            listWidget,
          ],
        ),
      ),
    );
  }
}

class AdditionalInfo extends StatelessWidget {
  const AdditionalInfo(
      {super.key,
      required this.title1,
      required this.value1,
      this.showBorder = true});
  final String title1;
  final String value1;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CustomTextStyle(
              text: title1 ?? 'No title',
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: blackColor,
            ),
            Utils.horizontalSpace(20),
            CustomTextStyle(
              text: value1,
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: grayColor,
            ),
          ],
        ),
        showBorder
            ? Container(
                height: 1.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                color: primaryColor.withOpacity(0.12),
              )
            : const SizedBox(),
      ],
    );
  }
}
