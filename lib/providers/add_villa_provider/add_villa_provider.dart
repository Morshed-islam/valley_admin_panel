import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_valley_admin/utills/enums.dart';

class AddVillaProvider with ChangeNotifier {
  int maxGuests = -1;
  int children = -1;
  int adult = -1;
  String dailyRent = '';
  String tax = '';
  String cleaningFees = '';
  String serviceFees = '';
  String extraOptions = '';
  String airportPickupFee = '';
  String extraBedsFee = '';
  String villaName = '';
  String description = '';
  String location = '';
  String price = '';


  bool isSubmitting = false;


  int bedrooms = -1;
  int livingRooms = -1;
  int kitchens = -1;
  int bathrooms = -1;
  int gyms = -1;


  //Amnities
  bool amKitchen = false;
  bool amWifi = false;
  bool amDedicatedWorkspace = false;
  bool amFreeParking = false;
  bool amPool = false;
  bool amPrivateHub = false;
  bool amPetsAllowed = false;
  bool amTv = false;
  bool amWasher = false;
  bool amDryer = false;

  List<TextEditingController> _imageControllers = [];
  List<TextEditingController> get imageControllers => _imageControllers;

  ///================================================

  // Method to add villa and its details to Firestore
  Future<void> addVilla({
    required BuildContext context,
    required String id,
    required List<String> imageUrls, // For first image and the array of images
  }) async {
    isSubmitting = true;
    notifyListeners();
    try {
      // Add to 'all_villas' collection
      await FirebaseFirestore.instance.collection('all_villas').doc(id).set({
        'id': id,
        'name': villaName,
        'location': location,
        'price': price,
        'img_url': imageUrls.isNotEmpty ? imageUrls[0] : '', // Store the first image URL
        'is_favourite': false,
        'created_at': DateTime.now().toString(),
      });

      // Add to 'villa_details' sub-collection under the same villa ID
      await FirebaseFirestore.instance.collection('villa_details').doc(id).set({
        'adults': adult.toString(),
        'airport_pickup': airportPickupFee,
        'am_dedicated_workspace': amDedicatedWorkspace,
        'am_dryer': amDryer,
        'am_free_parking': amFreeParking,
        'am_kitchen': amKitchen,
        'am_pet_allowed': amPetsAllowed,
        'am_pool': amPool,
        'am_private_hot_hub': amPrivateHub,
        'am_tv': amTv,
        'am_washer': amWasher,
        'am_wifi': amWifi,
        'bathroom': bathrooms.toString(),
        'bed_room': bedrooms.toString(),
        'children': children.toString(),
        'cleaning_fees': cleaningFees,
        'daily_rent': dailyRent,
        'desc': description,
        'extra_beds': extraBedsFee,
        'gym': gyms.toString(),
        'id': id,
        'kitchen': kitchens.toString(),
        'living_room': livingRooms.toString(),
        'max_guest': maxGuests.toString(),
        'review': '5',
        'service_fees': serviceFees,
        'title': villaName,
        'images': imageUrls, // Store all image URLs
        'is_booked': false,
        'tax': tax,
      });

      isSubmitting = false;

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Successfully villa added!')));

      clearsAllFields();
      notifyListeners(); // Notify listeners to update UI
    } catch (error) {
      isSubmitting = false;

      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to add villa!')));
      log("Error adding villa: $error");
    }
  }


  void addImageField() {
      _imageControllers.add(TextEditingController());
      notifyListeners();
  }

  void removeImageField(int index) {
      if (_imageControllers.length > 1) {
        _imageControllers[index].dispose();
        _imageControllers.removeAt(index);
      }
    notifyListeners();

  }

  clearsAllFields(){
    villaName = '';
    description = '';
    location = '';
    dailyRent = '';
    cleaningFees = '';
    serviceFees = '';
    airportPickupFee = '';
    extraBedsFee = '';
    bedrooms = -1;
    livingRooms = -1;
    kitchens = -1;
    bathrooms = -1;
    gyms = -1;
    adult = -1;
    children = -1;
    maxGuests = -1;
    notifyListeners();
  }

  void updateAmenities(AMENITIES amenities, bool value) {
    switch (amenities) {
      case AMENITIES.kitchen:
        amKitchen = value;
        break;
      case AMENITIES.wifi:
        amWifi = value;
        break;
      case AMENITIES.dedicatedWorkspace:
        amDedicatedWorkspace = value;
        break;
      case AMENITIES.freeParking:
        amFreeParking = value;
        break;
      case AMENITIES.pool:
        amPool = value;
        break;
      case AMENITIES.privateHub:
        amPrivateHub = value;
        break;
      case AMENITIES.petsAllowed:
        amPetsAllowed = value;
        break;
      case AMENITIES.tv:
        amTv = value;
        break;
      case AMENITIES.washer:
        amWasher = value;
        break;
      case AMENITIES.dryer:
        amDryer = value;
        break;

      default:
        break;
    }
  }



  List<String> selectedAmenities = [];

  void updateVillaName(String value) {
    villaName = value;
    notifyListeners();
  }

  void updateDescription(String value) {
    description = value;
    notifyListeners();
  }

  void updateLocation(String value) {
    location = value;
    notifyListeners();
  }
  void updatePrice(String value) {
    price = value;
    notifyListeners();
  }

  void updateGuests(int value) {
    maxGuests = value;
    notifyListeners();
  }

  void updateChildren(int value) {
    children = value;
    notifyListeners();
  }

  void updateAdult(int value) {
    adult = value;
    notifyListeners();
  }

  void updateDailyRent(String value) {
    dailyRent = value;
    notifyListeners();
  }

  void updateTax(String value) {
    tax = value;
    notifyListeners();
  }
  void updateCleaningFees(String value) {
    cleaningFees = value;
    notifyListeners();
  }

  void updateServiceFees(String value) {
    serviceFees = value;
    notifyListeners();
  }

  void updateExtraOptions(String value) {
    extraOptions = value;
    notifyListeners();
  }

  void updateAirportPickupFee(String value) {
    airportPickupFee = value;
    notifyListeners();
  }

  void updateExtraBedsFee(String value) {
    extraBedsFee = value;
    notifyListeners();
  }

  void incrementBedrooms() {
    bedrooms++;
    notifyListeners();
  }

  void decrementBedrooms() {
    if (bedrooms > 0) bedrooms--;
    notifyListeners();
  }

  void incrementLivingRooms() {
    livingRooms++;
    notifyListeners();
  }

  void decrementLivingRooms() {
    if (livingRooms > 0) livingRooms--;
    notifyListeners();
  }

  void incrementKitchens() {
    kitchens++;
    notifyListeners();
  }

  void decrementKitchens() {
    if (kitchens > 0) kitchens--;
    notifyListeners();
  }

  void incrementBathrooms() {
    bathrooms++;
    notifyListeners();
  }

  void decrementBathrooms() {
    if (bathrooms > 0) bathrooms--;
    notifyListeners();
  }

  void incrementGyms() {
    gyms++;
    notifyListeners();
  }

  void decrementGyms() {
    if (gyms > 0) gyms--;
    notifyListeners();
  }

  void toggleAmenity(String amenity) {
    if (selectedAmenities.contains(amenity)) {
      log("contains $amenity");
      selectedAmenities.remove(amenity);
    } else {
      log("contains not $amenity");

      selectedAmenities.add(amenity);
    }
    notifyListeners();
  }
}
