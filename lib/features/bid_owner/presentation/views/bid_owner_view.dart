import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/features/bid_owner/presentation/state_mang/add_product_cubit/add_product_cubit.dart';
import 'package:peakmart/features/bid_owner/presentation/state_mang/add_product_cubit/image_picker_controller.dart';
import 'package:peakmart/features/bid_owner/presentation/views/widgets/add_product_view_body.dart';
import 'package:provider/provider.dart';

class BidOwnerView extends StatefulWidget {
  const BidOwnerView({super.key});

  static const routeName = "/bid_owner";

  @override
  State<BidOwnerView> createState() => _BidOwnerViewState();
}

class _BidOwnerViewState extends State<BidOwnerView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ImagePickerController(),
      child: SafeArea(
        child: BlocProvider(
          create: (context) => AddProductCubit()..checkIsASeller(),
          child: BlocConsumer<AddProductCubit, AddProductState>(
              listener: (context, state) {},
              builder: (context, state) {
                return const AddProductViewBody();
              }),
        ),
      ),
    );
  }
}
