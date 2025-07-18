import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Bid_Mart/app/app_prefs.dart';
import 'package:Bid_Mart/app/di.dart';
import 'package:Bid_Mart/features/auth/presentation/shared_widgets/custom_appbar.dart';
import 'package:Bid_Mart/features/profile/presentation/state_m/user_products/user_products_cubit.dart';
import 'package:Bid_Mart/features/profile/presentation/views/user_products/widgets/enrolled_products_tab.dart';
import 'package:Bid_Mart/features/profile/presentation/views/user_products/widgets/uploaded_products_tab.dart';
import 'package:Bid_Mart/features/profile/presentation/views/user_products/widgets/wishlist_tab.dart';

class UserProductsView extends StatefulWidget {
  static const String routeName = '/userProductsView';

  const UserProductsView({super.key});

  @override
  State<UserProductsView> createState() => _UserProductsViewState();
}

class _UserProductsViewState extends State<UserProductsView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final bool isSeller = instance<AppPreferences>().getCookie("HKH").isNotEmpty;
  late UserProductsCubit _userProductsCubit;
  bool _enrolledFetched = false;
  bool _uploadedFetched = false;

  @override
  void initState() {
    super.initState();
    initProfileModule();
    _tabController = TabController(length: isSeller ? 3 : 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _userProductsCubit = instance<UserProductsCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && !_enrolledFetched) {
        _enrolledFetched = true;
        _userProductsCubit.getEnrolledProducts();
      }
    });
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) return;

    if (_tabController.index == 2 && isSeller && !_uploadedFetched) {
      _uploadedFetched = true;
      _userProductsCubit.getUploadedProducts();
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _userProductsCubit,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Your Products',
          bottomWidget: TabBar(
            controller: _tabController,
            indicatorWeight: 2,
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 40),
            splashBorderRadius: BorderRadius.circular(15),
            tabs: [
              const Tab(text: 'Enrolled'),
              const Tab(
                text: 'WishList',
              ),
              if (isSeller) const Tab(text: 'Uploaded'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            const EnrolledProductsTab(),
            const WishListTab(),
            if (isSeller) const UploadedProductsTab(),
          ],
        ),
      ),
    );
  }
}
