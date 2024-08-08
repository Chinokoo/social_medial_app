import 'package:flutter/material.dart';
import 'package:social_medial_app/auth/auth_service.dart';
import 'package:social_medial_app/components/wall_drawer_tile.dart';

class WallDrawer extends StatelessWidget {
  const WallDrawer({super.key});

  void signOut() async {
    //getting the instance of AuthService
    AuthService authService = AuthService();
    //logging out the user
    await authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            DrawerHeader(
                child: Icon(
              Icons.wallet_membership,
              size: 70,
              color: Theme.of(context).colorScheme.inversePrimary,
            )),
            const SizedBox(height: 20),
            WallDrawerTile(
                title: "H O M E",
                icon: Icons.home,
                onTap: () {
                  //pop the drawer and ..
                  Navigator.pop(context);
                  // ..go to home page.
                  Navigator.pushNamed(context, '/home_page');
                }),
            WallDrawerTile(
              title: "P R O F I L E",
              icon: Icons.person,
              onTap: () {
                //pop the drawer and ..
                Navigator.pop(context);
                // ..go to profile page.
                Navigator.pushNamed(context, '/profile_page');
              },
            ),
            WallDrawerTile(
              title: "U S E R S",
              icon: Icons.supervised_user_circle_sharp,
              onTap: () {
                //pop the drawer and ..
                Navigator.pop(context);
                // ..go to users page.
                Navigator.pushNamed(context, '/users_page');
              },
            ),
          ],
        ),
        Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: WallDrawerTile(
                title: "L O G O U T", icon: Icons.logout, onTap: signOut))
      ],
    ));
  }
}
