import 'package:findpix_flutter/ui/smart_widgets/custom_bottom_navbar/bottom_navbar_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'notification_viewmodel.dart';

class NotificationView extends StackedView<NotificationViewModel> {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    NotificationViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Notification'),
        ),
        bottomNavigationBar: const CustomBottomNavBar(index: 1),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: ListView(
          children: const [
            ListItemChat(
                text: 'ACtivity Anomoly', subtitle: 'Abnormal waking speed'),
            ListItemChat(
                text: 'Boundary beach',
                subtitle: 'breached boundary at 21 August'),
            ListItemChat(
                text: 'Boundary beach',
                subtitle: 'breached boundary at 23 August'),
            ListItemChat(
                text: 'ACtivity Anomoly', subtitle: 'Abnormal waking speed'),
          ],
        ));
  }

  @override
  NotificationViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      NotificationViewModel();
}

class ListItemChat extends StatelessWidget {
  final String text;
  final String subtitle;

  const ListItemChat({super.key, required this.text, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: const Icon(Icons.message), // Icon on the left side
        title: Text(text), // Adjust the chat text
        subtitle: Text(subtitle), // Adjust the last message text
        onTap: () {
          // Handle tapping on the chat item
        },
      ),
    );
  }
}
