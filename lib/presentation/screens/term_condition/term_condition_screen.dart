import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../presentation/utils/constraints.dart';
import '../../../../presentation/widget/custom_rounded_app_bar.dart';
import '../../../../presentation/widget/custom_test_style.dart';
import '../../../logic/cubit/privacy_policy/privacy_policy_cubit.dart';
import '../../widget/loading_widget.dart';

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({super.key});

  Widget conditionText(String heading, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextStyle(
          text: heading,
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
          color: blackColor,
        ),
        const SizedBox(height: 4.0),
        Text(
          text,
          textAlign: TextAlign.justify,
          style: GoogleFonts.dmSans(
              height: 1.6,
              fontWeight: FontWeight.w400,
              color: grayColor,
              fontSize: 14.0),
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final privacyCubit = context.read<PrivacyPolicyCubit>();
    privacyCubit.getTermsAndCondition();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(360, 116.37,),
        child: Container(
          width: 360,
          height: 116.37,
          decoration: const BoxDecoration(
            color: Color(0xFFE7EBF4),
            boxShadow: [
              BoxShadow(
                color: Color(0x1E000000),
                blurRadius: 8,
                offset: Offset(0, 1),
                spreadRadius: 0,
              )
            ], 
          ),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios,),
                      Text(
                        'Terms & Conditions',
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
          )
        ),
      ),
      body: BlocBuilder<PrivacyPolicyCubit, PrivacyPolicyState>(
        builder: (context, state) {
          if (state is PrivacyPolicyLoading) {
            return const LoadingWidget();
          } else if (state is PrivacyPolicyError) {
            if (state.statusCode == 503) {
              return LoadedTermsCondition(
                  termsConditionText: privacyCubit.termsConditionText!);
            } else {
              return Center(
                child: CustomTextStyle(
                  text: state.message,
                  color: redColor,
                  fontSize: 20.0,
                ),
              );
            }
          } else if (state is TermsAndConditionLoaded) {
            return LoadedTermsCondition(
                termsConditionText: state.termsConditions);
          }
          return const Center(
              child: CustomTextStyle(text: 'Something went wrong'));
        },
      ),
    );
  }
}

class LoadedTermsCondition extends StatelessWidget {
  const LoadedTermsCondition({super.key, required this.termsConditionText});
  final String termsConditionText;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: borderRadius,
      ),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Html(
            data: termsConditionText,
            style: {
              'p': Style(
                textAlign: TextAlign.justify,
              ),
            },
          ),
        ],
      ),
    );
  }
}
