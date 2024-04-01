import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../domain/usecases/proposals_usecases.dart';
import '../../../domain/usecases/users_usecases.dart';
import '../../core/widget/errorMessage.dart';
import '../approvalPage/cubit/approval_cubit.dart';
import 'cubit/proposal_detail_cubit.dart';

class ProposalDetailPageWrapperProvider extends StatelessWidget {
  final String? proposalToken;

  ProposalDetailPageWrapperProvider({required this.proposalToken, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ProposalDetailCubit(proposalToken: proposalToken),
        ),
        BlocProvider(
          create: (context) => ApprovalCubit(proposalToken: proposalToken),
        ),
      ],
      child: ProposalDetailPage(proposalToken: proposalToken),
    );
  }
}

class ProposalDetailPage extends StatelessWidget {
  final String? proposalToken;

  ProposalDetailPage({required this.proposalToken});

  String formatRupiah(double number) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID', // Indonesian locale
      symbol: 'Rp', // Rupiah symbol
      decimalDigits: 0, // No decimal places
    );
    return formatter.format(number);
  }

  @override
  Widget build(BuildContext context) {
    UsersUseCases().checkSession(context: context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Proposal'),
        leading: Container(
          margin: EdgeInsets.all(4),
          child: IconButton(
            onPressed: () {
              context.go('/');
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<ProposalDetailCubit, ProposalDetailState>(
              builder: (BuildContext context, ProposalDetailState state) {
                if (state is ProposalDetailInitial) {
                  return Center(
                    child: Text(
                      'Your proposal data is waiting for you!',
                    ),
                  );
                } else if (state is ProposalDetailLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.purpleAccent,
                    ),
                  );
                } else if (state is ProposalDetailLoaded) {
                  return Column(
                    children: <Widget>[
                      SizedBox(height: 16.0),
                      _buildDetailItem(
                          'Proposal Token', state.proposal.proposalToken),
                      _buildDetailItem(
                          'Vendor Name', state.proposal.vendor!.vendorName),
                      _buildDetailItem('Vendor Address',
                          state.proposal.vendor!.vendorAddress),
                      _buildDetailItem(
                          'Objective', state.proposal.proposalObjective),
                      _buildDetailItem(
                          'Description', state.proposal.proposalDescription),
                      _buildDetailItem('Required Date',
                          state.proposal.proposalRequireDate.toString()),
                      _buildDetailItem(
                          'Budget',
                          formatRupiah(
                              state.proposal.proposalBudget.toDouble())),
                      _buildDetailItem('Note', state.proposal.proposalNote),
                      _buildDetailItem('Type', state.proposal.proposalType),
                      _buildDetailItem('Status', state.proposal.proposalStatus),
                      _buildDetailItem('Negotiation Note',
                          state.proposal.proposalNegotiationNote),
                      _buildDetailItem('Department',
                          state.proposal.departement!.departementName),
                      SizedBox(height: 24.0),
                    ],
                  );
                } else if (state is ProposalDetailError) {
                  return ErrorMessage(message: state.message);
                }
                return const SizedBox();
              },
            ),
            SizedBox(height: 5),
            BlocBuilder<ApprovalCubit, ApprovalState>(
              builder: (BuildContext context, ApprovalState state) {
                if (state is ApprovalInitial) {
                  return Center(
                    child: Text(
                      'Your approval data is waiting for you!',
                    ),
                  );
                } else if (state is ApprovalLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.purpleAccent,
                    ),
                  );
                } else if (state is ApprovalLoaded) {
                  var listApprovals = state.approvals;
                  List<TimelineItem> timelineItems = [];
                  for (var approval in listApprovals) {
                    timelineItems.add(
                      TimelineItem(
                        title: approval.approverName,
                        description: approval.approvalReason,
                        date: DateTime.parse(approval.approvalAt.toString()),
                        status: approval.approvalStatus.trim(),
                        position: approval.approverPosition,
                        icon: approval.approvalStatus.trim() == "Approve"
                            ? Icons.check_circle_outline
                            : Icons.cancel_outlined,
                      ),
                    );
                  }
                  return Column(
                    children: <Widget>[
                      SizedBox(height: 5.0),
                      Text("Approval Process"),
                      SizedBox(height: 5.0),
                      _buildTimeline(timelineItems),
                      SizedBox(height: 24.0),
                    ],
                  );
                } else if (state is ApprovalError) {
                  return ErrorMessage(message: state.message);
                }
                return const SizedBox();
              },
            ),
            SizedBox(height: 5),
            BlocBuilder<ProposalDetailCubit, ProposalDetailState>(
              builder: (BuildContext context, ProposalDetailState state) {
                if (state is ProposalDetailLoaded) {
                  return Column(
                    children: <Widget>[
                      SizedBox(height: 16.0),
                      if (state.proposal.proposalStatus.toString().trim() ==
                          "Rejected")
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                                child: ElevatedButton(
                                    onPressed: () async {
                                      await ProposalsUseCases().deleteProposalCancelData(state.proposal.proposalToken.trim());
                                      context.go("/");
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.redAccent),
                                    ),
                                    child: Text(
                                      "Batalkan Proposal",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: ElevatedButton(
                                    onPressed: () {
                                      context.go("/proposal/edit/${proposalToken}");
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStatePropertyAll(Colors.yellow),
                                    ),
                                    child: Text(
                                      "Perbaikan Proposal",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ))
                            )
                          ],
                        ),
                      SizedBox(height: 24.0),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: <Widget>[
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 8.0),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildTimeline(List<TimelineItem> items) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      separatorBuilder: (context, index) => Divider(
        thickness: 1,
        color: Colors.grey[300],
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
            leading: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _getStatusColor(item.status),
              ),
              child: Icon(
                item.icon,
                color: Colors.white,
                size: 20.0,
              ),
            ),
            title: Text(
              item.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              item.description,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.position,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                Text(
                  DateFormat('dd MMMM yyyy').format(item.date),
                  style: TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ));
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Approve':
        return Colors.green;
      case 'Reject':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

class TimelineItem {
  final String title;
  final String description;
  final DateTime date;
  final String status;
  final String position;
  final IconData icon;

  const TimelineItem(
      {required this.title,
      required this.description,
      required this.date,
      required this.status,
      required this.icon,
      required this.position});
}
//
//
//
// class ProposalDetailPageWrapperProvider extends StatelessWidget {
//   String? proposalToken;
//
//   ProposalDetailPageWrapperProvider({required this.proposalToken, super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//             create: (context) =>
//                 ProposalDetailCubit(proposalToken: proposalToken)),
//         BlocProvider(
//             create: (context) => ApprovalCubit(proposalToken: proposalToken)),
//       ],
//       child: ProposalDetailPage(),
//     );
//   }
// }
//
// class ProposalDetailPage extends StatelessWidget {
//   const ProposalDetailPage();
//
//   String formatRupiah(double number) {
//     final formatter = NumberFormat.currency(
//       locale: 'id_ID', // Indonesian locale
//       symbol: 'Rp', // Rupiah symbol
//       decimalDigits: 0, // No decimal places
//     );
//     return formatter.format(number);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     UsersUseCases().checkSession(context: context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Detail Proposal'),
//         leading: Container(
//           margin: EdgeInsets.all(4),
//           child: IconButton(
//               onPressed: () {
//                 context.go('/');
//               },
//               icon: Icon(Icons.arrow_back)),
//         ),
//       ),
//       body: SingleChildScrollView(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               BlocBuilder<ProposalDetailCubit, ProposalDetailState>(
//                 builder: (BuildContext context, ProposalDetailState state) {
//                   if (state is ProposalDetailInitial) {
//                     return Center(
//                       child: Text(
//                         'Your proposal data is waiting for you!',
//                       ),
//                     );
//                   } else if (state is ProposalDetailLoading) {
//                     return Center(
//                       child: CircularProgressIndicator(
//                         color: Colors.purpleAccent,
//                       ),
//                     );
//                   } else if (state is ProposalDetailLoaded) {
//                     return Column(
//                       children: <Widget>[
//                         SizedBox(height: 16.0),
//
//                         _buildDetailItem(
//                             'Proposal Token', state.proposal.proposalToken),
//                         _buildDetailItem(
//                             'Vendor Name', state.proposal.vendor!.vendorName),
//                         _buildDetailItem('Vendor Address',
//                             state.proposal.vendor!.vendorAddress),
//                         _buildDetailItem(
//                             'Objective', state.proposal.proposalObjective),
//                         _buildDetailItem(
//                             'Description', state.proposal.proposalDescription),
//                         _buildDetailItem('Required Date',
//                             state.proposal.proposalRequireDate.toString()),
//                         _buildDetailItem(
//                             'Budget',
//                             formatRupiah(
//                                     state.proposal.proposalBudget as double)
//                                 as String),
//                         _buildDetailItem('Note', state.proposal.proposalNote),
//                         _buildDetailItem('Type', state.proposal.proposalType),
//                         _buildDetailItem(
//                             'Status', state.proposal.proposalStatus),
//                         _buildDetailItem('Negotiation Note',
//                             state.proposal.proposalNegotiationNote),
//                         _buildDetailItem('Department',
//                             state.proposal.departement!.departementName),
//
//                         // Tombol logout
//                         SizedBox(height: 24.0),
//                       ],
//                     );
//                   } else if (state is ProposalDetailError) {
//                     return ErrorMessage(message: state.message);
//                   }
//                   return const SizedBox();
//                 },
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               BlocBuilder<ApprovalCubit, ApprovalState>(
//                 builder: (BuildContext context, ApprovalState state) {
//                   if (state is ApprovalInitial) {
//                     return Center(
//                       child: Text(
//                         'Your approval data is waiting for you!',
//                       ),
//                     );
//                   } else if (state is ApprovalLoading) {
//                     return Center(
//                       child: CircularProgressIndicator(
//                         color: Colors.purpleAccent,
//                       ),
//                     );
//                   } else if (state is ApprovalLoaded) {
//                     var listApprovals = state.approvals;
//                     List<TimelineItem> timelineItems = [];
//                     for (var approval in listApprovals) {
//                       timelineItems.add(
//                         TimelineItem(
//                           title: approval.approverName, // Gunakan properti 'nama' dari data approval
//                           description: approval.approvalReason, // Gunakan properti 'deskripsi' dari data approval
//                           date: DateTime.parse(approval.approvalAt.toString()), // Gunakan properti 'tanggal' dari data approval
//                           status: approval.approvalStatus, // Gunakan properti 'status' dari data approval
//                           icon: approval.approvalStatus == "Approve" ? Icons.check_circle_outline : Icons.cancel_outlined // Dapatkan ikon berdasarkan status
//                         ),
//                       );
//                     }
//                     return Column(
//                       children: <Widget>[
//                         SizedBox(height: 16.0),
//                         Text("Approval Process"),
//                         SizedBox(height: 5.0),
//                         Timeline(
//                           items: timelineItems,
//                         ),
//                         // Tombol logout
//                         SizedBox(height: 24.0),
//                       ],
//                     );
//                   } else if (state is ApprovalError) {
//                     return ErrorMessage(message: state.message);
//                   }
//                   return const SizedBox();
//                 },
//               ),
//             ],
//           )),
//     );
//   }
//
//   Widget _buildDetailItem(String label, String value) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 4.0),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey.shade300),
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       child: Row(
//         children: <Widget>[
//           Text(
//             label,
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           SizedBox(width: 8.0),
//           Text(value),
//         ],
//       ),
//     );
//   }
// }
//
// class TimelineItem  {
//   final String title;
//   final String description;
//   final DateTime date;
//   final String status;
//   final IconData icon;
//
//   const TimelineItem({
//     Key? key,
//     required this.title,
//     required this.description,
//     required this.date,
//     required this.status,
//     required this.icon,
//   });
// }
//
// class Timeline extends StatelessWidget {
//   final List<TimelineItem> items;
//
//   const Timeline({
//     Key? key,
//     required this.items,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//       itemCount: items.length,
//       separatorBuilder: (context, index) => Divider(
//         thickness: 1,
//         color: Colors.grey[300],
//       ),
//       itemBuilder: (context, index) {
//         final item = items[index];
//         return ListTile(
//           leading: Container(
//             padding: EdgeInsets.all(8.0),
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: _getStatusColor(item.status),
//             ),
//             child: Icon(
//               item.icon,
//               color: Colors.white,
//               size: 20.0,
//             ),
//           ),
//           title: Text(
//             item.title,
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           subtitle: Text(
//             item.description,
//             style: TextStyle(
//               fontSize: 14,
//             ),
//           ),
//           trailing: Text(
//             DateFormat('dd MMMM yyyy').format(item.date),
//             style: TextStyle(
//               fontSize: 12,
//               fontStyle: FontStyle.italic,
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Color _getStatusColor(String status) {
//     switch (status) {
//       case 'Approve':
//         return Colors.green;
//       case 'Reject':
//         return Colors.red;
//       default:
//         return Colors.grey;
//     }
//   }
// }
