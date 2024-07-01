import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavigationIconButton(context, Icons.home, '/home'),
          _buildNavigationIconButton(context, Icons.info, '/aboutUs'),
          _buildNavigationIconButton(context, Icons.local_hospital, '/requestBlood'),
          _buildNavigationIconButton(context, Icons.person_add, '/donorRegistration'),
          _buildNavigationIconButton(context, Icons.login, '/login'),
        ],
      ),
    );
  }

  Widget _buildNavigationIconButton(BuildContext context, IconData icon, String route) {
    return IconButton(
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      icon: Icon(icon),
      iconSize: 30.0,
      color: Colors.blue,
    );
  }
}
