import 'package:flutter/material.dart';
import 'package:flutter_code/data/models/place_model.dart';
import 'package:flutter_code/view_models/firebase_view_model.dart';
import 'package:flutter_code/view_models/maps_view_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../utils/styles/app_text_style.dart';
import '../maps/google_map_screen.dart';
class AddressesScreen extends StatefulWidget {
  const AddressesScreen({super.key});
  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}
class _AddressesScreenState extends State<AddressesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Addresses"),
      ),
      body: StreamBuilder<List<PlaceModel>>(
        stream: context.read<FirebaseViewModel>().getAllPlaceModel(),
        builder:
            (BuildContext context, AsyncSnapshot<List<PlaceModel>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List<PlaceModel> placeList = snapshot.data ?? [];
          return placeList.isEmpty
              ? Column(
                  children: [
                    Expanded(
                        child: Center(
                            child:
                                Lottie.asset("assets/lottie/location.json"))),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GoogleMapsScreen(
                                      placeModel: PlaceModel.initialValue(),
                                      update: false,
                                    )),
                          );
                        },
                        child: Text(
                          "Add New Address",
                          style: AppTextStyle.interMedium
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: placeList.length,
                        itemBuilder: (BuildContext context, int index) {
                          PlaceModel place = placeList[index];
                          return Dismissible(
                              key: ValueKey<String>(place.placeName),
                              confirmDismiss:
                                  (DismissDirection direction) async {
                                if (direction == DismissDirection.startToEnd) {
                                  return await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Deleting'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(true);
                                            },
                                            child: const Text('Yes'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                            },
                                            child: const Text('No'),
                                          )
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  context
                                      .read<MapsViewModel>()
                                      .setLatInitialLong(place.latLng);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GoogleMapsScreen(
                                              placeModel: place,
                                              update: true,
                                            )),
                                  );
                                }

                                return null;
                              },
                              onDismissed: (direction) async {
                                await context
                                    .read<FirebaseViewModel>()
                                    .deleteCategory(
                                      place.id!,
                                      context,
                                    );
                              },
                              //delete qilish uchun===========================================
                              background: Container(
                                color: Colors.red,
                                child: Center(
                                  child: Text(
                                    "Deleting",
                                    style: AppTextStyle.interSemiBold.copyWith(
                                      fontSize: 40,
                                      letterSpacing: 10,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              //rrename qilish uchun===============================
                              secondaryBackground: Container(
                                color: Colors.green,
                                child: Center(
                                  child: Text(
                                    "Rename",
                                    style: AppTextStyle.interSemiBold.copyWith(
                                      fontSize: 40,
                                      letterSpacing: 10,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                child: Ink(
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    color: Colors.amber,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: ListTile(
                                                title: Text(
                                                  placeList[index].placeName,
                                                  style: AppTextStyle
                                                      .interSemiBold
                                                      .copyWith(),
                                                ),
                                                subtitle: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      placeList[index]
                                                          .orientAddress,
                                                      style: AppTextStyle
                                                          .interRegular
                                                          .copyWith(),
                                                    ),
                                                    RichText(
                                                      text: TextSpan(
                                                          text:
                                                              "House Number: ${placeList[index].entrance.isEmpty ? " Not" : placeList[index].entrance}",
                                                          style: AppTextStyle
                                                              .interRegular
                                                              .copyWith(),
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  " House Flat:  ${placeList[index].flatNumber.isEmpty ? " Not" : placeList[index].flatNumber}",
                                                              style: AppTextStyle
                                                                  .interRegular
                                                                  .copyWith(),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  " House Stage: ${placeList[index].stage.isEmpty ? " Not" : placeList[index].stage}",
                                                              style: AppTextStyle
                                                                  .interRegular
                                                                  .copyWith(),
                                                            )
                                                          ]),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            placeList[index].image,
                                            width: 50,
                                            height: 50,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text(
                                              placeList[index].placeName,
                                              style: AppTextStyle.interSemiBold
                                                  .copyWith(
                                                      color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GoogleMapsScreen(
                                      placeModel: PlaceModel.initialValue(),
                                      update: false,
                                    )),
                          );
                        },
                        child: Text(
                          "Add New Address",
                          style: AppTextStyle.interMedium
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                );
        },
      ),
    );
  }
}
