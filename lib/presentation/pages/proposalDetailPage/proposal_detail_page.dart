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
        leading: Container(
          margin: EdgeInsets.all(4),
          child: IconButton(
            onPressed: () {
              context.go('/');
            },
            icon: Icon(Icons.arrow_back),
            color: Colors.blueAccent,
          ),
        ),
        title: Text(
          'Detail Proposal',
          style: TextStyle(
            fontSize: 18,
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
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
                  Color colorData;
                  Color textColorStatusData;
                  Icon iconData;
                  if(state.proposal.proposalStatus.trim() == "Waiting"){
                    colorData = Colors.yellow;
                    textColorStatusData = Colors.black;
                    iconData = Icon(Icons.history_sharp);
                  } else if(state.proposal.proposalStatus.trim() == "Rejected"){
                    colorData = Colors.redAccent;
                    textColorStatusData = Colors.white;
                    iconData = Icon(Icons.cancel_outlined, color: Colors.white,);
                  } else {
                    colorData = Colors.green;
                    textColorStatusData = Colors.white;
                    iconData = Icon(Icons.check_circle_outline, color: Colors.white,);
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 5.0),
                      Card(
                        child: Container(
                          margin: EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    state.proposal.proposalObjective,
                                    style: TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.token,color: Colors.white),
                                  SizedBox(width: 10,),
                                  Text(
                                    state.proposal.proposalToken,
                                    style: TextStyle(
                                        fontSize: 14, fontWeight: FontWeight.bold,color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        color: Colors.lightBlueAccent,
                        elevation: 2,
                      ),
                      SizedBox(height: 5.0),
                      Card(
                        child: Container(
                          margin: EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  iconData,
                                  SizedBox(width: 10,),
                                  Text(
                                    state.proposal.proposalStatus.trim(),
                                    style: TextStyle(
                                        fontSize: 14, fontWeight: FontWeight.bold,color: textColorStatusData),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${state.proposal.proposalApproveLevel} / 3',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          fontSize: 14, fontWeight: FontWeight.bold,color: textColorStatusData),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        color: colorData,
                        elevation: 2,
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color : Colors.white,
                            border: Border.all(color: Colors.cyan,width: 2)
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(child: Text('Description : ',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black)),)
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Expanded(child: Text(state.proposal.proposalDescription,style: TextStyle(color: Colors.black),))
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Expanded(child: Text('Note : ',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black, fontStyle: FontStyle.italic)),)
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: Text(state.proposal.proposalNote,style: TextStyle(color: Colors.black, fontSize: 10),))
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: _cardMenu(
                                  icon: 'assets/images/calendar.png',
                                  title: 'Require Date',
                                  vertical: 10,
                                  description:
                                  DateFormat('yyyy-MM-dd').format(state.proposal.proposalRequireDate!),
                                  color: Colors.yellow,
                                  colorBorder: Colors.yellow,
                                  fontColor: Colors.black,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: _cardMenu(
                                  icon: 'assets/images/money.png',
                                  title: 'Budget',
                                  vertical: 10,
                                  description:
                                  formatRupiah(
                                      state.proposal.proposalBudget.toDouble()),
                                  color: Colors.blueGrey,
                                  colorBorder: Colors.blueGrey,
                                  fontColor: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: _cardMenu(
                                  icon: 'assets/images/document.png',
                                  title: 'Type',
                                  vertical: 10,
                                  description:
                                  state.proposal.proposalType.trim(),
                                  color: Colors.lightBlue,
                                  colorBorder: Colors.lightBlue,
                                  fontColor: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: _cardMenu(
                                  icon: 'assets/images/truck.png',
                                  title: 'Vendor : ${state.proposal.vendor?.vendorName}',
                                  vertical: 10,
                                  description: 'Alamat : ${state.proposal.vendor?.vendorAddress}',
                                  color: Colors.cyan,
                                  colorBorder: Colors.cyan,
                                  fontColor: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Approval Process", style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 18)),
                        ],
                      ),
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
                                    await ProposalsUseCases()
                                        .deleteProposalCancelData(state
                                            .proposal.proposalToken
                                            .trim());
                                    context.go("/");
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Colors.redAccent),
                                  ),
                                  child: Text(
                                    "Cancel the proposal",
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
                                      context.go(
                                          "/proposal/edit/${proposalToken}");
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.yellow),
                                    ),
                                    child: Text(
                                      "Revise the proposal",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )))
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
