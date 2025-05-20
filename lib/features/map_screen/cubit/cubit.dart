import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:peakmart/features/map_screen/cubit/states.dart';

class ViewMapCubit extends Cubit<ViewMapState> {
  ViewMapCubit() : super(ViewMapState.initial()) {
    _initialize();
  }

  LatLng _selectedLatLng = const LatLng(30.0444, 31.2357); // القاهرة افتراضيًا
  String _address = 'No address selected';
  CameraPosition? _initialCameraPosition;

  CameraPosition? get initialCameraPosition => _initialCameraPosition;

  Future<void> _initialize() async {
    await _getCurrentLocation();
    await _updateMarkerAndAddress(_selectedLatLng);
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(state.copyWith(address: 'Location services are disabled.'));
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.deniedForever) {
          emit(state.copyWith(address: 'Location permissions are denied.'));
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        emit(state.copyWith(address: 'Location permissions are permanently denied.'));
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      _selectedLatLng = LatLng(position.latitude, position.longitude);
      _initialCameraPosition = CameraPosition(
        target: _selectedLatLng,
        zoom: 15,
      );
      emit(state.copyWith(initialCameraPosition: _initialCameraPosition));
    } catch (e) {
      emit(state.copyWith(address: 'Error fetching location: $e'));
    }
  }

  Future<void> _updateMarkerAndAddress(LatLng latLng) async {
    _selectedLatLng = latLng;

    // تحديث العلامة
    final marker = Marker(
      markerId: const MarkerId('selected_location'),
      position: _selectedLatLng,
      draggable: true,
      onDragEnd: (newPosition) => updateLocation(newPosition),
      infoWindow: const InfoWindow(title: 'Selected Location'),
    );
    emit(state.copyWith(markers: [marker]));

    // تحويل الإحداثيات إلى عنوان
    try {
      final placemarks = await placemarkFromCoordinates(
        _selectedLatLng.latitude,
        _selectedLatLng.longitude,
      );
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        _address = [
          place.street,
          place.subLocality,
          place.locality,
          place.administrativeArea,
          place.country
        ].where((e) => e != null && e.isNotEmpty).join(', ');
        if (_address.isEmpty) _address = 'No address found';
      } else {
        _address = 'No address found';
      }
    } catch (e) {
      _address = 'Error fetching address: $e';
    }
    emit(state.copyWith(address: _address));
  }

  void updateLocation(LatLng newPosition) {
    _updateMarkerAndAddress(newPosition);
  }

  String getAddress() => _address;
  LatLng getSelectedLatLng() => _selectedLatLng;
}