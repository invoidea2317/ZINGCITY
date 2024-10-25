import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/model/order/single_order_model.dart';
import '../../../logic/cubit/order/order_cubit.dart';
import '../../utils/constraints.dart';
import '../../utils/k_images.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_test_style.dart';
import '../../widget/empty_widget.dart';
import '../../widget/loading_widget.dart';
import 'component/purchase_component.dart';

class PurchaseScreen extends StatelessWidget {
  const PurchaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderCubit = context.read<OrderCubit>();
    orderCubit.getAllOrders();
    return Scaffold(
      appBar: const CustomAppBar(title: 'Purchase History'),
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (state is OrderLoading) {
            return const LoadingWidget();
          } else if (state is OrderError) {
            if (state.statusCode == 503) {
              return LoadedOrderWidget(orders: orderCubit.orders!.orders!);
            } else {
              return Center(
                  child: CustomTextStyle(text: state.message, color: redColor));
            }

            //Utils.errorSnackBar(context, state.message);
          }

          // else if (state is OrderLoaded) {
          //   return LoadedOrderWidget(orders: state.orders.orders!);
          // }
          return LoadedOrderWidget(orders: orderCubit.orders!.orders!);
        },
      ),
    );
  }
}

class LoadedOrderWidget extends StatelessWidget {
  const LoadedOrderWidget({super.key, required this.orders});

  final List<SingleOrderModel> orders;

  @override
  Widget build(BuildContext context) {
    if (orders.isNotEmpty) {
      return ListView.builder(
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 13.0.w, vertical: 30.0.h)
              .copyWith(top: 0.0),
          itemCount: orders.length,
          itemBuilder: (context, index) {
            return PurchaseComponent(singleOrder: orders[index]);
          });
    } else {
      return const Center(
        child: EmptyWidget(
            icon: KImages.emptyPurchase, title: 'Empty Purchase History'),
      );
    }
  }
}
