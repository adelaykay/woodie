import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  var user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var profpic = user?.photoURL ?? 'https://loremflickr.com/g/100/100/profile';
    final drawerHeader = UserAccountsDrawerHeader(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(color: Colors.lightBlue),
      accountName: Text('John Doe'),
      accountEmail: Text('john.doe@email.com'),
      currentAccountPicture: CircleAvatar(
        radius: 120,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(profpic),
      ),
      currentAccountPictureSize: Size.square(150),
    );
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      decoration: const BoxDecoration(
        color: Colors.black54,
      ),
      child: ListView(
        children: [
          SizedBox(height: 250, child: drawerHeader),
          ListTile(
            title: const Text(
              'Settings',
            ),
            leading: const Icon(Icons.settings_outlined),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text(
              'About',
            ),
            leading: const Icon(Icons.info_outline),
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
          ListTile(
            title: const Text(
              'Sign out',
            ),
            leading: const Icon(Icons.logout),
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
