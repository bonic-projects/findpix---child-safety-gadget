import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../models/boundary.dart';
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

            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return BoundaryInputBottomSheet(
                  onSubmit: (Boundary boundary) {
                    // Handle the submitted boundary object here
                    viewModel.updateBoundary(boundary);
                    // You can do anything with the boundary object, such as sending it to Firestore
                  },
                );
              },
            );


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



class BoundaryInputBottomSheet extends StatefulWidget {
  final Function(Boundary boundary) onSubmit;

  const BoundaryInputBottomSheet({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _BoundaryInputBottomSheetState createState() => _BoundaryInputBottomSheetState();
}

class _BoundaryInputBottomSheetState extends State<BoundaryInputBottomSheet> {
  late TextEditingController _nameController;
  late TextEditingController _kilometerController;
  late DateTime _startDate;
  late DateTime _endDate;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _kilometerController = TextEditingController();
    _startDate = DateTime.now();
    _endDate = DateTime.now().add(Duration(days: 7));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _kilometerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          SizedBox(height: 16),
          TextField(
            controller: _kilometerController,
            decoration: InputDecoration(labelText: 'Kilometer'),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 16),
          ListTile(
            title: Text('Start Date & Time'),
            subtitle: Text('${_startDate.toString()}'),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: _startDate,
                firstDate: DateTime.now(),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null) {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedTime != null) {
                  setState(() {
                    _startDate = DateTime(pickedDate.year, pickedDate.month, pickedDate.day, pickedTime.hour, pickedTime.minute);
                  });
                }
              }
            },
          ),
          ListTile(
            title: Text('End Date & Time'),
            subtitle: Text('${_endDate.toString()}'),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: _endDate,
                firstDate: DateTime.now(),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null) {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedTime != null) {
                  setState(() {
                    _endDate = DateTime(pickedDate.year, pickedDate.month, pickedDate.day, pickedTime.hour, pickedTime.minute);
                  });
                }
              }
            },
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              String name = _nameController.text.trim();
              double kilometer = double.tryParse(_kilometerController.text) ?? 0.0;
              if (name.isNotEmpty && kilometer > 0) {
                widget.onSubmit(Boundary(
                  id: '',
                  name: name,
                  startDateTime: _startDate,
                  endDateTime: _endDate,
                  kilometer: kilometer,
                  currentLat: 0.0,
                  currentLong: 0.0,
                ));
                Navigator.of(context).pop();
              } else {
                // Show error message or handle invalid input
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
