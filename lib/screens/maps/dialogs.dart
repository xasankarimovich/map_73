import 'package:flutter/material.dart';
import 'package:flutter_code/screens/maps/widgets/text_field.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../data/models/place_model.dart';
import '../../../utils/images/app_images.dart';
import '../../../view_models/firebase_view_model.dart';
import '../widgets/adress.dart';
addressDetailDialog({
  required BuildContext context,
  required PlaceModel placeModel,
  required String image,
  required LatLng latLng,
  required String address,
}) {
  final TextEditingController addressController = address.isEmpty
      ? TextEditingController()
      : TextEditingController(text: address);
  final TextEditingController entranceController = placeModel.image.isEmpty
      ? TextEditingController()
      : TextEditingController(text: placeModel.entrance);
  final TextEditingController floorController = placeModel.image.isEmpty
      ? TextEditingController()
      : TextEditingController(text: placeModel.flatNumber);
  final TextEditingController homeController = placeModel.image.isEmpty
      ? TextEditingController()
      : TextEditingController(text: placeModel.flatNumber);
  final TextEditingController orientController = placeModel.image.isEmpty
      ? TextEditingController()
      : TextEditingController(text: placeModel.orientAddress);

  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Add Adress",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 8,
                ),
                child: Text(
                  "Now Address",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: TextField(
                  controller: addressController,
                  inputFormatters: [],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Row(
                  children: [
                    Expanded(
                        child: NumberField(
                      controller: entranceController,
                      text: 'Entrance',
                    )),
                    Expanded(
                        child: NumberField(
                      controller: floorController,
                      text: 'Floor',
                    )),
                    Expanded(
                        child: NumberField(
                      controller: homeController,
                      text: 'Home',
                    )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: TextField(
                  controller: orientController,
                  decoration: const InputDecoration(hintText: "Yaqinroq joy"),
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    context.read<FirebaseViewModel>().insertPlaceModel(
                        PlaceModel(
                            image: image ?? AppImages.home,
                            placeName: addressController.text,
                            entrance: entranceController.text,
                            flatNumber: floorController.text,
                            stage: homeController.text,
                            orientAddress: orientController.text,
                            latLng: latLng),
                        context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddressesScreen()));
                  },
                  child: const Text("SAVE PLACE"),
                ),
              ),
            ],
          ),
        );
      });
}
