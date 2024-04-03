import 'package:bsi_general_affair_apps/presentation/pages/proposalHistoryPage/proposal_history_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProposalHistoryScreenWrapperProvider extends StatelessWidget {
  const ProposalHistoryScreenWrapperProvider({super.key});

  // return MultiBlocProvider(
  // providers: [
  // BlocProvider( create: (context) => BottomBarBloc()),
  // ],
  // child: ProposalHistoryScreen(),
  // );

  @override
  Widget build(BuildContext context) {
    return  ProposalHistoryScreen();
  }
}

class ProposalHistoryScreen extends StatelessWidget {
  ProposalHistoryScreen();

  final List<Tab> _tabs = [
    Tab(text: 'Procurement'),
    Tab(text: 'Services'),
  ];

  final List<Widget> _tabContents = [
    ProposalHistoryPageWrapperProvider(typeProposal: 'Procurement'),
    ProposalHistoryPageWrapperProvider(typeProposal: 'Services',),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: _tabs.length,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Row(
              children: [
                Icon(Icons.history_sharp,color: Colors.blueAccent),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    'My History Proposal',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            bottom: TabBar(
              tabs: _tabs,
              indicatorColor: Colors.blue, // Optional customization
            ),
          ),
          body: TabBarView(
            children: _tabContents,
          ),
        ),
      )
    );
  }
}
