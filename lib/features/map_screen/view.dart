import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:Bid_Mart/core/resources/color_manager.dart';
import 'package:Bid_Mart/core/widgets/waiting_widget.dart';
import 'package:Bid_Mart/features/auth/presentation/shared_widgets/custom_appbar.dart';
import 'package:Bid_Mart/features/map_screen/cubit/cubit.dart';
import 'package:Bid_Mart/features/map_screen/cubit/states.dart';

class MapLocationScreen extends StatefulWidget {
  const MapLocationScreen({super.key});

  @override
  State<MapLocationScreen> createState() => _MapLocationScreenState();
}

class _MapLocationScreenState extends State<MapLocationScreen> {
  GoogleMapController? _controller;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ViewMapCubit(),
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Select Location'),
        body: BlocBuilder<ViewMapCubit, ViewMapState>(
          builder: (context, state) {
            if (state.initialCameraPosition == null) {
              return const Center(child: WaitingWidget());
            }

            return Column(
              children: [
                Expanded(
                  child: GoogleMap(
                    initialCameraPosition: state.initialCameraPosition!,
                    markers: Set<Marker>.of(state.markers),
                    onMapCreated: (controller) {
                      _controller = controller;

                      // تحريك الكاميرا للموقع الحالي
                      controller.animateCamera(
                        CameraUpdate.newCameraPosition(state.initialCameraPosition!),
                      );
                    },
                    onTap: (latLng) {
                      context.read<ViewMapCubit>().updateLocation(latLng);
                      _controller?.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(target: latLng, zoom: 15),
                        ),
                      );
                    },
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    zoomGesturesEnabled: true,
                    tiltGesturesEnabled: true,
                    scrollGesturesEnabled: true,
                    rotateGesturesEnabled: true,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined, color: ColorManager.primary),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              state.address,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: ColorManager.primary,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: state.address == 'No address selected' || state.address.startsWith('Error')
                            ? null
                            : () {
                                Navigator.pop(context, {
                                  'address': context.read<ViewMapCubit>().getAddress(),
                                  'location': context.read<ViewMapCubit>().getSelectedLatLng(),
                                });
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.primary,
                          foregroundColor: Colors.white,
                          minimumSize: Size(double.infinity, 48.h),
                        ),
                        child: const Text('Confirm'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
