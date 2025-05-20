import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:peakmart/core/widgets/waiting_widget.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/custom_appbar.dart';
import 'package:peakmart/features/map_screen/cubit/cubit.dart';
import 'package:peakmart/features/map_screen/cubit/states.dart';

import '../../core/resources/color_manager.dart';

class MapLocationScreen extends StatefulWidget {
  const MapLocationScreen({super.key});

  @override
  _MapLocationScreenState createState() => _MapLocationScreenState();
}

class _MapLocationScreenState extends State<MapLocationScreen> {
  GoogleMapController? _controller;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ViewMapCubit(),
      child: Scaffold(
        appBar: CustomAppBar(title: 'Select Location'),

        body: BlocBuilder<ViewMapCubit, ViewMapState>(
          builder: (context, state) {
            if(state.initialCameraPosition == null){
              return const Center(child: WaitingWidget());
            }
            return Column(
              children: [
                Expanded(
                  child: GoogleMap(
                    initialCameraPosition: state.initialCameraPosition ??
                        const CameraPosition(
                          target: LatLng(30.0444, 31.2357),
                          zoom: 15,
                        ),
                    markers: Set<Marker>.of(state.markers),
                    onMapCreated: (controller) {
                      _controller = controller;
                      // تحريك الكاميرا للموقع الحالي إذا توفر
                      if (state.initialCameraPosition != null) {
                        controller.animateCamera(
                          CameraUpdate.newCameraPosition(
                              state.initialCameraPosition!),
                        );
                      }
                    },
                    onTap: (latLng) {
                      context.read<ViewMapCubit>().updateLocation(latLng);
                      _controller?.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: latLng,
                            zoom: 15,
                          ),
                        ),
                      );
                    },
                    scrollGesturesEnabled: true,
                    zoomGesturesEnabled: true,
                    tiltGesturesEnabled: true,
                    rotateGesturesEnabled: true,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined,
                              color: ColorManager.primary),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              state.address,
                              style: TextStyle(
                                  color: ColorManager.primary, fontSize: 16.sp),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: state.address == 'No address selected' ||
                                state.address.startsWith('Error')
                            ? null
                            : () {
                                Navigator.pop(context, {
                                  'address':
                                      context.read<ViewMapCubit>().getAddress(),
                                  'location': context
                                      .read<ViewMapCubit>()
                                      .getSelectedLatLng(),
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
