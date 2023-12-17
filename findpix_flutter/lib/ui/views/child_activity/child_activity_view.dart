import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'child_activity_viewmodel.dart';

class ChildActivityView extends StackedView<ChildActivityViewModel> {
  const ChildActivityView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ChildActivityViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CHILD ACTIVITY'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (viewModel.selectedDate == null)
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  height: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 60,
                        width: double.infinity,
                        color: Colors.blue,
                        child: const Text(
                          'Select a date',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => viewModel.selectDate(context),
                        child: const Text('Select Date'),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              // Handle cancel button
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                          ),
                          const SizedBox(width: 10),
                          TextButton(
                            onPressed: () {
                              // Handle OK button
                              print('Selected Date: ${viewModel.selectedDate}');
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            else
              Container(
                child: Text('location'),
              )
          ],
        ),
      ),
    );
  }

  @override
  ChildActivityViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ChildActivityViewModel();
}
