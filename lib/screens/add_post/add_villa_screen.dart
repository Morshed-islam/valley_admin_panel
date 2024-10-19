import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:new_valley_admin/utills/enums.dart';
import 'package:provider/provider.dart';

import '../../providers/add_villa_provider/add_villa_provider.dart';
import '../../utills/app_constant.dart';

class AddVillaPage extends StatefulWidget {
  @override
  State<AddVillaPage> createState() => _AddVillaPageState();
}

class _AddVillaPageState extends State<AddVillaPage> {
  List<TextEditingController> _imageControllers = [];
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _imageControllers.add(TextEditingController());
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    // Dispose of all controllers
    for (var controller in _imageControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addImageField() {
    setState(() {
      _imageControllers.add(TextEditingController());
    });
  }

  void _removeImageField(int index) {
    setState(() {
      if (_imageControllers.length > 1) {
        _imageControllers[index].dispose();
        _imageControllers.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final addPostProvider = Provider.of<AddVillaProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Villa'),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.3, vertical: 8),
        child: addPostProvider.isSubmitting ? const SizedBox(height:50,child: CircularProgressIndicator()) : ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          onPressed: () {
            _validation(addPostProvider);
          },
          child: const Text('Add Villa', style: TextStyle(color: Colors.white)),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ///==================================

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    _buildTextInputField(
                      context: context,
                      title: 'Villa Name',
                      value: addPostProvider.villaName.toString(),
                      onChanged: (val) => addPostProvider.updateVillaName(val),
                    ),
                    _buildTextInputField(
                      context: context,
                      title: 'Villa Description',
                      value: addPostProvider.description.toString(),
                      onChanged: (val) => addPostProvider.updateDescription(val),
                    ),
                    _buildTextInputField(
                      context: context,
                      textInput: TextInputType.number,
                      title: 'Villa Price',
                      value: addPostProvider.price.toString(),
                      onChanged: (val) => addPostProvider.updatePrice(val),
                    ),
                    _buildTextInputField(
                      context: context,
                      title: 'Villa Location',
                      value: addPostProvider.location.toString(),
                      onChanged: (val) => addPostProvider.updateLocation(val),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 1), borderRadius: BorderRadius.circular(3)),
                      height: 170,
                      child: ListView.builder(
                        itemCount: _imageControllers.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              TextField(
                                controller: _imageControllers[index],
                                decoration: InputDecoration(
                                  labelText: 'Image URL ${index + 1}',
                                  border: const OutlineInputBorder(),
                                  suffixIcon: SizedBox(
                                    width: 100,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.add),
                                          onPressed: () => _addImageField(),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete),
                                          onPressed: () => _removeImageField(index),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              // Divider
              const Divider(
                thickness: 2,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 10,
              ),

              ///==================================
              // Max Guests Input
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    _buildNumberInputSection(
                      title: 'Max Guests',
                      value: addPostProvider.maxGuests.toString(),
                      onIncrement: () => addPostProvider.updateGuests(addPostProvider.maxGuests + 1),
                      onDecrement: () => addPostProvider.updateGuests(addPostProvider.maxGuests - 1),
                    ),
                    _buildNumberInputSection(
                      title: 'Children',
                      value: addPostProvider.children.toString(),
                      onIncrement: () => addPostProvider.updateChildren(addPostProvider.children + 1),
                      onDecrement: () => addPostProvider.updateChildren(addPostProvider.children - 1),
                    ),
                    _buildNumberInputSection(
                      title: 'Adult',
                      value: addPostProvider.adult.toString(),
                      onIncrement: () => addPostProvider.updateAdult(addPostProvider.adult + 1),
                      onDecrement: () => addPostProvider.updateAdult(addPostProvider.adult - 1),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              // Divider
              const Divider(
                thickness: 2,
                color: Colors.grey,
              ),

              // Daily Rent Input
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    _buildTextInputField(
                      context: context,
                      title: 'Daily Rent',
                      value: addPostProvider.dailyRent.toString(),
                      onChanged: (val) => addPostProvider.updateDailyRent(val),
                    ),

                    // Cleaning Fees
                    _buildTextInputField(
                      context: context,
                      title: 'Cleaning Fees',
                      value: addPostProvider.cleaningFees.toString(),
                      onChanged: (val) => addPostProvider.updateCleaningFees(val),
                    ),

                    // Service Fees
                    _buildTextInputField(
                      context: context,
                      title: 'Service Fees',
                      value: addPostProvider.serviceFees.toString(),
                      onChanged: (val) => addPostProvider.updateServiceFees(val),
                    ),

                    _buildTextInputField(
                      context: context,
                      title: 'Tax (%)',
                      value: addPostProvider.tax.toString(),
                      onChanged: (val) => addPostProvider.updateTax(val),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              // Divider
              const Divider(
                thickness: 2,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 10,
              ),

              const Text("Extra Options", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    // Airport Pickup Fee
                    _buildTextInputField(
                      context: context,
                      title: 'Airport Pickup Fee',
                      value: addPostProvider.airportPickupFee.toString(),
                      onChanged: (val) => addPostProvider.updateAirportPickupFee(val),
                    ),

                    // Extra Beds Fee
                    _buildTextInputField(
                      context: context,
                      title: 'Extra Beds Fee',
                      value: addPostProvider.extraBedsFee.toString(),
                      onChanged: (val) => addPostProvider.updateExtraBedsFee(val),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              // Divider
              const Divider(
                thickness: 2,
                color: Colors.grey,
              ),
              // Room Counters
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    _buildNumberInputSection(
                      title: 'Bedrooms',
                      value: addPostProvider.bedrooms.toString(),
                      onIncrement: addPostProvider.incrementBedrooms,
                      onDecrement: addPostProvider.decrementBedrooms,
                    ),
                    _buildNumberInputSection(
                      title: 'Living Rooms',
                      value: addPostProvider.livingRooms.toString(),
                      onIncrement: addPostProvider.incrementLivingRooms,
                      onDecrement: addPostProvider.decrementLivingRooms,
                    ),
                    _buildNumberInputSection(
                      title: 'Kitchens',
                      value: addPostProvider.kitchens.toString(),
                      onIncrement: addPostProvider.incrementKitchens,
                      onDecrement: addPostProvider.decrementKitchens,
                    ),
                    _buildNumberInputSection(
                      title: 'Bathrooms',
                      value: addPostProvider.bathrooms.toString(),
                      onIncrement: addPostProvider.incrementBathrooms,
                      onDecrement: addPostProvider.decrementBathrooms,
                    ),
                    _buildNumberInputSection(
                      title: 'Gyms',
                      value: addPostProvider.gyms.toString(),
                      onIncrement: addPostProvider.incrementGyms,
                      onDecrement: addPostProvider.decrementGyms,
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              // Divider
              const Divider(
                thickness: 2,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 10,
              ),
              // Top Amenities Checkboxes
              const Text("Top Amenities", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
              _buildAmenityCheckbox(context, 'Kitchen', addPostProvider, AMENITIES.kitchen),
              _buildAmenityCheckbox(context, 'Wifi', addPostProvider, AMENITIES.wifi),
              _buildAmenityCheckbox(context, 'Dedicated workspace', addPostProvider, AMENITIES.dedicatedWorkspace),
              _buildAmenityCheckbox(context, 'Free parking on premises', addPostProvider, AMENITIES.freeParking),
              _buildAmenityCheckbox(context, 'Pool', addPostProvider, AMENITIES.pool),
              _buildAmenityCheckbox(context, 'Private hot tub', addPostProvider, AMENITIES.privateHub),
              _buildAmenityCheckbox(context, 'Pets allowed', addPostProvider, AMENITIES.petsAllowed),
              _buildAmenityCheckbox(context, 'TV', addPostProvider, AMENITIES.tv),
              _buildAmenityCheckbox(context, 'Washer', addPostProvider, AMENITIES.washer),
              _buildAmenityCheckbox(context, 'Dryer', addPostProvider, AMENITIES.dryer),
            ],
          ),
        ),
      ),
    );
  }

  // Increment/Decrement Section
  Widget _buildNumberInputSection({required String title, required String value, required Function onIncrement, required Function onDecrement}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18)),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () => onDecrement(),
            ),
            Text(value, style: const TextStyle(fontSize: 18)),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => onIncrement(),
            ),
          ],
        ),
      ],
    );
  }

  // Text Input Section
  Widget _buildTextInputField({required BuildContext context, required String title, required String value, required Function(String) onChanged, TextInputType? textInput}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        keyboardType: textInput ?? TextInputType.text,
        decoration: InputDecoration(
          labelText: title,
          border: const OutlineInputBorder(),
        ),
        onChanged: onChanged,
      ),
    );
  }

  // Amenity Checkbox Section
  Widget _buildAmenityCheckbox(BuildContext context, String amenity, AddVillaProvider provider, AMENITIES amenities) {
    return CheckboxListTile(
      title: Text(amenity),
      value: provider.selectedAmenities.contains(amenity),
      onChanged: (bool? value) {
        provider.updateAmenities(amenities, value!);
        provider.toggleAmenity(amenity);
      },
    );
  }

  void _validation(AddVillaProvider provider) {
    List<String> imageUrls = _imageControllers.where((controller) => controller.text.isNotEmpty).map((controller) => controller.text).toList();

    if (provider.villaName.isEmpty) {
      alertMessage('Please input villa name');
      return;
    } else if (provider.description.isEmpty) {
      alertMessage('Please input description ');
      return;
    } else if (provider.price.isEmpty) {
      alertMessage('Please input price');
      return;
    } else if (provider.location.isEmpty) {
      alertMessage('Please input location');
      return;
    } else if (provider.maxGuests == -1) {
      alertMessage('Please input max guest');
      return;
    } else if (provider.children == -1) {
      alertMessage('Please input children');
      return;
    } else if (provider.adult == -1) {
      alertMessage('Please input adult');
      return;
    } else if (provider.dailyRent.isEmpty) {
      alertMessage('Please input daily rent');
      return;
    }else if (provider.tax.isEmpty) {
      alertMessage('Please input tax (%) i.e. 10');
      return;
    } else if (provider.cleaningFees.isEmpty) {
      alertMessage('Please input cleaning fees');
      return;
    } else if (provider.serviceFees.isEmpty) {
      alertMessage('Please input service fees');
      return;
    } else if (provider.airportPickupFee.isEmpty) {
      alertMessage('Please input airport pickup fee');
      return;
    } else if (provider.extraBedsFee.isEmpty) {
      alertMessage('Please input extra beds fee');
      return;
    } else if (provider.bedrooms == -1) {
      alertMessage('Please input bedrooms if no bedroom set 0');
      return;
    } else if (provider.livingRooms == -1) {
      alertMessage('Please input living room if no living room set 0');
      return;
    } else if (provider.kitchens == -1) {
      alertMessage('Please input kitchens if no kitchen set 0');
      return;
    } else if (provider.bathrooms == -1) {
      alertMessage('Please input bathrooms if no bathroom set 0');
      return;
    } else if (provider.gyms == -1) {
      alertMessage('Please input gym if no gym set 0');
      return;
    } else if (imageUrls.isEmpty) {
      alertMessage('Please enter at least one image URL.');
      return;
    } else {
      provider.addVilla(
        context: context,
        id: generateRandomId(20),
        imageUrls: imageUrls
      );
      for (var controller in _imageControllers) {
        controller.clear(); // Clear fields after adding
      }
    }
  }

  void alertMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
