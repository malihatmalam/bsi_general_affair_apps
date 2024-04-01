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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.all(2),
                // height: 400,
                child: BlocBuilder<ProposalHistoryCubit, ProposalHistoryState>(
                  builder: (context, state) {
                    if(state is ProposalHistoryInitial){
                      return Center(
                        child: Text(
                          'Your proposal data is waiting for you!',
                        ),
                      );
                    } else if (state is ProposalHistoryLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.purpleAccent,
                        ),
                      );
                    } else if (state is ProposalHistoryLoaded) {
                      var listProposal = state.proposals;
                      return ListView(
                        children: List.generate(listProposal.length, (index) {
                          return Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0)
                            ),
                            child: ListTile(
                              onTap: () {
                                context.go('/proposal/${listProposal[index].proposalToken}');
                              },
                              title: Text('${listProposal[index].proposalToken}'),
                              subtitle: Text('${listProposal[index].proposalStatus}'),
                              // title: Text('test'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('${listProposal[index].proposalApproveLevel} / 3'),
                                  SizedBox(width: 4,),
                                  IconButton(onPressed: () {
                                    context.go('/proposal/${listProposal[index].proposalToken}');
                                  }, icon: Icon(Icons.arrow_forward)),
                                ],
                              ),
                              style: ListTileStyle.list,
                            ),
                          );
                        }),
                      );
                    } else if (state is ProposalHistoryError) {
                      return ErrorMessage(message: state.message);
                    } return const SizedBox();
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
