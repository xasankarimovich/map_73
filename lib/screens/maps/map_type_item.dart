import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../view_models/maps_view_model.dart';

class MapTypeItem extends StatelessWidget {
  const MapTypeItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Stack(
        children: [

          Positioned(
            top: 40,
            // left: 0,
            right: 10,
            child: PopupMenuButton(
              padding: const EdgeInsets.all(0),
              splashRadius: 50,
              icon: const Icon(Icons.map, color: Colors.white,size: 50,),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: const Text("Normal"),
                    onTap: () {
                      context
                          .read<MapsViewModel>()
                          .changeMapType(MapType.normal);
                    },
                  ),
                  PopupMenuItem(
                    child: const Text("Hybrid"),
                    onTap: () {
                      context
                          .read<MapsViewModel>()
                          .changeMapType(MapType.hybrid);
                    },
                  ),
                  PopupMenuItem(
                    child: const Text("Satellite"),
                    onTap: () {
                      context
                          .read<MapsViewModel>()
                          .changeMapType(MapType.satellite);
                    },
                  ),
                ];
              },
            ),
          )
        ],
      ),
    );
  }
}