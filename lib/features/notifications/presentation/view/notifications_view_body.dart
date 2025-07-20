import 'package:Bid_Mart/core/error_ui/toast.dart';
import 'package:Bid_Mart/core/resources/color_manager.dart';
import 'package:Bid_Mart/core/resources/extentions.dart';
import 'package:Bid_Mart/core/resources/font_manager.dart';
import 'package:Bid_Mart/core/resources/string_manager.dart';
import 'package:Bid_Mart/core/resources/style_manager.dart';
import 'package:Bid_Mart/features/auth/presentation/shared_widgets/custom_appbar.dart';
import 'package:Bid_Mart/features/notifications/domain/notification_enitity.dart';
import 'package:Bid_Mart/features/notifications/presentation/state_m/notification_cubit.dart';
import 'package:Bid_Mart/features/notifications/presentation/widgets/notification_card.dart';
import 'package:Bid_Mart/features/profile/presentation/views/settings/notification_switch_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class NotificationsViewBody extends StatefulWidget {
  const NotificationsViewBody({super.key, required this.notifications});
  final List<NotificationEntity> notifications;

  @override
  State<NotificationsViewBody> createState() => _NotificationsViewBodyState();
}

class _NotificationsViewBodyState extends State<NotificationsViewBody> {
  late List<NotificationEntity> localNotifications;

  @override
  void initState() {
    super.initState();
    localNotifications = List.from(widget.notifications);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.notifications,
        isNotShowArrowBack: true,
        centerTitle: false,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: NotificationSwitchIconOnly(),
          ),
        ],
      ),
      body: localNotifications.isEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  LottieBuilder.asset(
                    "assets/lottie/no_notifications.json",
                    height: 200.h,
                    width: 200.w,
                    fit: BoxFit.cover,
                  ),
                  8.vGap,
                  Text(
                    "You don't have any notifications currently.",
                    textAlign: TextAlign.center,
                    style: getMediumStyle(
                      fontSize: FontSize.s20,
                      color: ColorManager.red,
                    ),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: () async {
                await context.read<NotificationCubit>().fetchNotifications();
              },
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: localNotifications.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final item = localNotifications[index];
                  final isSeen = item.seen == "1";

                  return Dismissible(
                    key: Key(item.id.toString()),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      child: const CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.red,
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                    ),
                    onDismissed: (_) {
                      setState(() {
                        localNotifications.removeAt(index);
                      });
                      context
                          .read<NotificationCubit>()
                          .deleteNotification(item.id);
                      Toast.show(
                        "Notification '${item.title}' deleted successfully",
                        backgroundColor: ColorManager.red,
                      );
                    },
                    child: NotificationCard(item: item, isSeen: isSeen),
                  );
                },
              ),
            ),
    );
  }
}

String formatTimeAgo(String createdAt) {
  final now = DateTime.now();
  final createdTime = DateTime.tryParse(createdAt);
  if (createdTime == null) return '';

  final difference = now.difference(createdTime);

  if (difference.inSeconds < 60) {
    return 'Just now';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
  } else if (difference.inDays < 7) {
    return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
  } else {
    return '${createdTime.day}/${createdTime.month}/${createdTime.year}';
  }
}
