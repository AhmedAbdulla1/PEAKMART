import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ViewMapState extends Equatable {
  final List<Marker> markers;
  final String address;
  final CameraPosition? initialCameraPosition;

  const ViewMapState({
    required this.markers,
    required this.address,
    this.initialCameraPosition,
  });

  factory ViewMapState.initial() {
    return const ViewMapState(
      markers: [],
      address: 'No address selected',
      initialCameraPosition: null,
    );
  }

  ViewMapState copyWith({
    List<Marker>? markers,
    String? address,
    CameraPosition? initialCameraPosition,
  }) {
    return ViewMapState(
      markers: markers ?? this.markers,
      address: address ?? this.address,
      initialCameraPosition: initialCameraPosition ?? this.initialCameraPosition,
    );
  }

  @override
  List<Object?> get props => [markers, address, initialCameraPosition];
}