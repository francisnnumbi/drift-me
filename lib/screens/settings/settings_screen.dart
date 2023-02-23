
import 'package:flutter/material.dart';

import '../../services/data_services.dart';


class SettingsScreen extends StatelessWidget {
   SettingsScreen({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   WillPopScope(
      onWillPop: () async {
        DataServices.to.todo.value = null;
        DataServices.to.category.value = null;
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Settings'),
        ),
        body: ListView(
          children: const [
            ListTile(
              leading: Icon(Icons.person_outline),
              title: Text('Profile'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: null,
            ),
            ListTile(
              leading: Icon(Icons.color_lens_outlined),
              title: Text('Themes'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: null,
            ),
            ListTile(
              leading: Icon(Icons.language_outlined),
              title: Text('Languages'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: null,
            ),
            ListTile(
              leading: Icon(Icons.notifications_outlined),
              title: Text('Notifications and Sounds'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: null,
            ),
            ListTile(
              leading: Icon(Icons.help_outline_outlined),
              title: Text('Help & Support'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: null,
            ),

            ListTile(
              leading: Icon(Icons.privacy_tip_outlined),
              title: Text('Privacy Policy'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: null,
            ),

            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('About'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: null,
            ),

           Divider(),

            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),

              onTap: null,
            ),
          ],
        )
      ),
    );
  }
}
