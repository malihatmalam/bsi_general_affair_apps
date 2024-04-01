
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bottom_bar_bloc.dart';

class CustomBottomNavigationBar extends StatelessWidget{
  final int currentIndex;
  final Function(int) onTap;
  final List<BottomNavigationBarItem> bottomNavItems = const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.smartphone),
      label: 'Asset',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.add_box_rounded),
      label: 'Procurement',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.history_sharp),
      label: 'History',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: bottomNavItems,
      currentIndex: currentIndex,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        onTap(index);
        BlocProvider.of<BottomBarBloc>(context).add(TabChange(tabIndex: index));
      },
    );
  }
}