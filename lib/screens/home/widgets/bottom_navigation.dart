// import 'package:flutter/material.dart';
// import 'package:money_manager/screens/home/screen_home.dart';

// class MoneyManagerBottomNavigation extends StatelessWidget {
//   const MoneyManagerBottomNavigation({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(
//       valueListenable: HomeScreen.selectedIndexNotifier,
//       builder: (BuildContext ctx, int updatedIndex, Widget? _) {
//         return BottomNavigationBar(
//           currentIndex: updatedIndex,
//           onTap: (newIndex) {
//             HomeScreen.selectedIndexNotifier.value = newIndex; 
//           },
//           items: const <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: 'Transactions',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.category),
//               label: 'Categories',
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
