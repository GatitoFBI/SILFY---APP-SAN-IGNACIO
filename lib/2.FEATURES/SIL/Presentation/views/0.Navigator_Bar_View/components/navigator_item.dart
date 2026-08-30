import 'package:flutter/material.dart';

class NavigatorItem {
  final String label;
  final String iconPath;
  final int index;
  final Widget screen;

  NavigatorItem(this.label, this.iconPath, this.index, this.screen);
}

// List<NavigatorItem> navigatorItems = [
//   NavigatorItem("Explore", "assets/icons/navigator_icons/explore_icon.svg", 0, const ExplorerView()),
//   NavigatorItem("Museum", "assets/icons/navigator_icons/museum.svg", 1, const MuseumView()),
//   NavigatorItem("Maps", "assets/icons/navigator_icons/mapa.svg", 2, const MapsView()),
//   NavigatorItem("Favourite", "assets/icons/navigator_icons/favourite_icon.svg", 3, const FavouriteView()),
//   NavigatorItem("Account", "assets/icons/navigator_icons/account_icon.svg", 4, const AccountView()),
// ];
