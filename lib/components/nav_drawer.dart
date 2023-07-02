import 'package:Woodie/pages/sign_in/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatefulWidget {
  NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  var user = FirebaseAuth.instance.currentUser;


  @override
  Widget build(BuildContext context) {
    var profpic = user?.photoURL ?? 'https://loremflickr.com/g/150/150/profile';
    final drawerHeader = UserAccountsDrawerHeader(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(color: Colors.lightBlue),
      accountName: Text(
        'John Doe',
        style: TextStyle(fontSize: 18),
      ),
      accountEmail: Text('john.doe@email.com'),
      currentAccountPicture: Image.network(profpic),
      currentAccountPictureSize: Size.square(150),
    );
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.blue[200]
            : Colors.black87,
      ),
      child: ListView(
        children: [
          SizedBox(height: 250, child: drawerHeader),
          ListTile(
            title: const Text(
              'Settings',
              style: TextStyle(fontSize: 16),
            ),
            leading: const Icon(
              Icons.settings_outlined,
              size: 30,
            ),
            onTap: () {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      title: Text('Settings'),
                      children: [
                        ListTile(leading: Icon(Icons.dark_mode_outlined), title: Text('Dark Mode'), trailing: Switch(value: true, onChanged: (bool value){setState(() {

                        });},)),
                        ListTile(leading: Icon(Icons.person), title: Text('Update Profile'),)
                      ],
                    );
                  });
            },
          ),
          ListTile(
            title: const Text(
              'About',
              style: TextStyle(fontSize: 16),
            ),
            leading: const Icon(
              Icons.info_outline,
              size: 30,
            ),
            onTap: () {
              Navigator.pop(context);
              showAboutDialog(
                  context: context,
                  applicationIcon:
                      Expanded(child: Image.asset('assets/logo.png')),
                  applicationVersion: '1.0.0',
                  applicationName: 'Woodie',
                  applicationLegalese: 'A Netflix clone, of sorts');
            },
          ),
          user == null
              ? ListTile(
                  title: const Text(
                    'Sign in / Sign up',
                    style: TextStyle(fontSize: 16),
                  ),
                  leading: const Icon(
                    Icons.login,
                    size: 30,
                  ),
                  onTap: () {
                    Navigator.popAndPushNamed(context, SignInScreen.routeName);
                  },
                )
              : ListTile(
                  title: const Text(
                    'Sign out',
                    style: TextStyle(fontSize: 16),
                  ),
                  leading: const Icon(
                    Icons.logout,
                    size: 30,
                  ),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                ),
        ],
      ),
    );
  }
}
