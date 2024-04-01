import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import '../../../domain/usecases/users_usecases.dart';
import '../../core/widget/errorMessage.dart';
import 'cubit/homepage_cubit.dart';
import 'cubit/proposal_waiting_cubit.dart';

class HomePageWrapperProvider extends StatelessWidget {
  HomePageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomepageCubit()),
        BlocProvider(create: (context) => ProposalWaitingCubit()),
      ],
      child: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage();

  bool checkTime(DateTime future) {
    // Mendapatkan waktu saat ini
    DateTime now = DateTime.now();
    // DateTime nowMani = now.add(Duration(minutes: 57));

    // Membandingkan waktu saat ini dengan waktu di masa depan
    return now.isAfter(future);
    // return nowMani.isAfter(future);
  }

  @override
  Widget build(BuildContext context) {
    UsersUseCases().checkSession(context: context); // Call session check
    return Scaffold(
      appBar: AppBar(
        title: Text('Homepage'),
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SummaryWidget(), // Summary widget
            Expanded(
              // Wrap content with Expanded
              child: BlocBuilder<ProposalWaitingCubit, ProposalWaitingState>(
                builder: (context, state) {
                  if (state is ProposalWaitingInitial) {
                    return Center(
                      child: Text(
                        'Your proposal data is waiting for you!',
                      ),
                    );
                  } else if (state is ProposalWaitingLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.purpleAccent,
                      ),
                    );
                  } else if (state is ProposalWaitingLoaded) {
                    var listProposal = state.proposals;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                          child: Text("List Approval Proposal",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                              textAlign: TextAlign.left),
                        ),
                        ListView.builder(
                          key: Key(UniqueKey().toString()), // Unique key
                          shrinkWrap: true,
                          itemCount: listProposal.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: ListTile(
                                onTap: () {
                                  context.go(
                                      '/approval/${listProposal[index].proposalToken}');
                                },
                                title: Text(
                                    '${listProposal[index].proposalToken}'),
                                subtitle: Text(
                                    '${listProposal[index].proposalStatus}'),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                        '${listProposal[index].proposalApproveLevel} / 3'),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        context.go(
                                            '/approval/${listProposal[index].proposalToken}}');
                                      },
                                      icon: Icon(Icons.arrow_forward),
                                    ),
                                  ],
                                ),
                                style: ListTileStyle.list,
                              ),
                            );
                          },
                        )
                      ],
                    );
                  } else if (state is ProposalWaitingError) {
                    return ErrorMessage(message: state.message);
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SummaryWidget extends StatelessWidget {
  // Dummy data

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10.0),
          height: 250.0,
          child: BlocBuilder<HomepageCubit, HomepageState>(
            builder: (context, state) {
              if (state is HomepageInitial) {
                return Center(
                  child: Text(
                    'Your summary data is waiting for you!',
                  ),
                );
              } else if (state is HomepageLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.purpleAccent,
                  ),
                );
              } else if (state is HomepageLoaded) {
                var data = state.homepage;
                return Center(
                  child: Container(
                    height: 300.0,
                    child: GridView.count(
                        crossAxisCount: 3,
                        // Number of items in each row
                        crossAxisSpacing: 10.0,
                        // Spacing between items in the row
                        mainAxisSpacing: 10.0,
                        // Spacing between rows
                        childAspectRatio: 3 / 2,
                        // Aspect ratio of each tile (width / height)
                        children: [
                          GridTile(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                              padding: EdgeInsets.all(10.0),
                              child: Center(
                                child: Column(
                                  children: [
                                    Text("Completed",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold)),
                                    Text("${data.completedProposal}",
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GridTile(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                              padding: EdgeInsets.all(10.0),
                              child: Center(
                                child: Column(
                                  children: [
                                    Text("Waiting",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold)),
                                    Text("${data.waitingProposal}",
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GridTile(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                              padding: EdgeInsets.all(10.0),
                              child: Center(
                                child: Column(
                                  children: [
                                    Text("Rejected",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold)),
                                    Text("${data.rejectProposal}",
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GridTile(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                              padding: EdgeInsets.all(10.0),
                              child: Center(
                                child: Column(
                                  children: [
                                    Text("Procurement",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold)),
                                    Text("${data.procurementProposal}",
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GridTile(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                              padding: EdgeInsets.all(10.0),
                              child: Center(
                                child: Column(
                                  children: [
                                    Text("Services",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold)),
                                    Text("${data.serviceProposal}",
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ]
                    ),
                  ),
                );
              } else if (state is HomepageError) {
                return ErrorMessage(message: state.message);
              }
              return const SizedBox();
            },
          ),
        )
      ],
    );
  }
}
