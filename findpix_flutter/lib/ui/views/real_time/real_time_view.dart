import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'real_time_viewmodel.dart';

class RealTimeView extends StackedView<RealTimeViewModel> {
  const RealTimeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    RealTimeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const TextField(
          decoration: InputDecoration(
              hintText: 'search', prefixIcon: Icon(Icons.search)),
        ),
      ),
      body:  SafeArea(child: Center(child: Column(
        children: [
          // const Text('Location'),
          if (viewModel.node != null)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 500,
                child: GoogleMap(
                  onMapCreated: (controller) {},
                  onTap: (LatLng location) {},
                  initialCameraPosition: CameraPosition(
                    target:
                    LatLng(viewModel.node!.lat, viewModel.node!.long),
                    // Default map position
                    zoom: 15.0,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId("picked_location"),
                      position:
                      LatLng(viewModel.node!.lat, viewModel.node!.long),
                      infoWindow: const InfoWindow(
                        title: "Current location",
                      ),
                    ),
                  },
                ),
              ),
            ),
        ],
      ))),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Recent',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            // Add onTap functionality for "Add" here
            _showAddBottomSheet(context);
          } else if (index == 1) {
            // Add onTap functionality for "Recent" here
            // For now, just print a message
            print('Recent tapped');
          }
        },
        // Add additional properties as needed
      ),
    );
  }

  @override
  RealTimeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      RealTimeViewModel();
}

void _showAddBottomSheet(BuildContext context) {
  TextEditingController boundaryNameController = TextEditingController();
  TextEditingController selectedDateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedStartTime = TimeOfDay.now();
  TimeOfDay? selectedEndTime = TimeOfDay.now();

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Add Item',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // 1. Boundary Name Text Field
            TextFormField(
              controller: boundaryNameController,
              decoration: InputDecoration(
                labelText: 'Boundary Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
// 2. Date Picker TextField
            InkWell(
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );

                if (picked != null) {
                  setState(() {
                    selectedDate = picked;
                    selectedDateController.text =
                        "${picked.year}-${picked.month}-${picked.day}";
                  });
                }
              },
              child: AbsorbPointer(
                child: TextFormField(
                  controller: selectedDateController,
                  decoration: InputDecoration(
                    labelText: 'Select Date',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),
            // 3. Start Time Picker TextField
            InkWell(
              onTap: () async {
                TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: selectedStartTime ?? TimeOfDay.now(),
                );

                if (picked != null) {
                  setState(() {
                    selectedStartTime = picked;
                    startTimeController.text =
                        "${picked.hour}:${picked.minute}";
                  });
                }
              },
              child: AbsorbPointer(
                child: TextFormField(
                  controller: startTimeController,
                  decoration: InputDecoration(
                    labelText: 'Select Start Time',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // 4. End Time Picker TextField
            InkWell(
              onTap: () async {
                TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: selectedEndTime ?? TimeOfDay.now(),
                );

                if (picked != null) {
                  setState(() {
                    selectedEndTime = picked;
                    endTimeController.text = "${picked.hour}:${picked.minute}";
                  });
                }
              },
              child: AbsorbPointer(
                child: TextFormField(
                  controller: endTimeController,
                  decoration: InputDecoration(
                    labelText: 'Select End Time',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // 5. Search by Location Text Field
            TextFormField(
              controller: locationController,
              decoration: InputDecoration(
                labelText: '// geo- fencing is here ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // 6. Submit Button
            ElevatedButton(
              onPressed: () {
                // Perform action when "Submit" button is pressed in the bottom sheet
                print('Boundary Name: ${boundaryNameController.text}');
                print('Selected Date: $selectedDate');
                print('Selected Start Time: $selectedStartTime');
                print('Selected End Time: $selectedEndTime');
                print('Location: ${locationController.text}');

                Navigator.pop(context); // Close the bottom sheet
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      );
    },
  );
}

void setState(Null Function() param0) {}
