import 'package:flutter/material.dart';
import '../../../core/themes/themes.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utils/utils.dart';
import '../../home/homes.dart';
import '../../notes/notes.dart';
import '../../profile/pages/pages.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int currentPageIndex = 0;

  final Widget _home = HomePage();
  final Widget _notes = NotePage();
  final Widget _profile = ProfilePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appWhite,
        automaticallyImplyLeading: false,
        title: ListTile(
          title: Text(
            "Bonjour",
            style: TextStyle(color: appColor, fontWeight: FontWeight.bold),
          ),
          subtitle: Text("Amusez-vous !!!"),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(2.w),
            child: CircleAvatar(
              child:
                  SharedPreferencesHelper().getString('photo')! == ""
                      ? FlutterLogo()
                      : Image.network(
                        SharedPreferencesHelper().getString('photo')!,
                      ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: appWhite,
        surfaceTintColor: appWhite,
        indicatorColor: appColor,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            icon: Icon(
              Icons.home_outlined,
              color: currentPageIndex == 0 ? appWhite : appColor,
            ),
            label: "Accueil",
          ),
          NavigationDestination(
            icon: Icon(
              Icons.history_toggle_off_outlined,
              color: currentPageIndex == 1 ? appWhite : appColor,
            ),
            label: "Historique",
          ),
          NavigationDestination(
            icon: Icon(
              Icons.person_outline_outlined,
              color: currentPageIndex == 2 ? appWhite : appColor,
            ),
            label: "Profil",
          ),
        ],
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    if (currentPageIndex == 0) {
      return _home;
    } else if (currentPageIndex == 1) {
      return _notes;
    } else {
      return _profile;
    }
  }
}
