
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../pages/approvalPage/approval_page.dart';
import '../../pages/assetDetailPage/asset_detail_page.dart';
import '../../pages/assetListPage/asset_list_page.dart';
import '../../pages/homescreen.dart';
import '../../pages/loginPage/login_page.dart';
import '../../pages/proposalCreatePage/proposal_create_page.dart';
import '../../pages/proposalDetailPage/proposal_detail_page.dart';
import '../../pages/proposalEditPage/proposal_edit_page.dart';
import '../../pages/proposalHistoryPage/proposal_history_page.dart';

class RouterNavigation{

  RouterConfig<Object> getRoute(){
    return GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            name: 'index',
            builder: (context, state) => HomeScreenWrapperProvider(),
          ),
          GoRoute(
            path: '/login',
            name: 'login',
            builder: (context, state) => LoginPage(),
          ),
          GoRoute(
            path: '/asset',
            name: 'assetList',
            builder: (context, state) => AssetListPageWrapperProvider(),
          ),
          GoRoute(
            path: '/asset/:number_asset',
            name: 'assetDetail',
            builder: (context, state){
              var _assetNumber = state.pathParameters['number_asset'];
              return AssetDetailPageWrapperProvider(assetNumber: _assetNumber);
            },
          ),
          GoRoute(
            path: '/approval/:proposal_token',
            name: 'approval',
            builder: (context, state){
              var _proposalToken = state.pathParameters['proposal_token'];
              return ApprovalPageWrapperProvider(proposalToken: _proposalToken);
            },
          ),
          // GoRoute(
          //   path: '/proposal/history',
          //   name: 'proposalHistory',
          //   builder: (context, state)=> ProposalHistoryPageWrapperProvider(),
          // ),
          // GoRoute(
          //   path: '/proposal/create',
          //   name: 'proposalCreate',
          //   builder: (context, state)=> ProposalCreatePage(),
          // ),
          GoRoute(
            path: '/proposal/:proposal_token',
            name: 'proposalDetail',
            builder: (context, state){
              var _proposalToken = state.pathParameters['proposal_token'];
              return ProposalDetailPageWrapperProvider(proposalToken: _proposalToken,);
            },
          ),
          GoRoute(
            path: '/proposal/edit/:proposal_token',
            name: 'proposalEdit',
            builder: (context, state){
              var _proposalToken = state.pathParameters['proposal_token'];
              return ProposalUpdatePage(proposalToken: _proposalToken);
            },
          ),
        ]
    );
  }
}

