import 'package:flutter/material.dart';

import 'components/body.dart';

class UpdateProfileScreen extends StatelessWidget {
  static const routeName = '/update_profile';
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
      ),
      body: Body(),
    );
  }
}
