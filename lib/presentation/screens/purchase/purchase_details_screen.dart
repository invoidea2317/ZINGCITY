import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/presentation/utils/utils.dart';
import '../../../data/model/order/single_order_model.dart';
import '../../../logic/cubit/order/order_cubit.dart';
import '../../utils/constraints.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_test_style.dart';
import '../../widget/loading_widget.dart';

class PurchaseDetailScreen extends StatelessWidget {
  const PurchaseDetailScreen({super.key, required this.orderId});
  final String orderId;

  @override
  Widget build(BuildContext context) {
    final orderCubit = context.read<OrderCubit>();
    orderCubit.getOrderDetails(orderId);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
      actions: [
        IconButton(onPressed: (){}, icon: const Icon(Icons.share))
      ],
      ),
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          // if (state is OrderLoading) {
          //   return const LoadingWidget();
          // } else if (state is OrderError) {
          //   if (state.statusCode == 503) {
          //     return OrderDetailLoaded(orderDetail: orderCubit.singleOrder!);
          //   } else {
          //     return Center(
          //         child: CustomTextStyle(text: state.message, color: redColor));
          //   }
          //
          //   //Utils.errorSnackBar(context, state.message);
          // }

          return OrderDetailLoaded(orderDetail:  null
          //orderCubit.singleOrder!
          );
        },
      ),
    );
  }
}

class OrderDetailLoaded extends StatelessWidget {
  const OrderDetailLoaded({super.key,  this.orderDetail});
  final SingleOrderModel? orderDetail;

  @override
  Widget build(BuildContext context) {
    // final user = context.read<OrderCubit>().orders!.user;
    return const Column(
      children: [

      ],
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
