import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_code/screens/maps/widgets/button.dart';
import 'package:flutter_code/utils/size/size_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:provider/provider.dart';

import '../../data/models/place_model.dart';
import '../../utils/images/app_images.dart';
import '../../utils/styles/app_text_style.dart';
import '../../view_models/maps_view_model.dart';
import 'dialogs.dart';
import 'map_type_item.dart';

class GoogleMapsScreen extends StatefulWidget {
  final PlaceModel? placeModel;
  final bool update;

  const GoogleMapsScreen({
    this.placeModel,
    this.update = false,
    super.key,
  });

  @override
  State<GoogleMapsScreen> createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  TextEditingController _controller = TextEditingController();
  PlaceModel placeModel = PlaceModel.initialValue();
  LatLng? latLng;
  late String image;

  _init() {
    if (widget.placeModel!.image.isNotEmpty) {
      placeModel = widget.placeModel!;
    }
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _searchPlaces(String query) {
    // Here you can call the Places API to get search results and update the UI accordingly
    // This is a placeholder function for demonstration purposes
    print("Searching for: $query");
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(
        "---------------------------------------------------------------------build run");
    CameraPosition? cameraPosition;
    return Scaffold(
      body: Consumer<MapsViewModel>(
        builder: (context, viewModel, child) {
          return Stack(

            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
                child: GooglePlacesAutoCompleteTextFormField(
                  textEditingController: _controller,
                  googleAPIKey: "YOUR_GOOGLE_API_KEY",
                  proxyURL: "YOUR_PROXY_URL",
                  debounceTime: 400,
                  countries: ["de"],
                  isLatLngRequired: true,
                  getPlaceDetailWithLatLng: (prediction) {
                    print("Coordinates: (${prediction.lat},${prediction.lng})");
                  },
                  itmClick: (prediction) {
                    _controller.text = prediction.description!;
                    _controller.selection = TextSelection.fromPosition(TextPosition(offset: prediction.description!.length));
                    final newLatLng = LatLng(prediction.lat! as double, prediction.lng! as double);
                    context.read<MapsViewModel>();
                  },
                ),
              ),
              GoogleMap(
                zoomControlsEnabled: false,
                markers: viewModel.markers,
                onCameraIdle: () {
                  if (cameraPosition != null) {
                    context
                        .read<MapsViewModel>()
                        .changeCurrentLocation(cameraPosition!);
                  }
                },
                onCameraMove: (CameraPosition currentCameraPosition) {
                  cameraPosition = currentCameraPosition;
                  latLng = currentCameraPosition.target;
                  debugPrint(
                      "CURRENT POSITION:${currentCameraPosition.target.longitude}");
                },
                mapType: viewModel.mapType,
                initialCameraPosition: viewModel.initialCameraPosition,
                onMapCreated: (GoogleMapController createdController) {
                  viewModel.controller.complete(createdController);
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
                child: TextField(
                  controller: _controller,
                  onSubmitted: _searchPlaces,
                  decoration: InputDecoration(
                    label: Text(
                      "Search",
                      style: AppTextStyle.interRegular
                          .copyWith(color: Colors.grey),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 5,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                child: Image.asset(
                  AppImages.location,
                  width: 50,
                  height: 50,
                ),
              ),
              Positioned(
                top: 100,
                right: 0,
                left: 0,
                child: Text(
                  viewModel.currentPlaceName,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.interSemiBold.copyWith(
                    fontSize: 24,
                  ),
                ),
              ),
              Positioned(
                bottom: 100,
                right: 0,
                left: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: buttons(
                    image: (String value) {
                      image = value;
                    },
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 0,
                left: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.amber,
                    ),
                    child: InkWell(
                      onTap: () {
                        if (latLng != null) {
                          addressDetailDialog(
                            address: viewModel.currentPlaceName,
                            context: context,
                            placeModel: placeModel,
                            image: widget.placeModel!.image.isEmpty
                                ? image
                                : widget.placeModel!.image,
                            latLng: latLng!,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Location not selected"),
                            ),
                          );
                        }
                      },
                      child: Center(
                        child: Text(
                          "Saqlash",
                          style: AppTextStyle.interMedium.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showMenu(
            context: context,
            position: RelativeRect.fromLTRB(1, 1, 0, 0),
            items: [
              PopupMenuItem(
                child: const Text("Normal"),
                onTap: () {
                  context.read<MapsViewModel>().changeMapType(MapType.normal);
                },
              ),
              PopupMenuItem(
                child: const Text("Hybrid"),
                onTap: () {
                  context.read<MapsViewModel>().changeMapType(MapType.hybrid);
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
            ],
          );
        },
        child: Icon(
          Icons.map_rounded,
        ),
      ),
    );
  }
}
