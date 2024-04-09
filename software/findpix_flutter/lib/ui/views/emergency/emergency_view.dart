import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'emergency_viewmodel.dart';

class EmergencyView extends StackedView<EmergencyViewModel> {
  const EmergencyView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    EmergencyViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EMERGENCY CONTACTS'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Container(
            height: 700,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.call,
                      size: 25, // Set the size to 25
                      color: Colors.white, // Set the color to white
                    ),
                    Text(
                      'Emergency contacts',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  @override
  EmergencyViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      EmergencyViewModel();
}
