// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// import '../../../../../1.CONFIG/Core/constants/app_constants.dart';
// import '../zviews.dart';
// import 'components/navigator_item.dart';

// class NavigatorBarView extends StatefulWidget {
//   final int initialIndex;
//   final double? latitude;
//   final double? longitude;

//   const NavigatorBarView({
//     super.key,
//     this.initialIndex = 0,
//     this.latitude,
//     this.longitude,
//   });

//   @override
//   NavigatorBarViewState createState() => NavigatorBarViewState();
// }

// class NavigatorBarViewState extends State<NavigatorBarView> {
//   late int currentIndex;

//   @override
//   void initState() {
//     super.initState();
//     currentIndex = widget.initialIndex;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final navigatorItems = [
//       NavigatorItem("Explore", "assets/icons/navigator_icons/explore_icon.svg", 0, const ExplorerView()),
//       NavigatorItem("Museum", "assets/icons/navigator_icons/museum.svg", 1, const MuseumView()),
//       NavigatorItem(
//         "Maps",
//         "assets/icons/navigator_icons/mapa.svg",
//         2,
//         MapsView(
//           latitude: widget.latitude,
//           longitude: widget.longitude,
//         ),
//       ),
//       NavigatorItem("Favourite", "assets/icons/navigator_icons/favourite_icon.svg", 3, const FavouriteView()),
//       NavigatorItem("Account", "assets/icons/navigator_icons/account_icon.svg", 4, const AccountView()),
//     ];

//     return Scaffold(
//       body: navigatorItems[currentIndex].screen,
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           borderRadius: const BorderRadius.only(
//             topRight: Radius.circular(15),
//             topLeft: Radius.circular(15),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black38.withOpacity(0.1),
//               spreadRadius: 0,
//               blurRadius: 37,
//               offset: const Offset(0, -12),
//             ),
//           ],
//         ),
//         child: ClipRRect(
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(15),
//             topRight: Radius.circular(15),
//           ),
//           child: BottomNavigationBar(
//             backgroundColor: Colors.white,
//             currentIndex: currentIndex,
//             onTap: (index) {
//               setState(() {
//                 currentIndex = index;
//               });
//             },
//             type: BottomNavigationBarType.fixed,
//             selectedItemColor: AppConstants.primaryColor,
//             selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
//             unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
//             unselectedItemColor: Colors.black,
//             items: navigatorItems.map((e) {
//               return getNavigationBarItem(label: e.label, index: e.index, iconPath: e.iconPath);
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }

//   BottomNavigationBarItem getNavigationBarItem({required String label, required String iconPath, required int index}) {
//     final Color iconColor = index == currentIndex ? AppConstants.primaryColor : Colors.black;
//     return BottomNavigationBarItem(
//       label: label,
//       icon: SvgPicture.asset(
//         iconPath,
//         // ignore: deprecated_member_use
//         color: iconColor,
//       ),
//     );
//   }
// }
