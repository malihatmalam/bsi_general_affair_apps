import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/usecases/users_usecases.dart';
import '../../core/widget/errorMessage.dart';
import 'cubit/proposal_history_cubit.dart';

class ProposalHistoryPageWrapperProvider extends StatelessWidget {
  String? typeProposal;
  ProposalHistoryPageWrapperProvider({required this.typeProposal, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProposalHistoryCubit(typeProposal: typeProposal),
      child: ProposalHistoryPage(),
    );
  }
}

class ProposalHistoryPage extends StatelessWidget {
  ProposalHistoryPage();

  @override
  Widget build(BuildContext context) {
    UsersUseCases().checkSession(context: context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.all(2),
                // height: 400,
                child:
                BlocBuilder<ProposalHistoryCubit, ProposalHistoryState>(
                  builder: (context, state) {
                    if (state is ProposalHistoryInitial) {
                      return Center(
                        child: Text(
                          'Your proposal data is waiting for you!',
                        ),
                      );
                    } else if (state is ProposalHistoryLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.blueAccent,
                        ),
                      );
                    } else if (state is ProposalHistoryLoaded) {
                      var listProposal = state.proposals;
                      if(listProposal.length < 1){
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/folder-1.png', // Ganti dengan path gambar Anda
                                width: 300,
                                height: 300,
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Oops, your data is empty',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          // if (listProposal.length != 0)
                          //   const Text(
                          //     'Proposal Waiting : ',
                          //     style: TextStyle(
                          //       fontSize: 16,
                          //       fontWeight: FontWeight.bold,
                          //     ),
                          //   ),
                          // const SizedBox(height: 10),
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
                                      margin: EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.blueAccent,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                      ),
                                      child: ListTile(
                                        leading: Icon(
                                            listProposal[index].proposalType.trim() == "Service" ? Icons.file_present : Icons.file_present_rounded,
                                            color: Colors.blueAccent,
                                            grade: 2),
                                        onTap: () {
                                          context.go(
                                              '/proposal/${listProposal[index].proposalToken}');
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
                    } else if (state is ProposalHistoryError) {
                      return ErrorMessage(message: state.message);
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
