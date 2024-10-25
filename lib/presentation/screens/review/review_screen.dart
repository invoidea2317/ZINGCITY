import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/presentation/utils/k_images.dart';
import '/presentation/widget/empty_widget.dart';
import '../../../../presentation/widget/custom_rounded_app_bar.dart';
import '../../../data/model/review/review_model.dart';
import '../../../logic/cubit/review/review_cubit.dart';
import '../../utils/constraints.dart';
import '../../widget/custom_test_style.dart';
import '../../widget/loading_widget.dart';
import 'component/single_review_card.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final reviewCubit = context.read<ReviewCubit>();
    reviewCubit.getReviewList();
    return Scaffold(
      appBar: const CustomRoundedAppBar(text: 'All Review'),
      body: BlocBuilder<ReviewCubit, ReviewState>(
        builder: (context, state) {
          if (state is ReviewLoading) {
            return const LoadingWidget();
          } else if (state is ReviewError) {
            if (state.statusCode == 503) {
              return ReviewLoadedWidget(reviews: reviewCubit.reviews);
            } else {
              return Center(
                child: CustomTextStyle(
                  text: state.message,
                  color: redColor,
                  fontSize: 20.0,
                ),
              );
            }
          } else if (state is ReviewLoaded) {
            return ReviewLoadedWidget(reviews: state.reviews);
          }
          return const Center(
              child: CustomTextStyle(text: 'Something went wrong'));
        },
      ),
    );
  }
}

class ReviewLoadedWidget extends StatelessWidget {
  const ReviewLoadedWidget({super.key, required this.reviews});
  final List<ReviewModel> reviews;

  @override
  Widget build(BuildContext context) {
    if (reviews.isNotEmpty) {
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        itemCount: reviews.length,
        itemBuilder: (context, index) =>
            SingleReviewCard(review: reviews[index]),
      );
    } else {
      return Container(
        alignment: Alignment.center,
        child: const EmptyWidget(
            icon: KImages.emptyReview, title: 'No Review Found!'),
      );
    }
  }
}
