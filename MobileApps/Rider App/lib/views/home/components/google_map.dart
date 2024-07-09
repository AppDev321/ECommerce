// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:razinshop_rider/gen/assets.gen.dart';

class GoogleMapView extends StatefulWidget {
  final double latitude;
  final double longitude;
  const GoogleMapView({
    Key? key,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  GoogleMapViewState createState() => GoogleMapViewState();
}

class GoogleMapViewState extends State<GoogleMapView> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  late CameraPosition _kGooglePlex;
  BitmapDescriptor? _bitmapDescriptor;

  @override
  void initState() {
    super.initState();
    _kGooglePlex = CameraPosition(
      target: LatLng(widget.latitude, widget.longitude),
      zoom: 16.4746,
    );
    getMarker();
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<void> getMarker() async {
    final Uint8List markerIcon =
        await getBytesFromAsset(Assets.pngs.pinPickup.keyName, 120);

    _bitmapDescriptor = BitmapDescriptor.fromBytes(markerIcon);

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.future.then((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_bitmapDescriptor == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return GoogleMap(
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      mapType: MapType.terrain,
      initialCameraPosition: _kGooglePlex,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      markers: {
        Marker(
            markerId: const MarkerId('customerMarker'),
            position: LatLng(widget.latitude, widget.longitude),
            icon: _bitmapDescriptor!,
            anchor: const Offset(0.5, 1)),
      },
    );
  }
}
