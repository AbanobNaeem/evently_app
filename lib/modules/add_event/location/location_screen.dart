import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({super.key});

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  LatLng? selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Event Location"),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: selectedLocation == null
                ? null
                : () {
              // رجع الـ location للشاشة اللي فاتت
              Navigator.pop(context, selectedLocation);
            },
          )
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(30.0444, 31.2357),
          initialZoom: 13,
          onTap: (tapPosition, point) {
            setState(() {
              selectedLocation = point;
            });
          },
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png',
            subdomains: ['a', 'b', 'c', 'd'],
            userAgentPackageName: 'com.example.evently_app',
          ),
          if (selectedLocation != null)
            MarkerLayer(
              markers: [
                Marker(
                  point: selectedLocation!,
                  width: 80,
                  height: 80,
                  child: const Icon(
                    Icons.location_on,
                    size: 40,
                    color: Colors.red,
                  )
                ),
              ],
            ),
        ],
      ),
    );
  }
}