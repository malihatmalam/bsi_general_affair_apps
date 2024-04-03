import 'package:bsi_general_affair_apps/presentation/pages/profilePage/cubit/profile_page_cubit.dart';
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
        BlocProvider(create: (context) => ProfilePageCubit()),
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

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 18, left: 24, right: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<ProfilePageCubit, ProfilePageState>(
                      builder: (context, state) {
                        if (state is ProfilePageInitial) {
                          return Center(
                            child: Text(
                              'Your summary data is waiting for you!',
                            ),
                          );
                        } else if (state is ProfilePageLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.blueAccent,
                            ),
                          );
                        } else if (state is ProfilePageLoaded) {
                          var data = state.user;
                          return Text(
                            'Hay, ${data.userFirstName}',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        } else if (state is ProfilePageError) {
                          return ErrorMessage(message: state.message);
                        }
                        return const SizedBox();
                      },
                    ),
                    RotatedBox(
                      quarterTurns: 0,
                      child: Icon(
                        Icons.person,
                        color: Colors.blueAccent,
                        size: 28,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(height: 24),
                    Center(
                      child: Image.asset(
                        'assets/images/20944145.jpg',
                        scale: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Center(
                      child: Text(
                        'BSI General Affair',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'SUMMARY : ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    BlocBuilder<HomepageCubit, HomepageState>(
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
                              color: Colors.blueAccent,
                            ),
                          );
                        } else if (state is HomepageLoaded) {
                          var data = state.homepage;
                          return Column(
                            children: [
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: _cardMenu(
                                      icon: 'assets/images/check-mark.png',
                                      title: 'Completed',
                                      vertical: 10,
                                      description:
                                          data.completedProposal.toString(),
                                      color: Colors.green,
                                      colorBorder: Colors.green,
                                      fontColor: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: _cardMenu(
                                      icon: 'assets/images/time-left.png',
                                      title: 'Progress',
                                      vertical: 10,
                                      description:
                                          data.waitingProposal.toString(),
                                      color: Colors.yellowAccent,
                                      colorBorder: Colors.yellowAccent,
                                      fontColor: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: _cardMenu(
                                      icon: 'assets/images/delete.png',
                                      title: 'Rejected',
                                      vertical: 10,
                                      description:
                                          data.rejectProposal.toString(),
                                      color: Colors.redAccent,
                                      colorBorder: Colors.redAccent,
                                      fontColor: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 28),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: _cardMenu(
                                      icon: 'assets/images/package-box.png',
                                      title: 'Procurement',
                                      vertical: 10,
                                      description:
                                          data.procurementProposal.toString(),
                                      color: Colors.white,
                                      colorBorder: Colors.blueAccent,
                                      fontColor: Colors.blueAccent,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: _cardMenu(
                                      icon: 'assets/images/customer-support.png',
                                      title: 'Services',
                                      vertical: 10,
                                      description:
                                          data.serviceProposal.toString(),
                                      color: Colors.white,
                                      colorBorder: Colors.blueAccent,
                                      fontColor: Colors.blueAccent,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          );
                        } else if (state is HomepageError) {
                          return ErrorMessage(message: state.message);
                        }
                        return const SizedBox();
                      },
                    ),
                    const SizedBox(height: 28),
                    BlocBuilder<ProposalWaitingCubit, ProposalWaitingState>(
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
                              color: Colors.blueAccent,
                            ),
                          );
                        } else if (state is ProposalWaitingLoaded) {
                          var listProposal = state.proposals;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (listProposal.length != 0)
                                const Text(
                                  'Proposal Waiting : ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              const SizedBox(height: 10),
                              Column(
                                children: [
                                  ListView.builder(
                                      key: Key(UniqueKey().toString()),
                                      // Unique key
                                      shrinkWrap: true,
                                      itemCount: listProposal.length,
                                      itemBuilder: (context, index) {
                                        Color colorData;
                                        switch (listProposal[index]
                                            .proposalStatus
                                            .toString()
                                            .trim()) {
                                          case "Waiting":
                                            colorData = Colors.yellow.shade800;
                                            break;
                                          case "Rejected":
                                            colorData = Colors.red;
                                            break;
                                          case "Completed":
                                            colorData = Colors.green;
                                            break;
                                          default:
                                            colorData = Colors.black;
                                            break;
                                        }
                                        return Container(
                                          margin: EdgeInsets.all(0),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.blueAccent,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: ListTile(
                                            leading: Icon(Icons.file_present_rounded, color: Colors.blueAccent, grade: 2),
                                            onTap: () {
                                              context.go(
                                                  '/approval/${listProposal[index].proposalToken}');
                                            },
                                            title: Text(
                                                '${listProposal[index].proposalToken}', style: TextStyle(color: Colors.blueAccent)),
                                            subtitle: Text(
                                              '${listProposal[index].proposalStatus}',
                                              style: TextStyle(
                                                color: colorData,
                                              ),
                                            ),
                                            trailing: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  '${listProposal[index].proposalApproveLevel}'
                                                  ' / 3',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            style: ListTileStyle.list,
                                          ),
                                        );
                                      })
                                ],
                              ),
                            ],
                          );
                        } else if (state is ProposalWaitingError) {
                          return ErrorMessage(message: state.message);
                        }
                        return const SizedBox();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardMenu({
    required String title,
    required String description,
    required String icon,
    required double vertical,
    // VoidCallback? onTap,
    Color color = Colors.white,
    Color colorBorder = Colors.white,
    Color fontColor = Colors.grey,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: vertical,
      ),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: colorBorder,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 3))
          ]),
      child: Column(
        children: [
          Image.asset(icon, height: 30),
          const SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: fontColor, fontSize: 16),
          ),
          Text(
            '${description}',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: fontColor, fontSize: 14),
          )
        ],
      ),
    );
  }
}

// class SummaryWidget extends StatelessWidget {
//   // Dummy data
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           padding: EdgeInsets.all(10.0),
//           height: 250.0,
//           child:,
//         )
//       ],
//     );
//   }
// }
