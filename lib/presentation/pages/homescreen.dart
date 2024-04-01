import 'package:bsi_general_affair_apps/domain/usecases/users_usecases.dart';
import 'package:bsi_general_affair_apps/presentation/core/widget/bottomBarNavigation/bloc/bottom_bar_bloc.dart';
import 'package:bsi_general_affair_apps/presentation/core/widget/checkSession.dart';
import 'package:bsi_general_affair_apps/presentation/pages/profilePage/profile_page.dart';
import 'package:bsi_general_affair_apps/presentation/pages/proposalCreatePage/proposal_create_page.dart';
import 'package:bsi_general_affair_apps/presentation/pages/proposalHistoryPage/proposal_history_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';

import '../core/widget/bottomBarNavigation/custom_bottom_navigation_bar.dart';
import 'assetListPage/asset_list_page.dart';
import 'homePage/homepage.dart';

class HomeScreenWrapperProvider extends StatelessWidget {
  HomeScreenWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider( create: (context) => BottomBarBloc()),
        ],
        child: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  HomeScreen();

  static List<Widget> bottomNavScreen = <Widget>[
    HomePageWrapperProvider(),
    AssetListPageWrapperProvider(),
    ProposalCreatePage(),
    ProposalHistoryScreenWrapperProvider(),
    ProfilePageWrapperProvider(),
  ];

  @override
  Widget build(BuildContext context) {
    UsersUseCases().checkSession(context: context);

    return BlocConsumer<BottomBarBloc, BottomBarState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Center(
              child: bottomNavScreen.elementAt(state.tabIndex)),
          bottomNavigationBar: CustomBottomNavigationBar(
            currentIndex: state.tabIndex,
            onTap: (index) => BlocProvider.of<BottomBarBloc>(context)
                .add(TabChange(tabIndex: index)),
          ),
        );
      },
    );
  }
}