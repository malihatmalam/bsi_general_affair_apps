import 'package:bsi_general_affair_apps/data/models/approvals/approval_posts_model.dart';
import 'package:bsi_general_affair_apps/data/models/approvals/approvals_model.dart';
import 'package:bsi_general_affair_apps/domain/usecases/approvals_usecases.dart';
import 'package:bsi_general_affair_apps/presentation/core/services/auth_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../domain/usecases/users_usecases.dart';
import '../../core/services/dropdown_service.dart';
import '../../core/widget/errorMessage.dart';
import '../proposalDetailPage/cubit/proposal_detail_cubit.dart';
import 'cubit/approval_cubit.dart';

class ApprovalPageWrapperProvider extends StatelessWidget {
  final String? proposalToken;
  var box = Hive.box('userdata');

  ApprovalPageWrapperProvider({required this.proposalToken, Key? key})
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
      child: ApprovalPage(proposalToken: proposalToken),
    );
  }
}

class ApprovalPage extends StatelessWidget {
  ApprovalPage({required this.proposalToken });

  final String? proposalToken;

  // Variable
  GlobalKey<FormState> _approvalForm = GlobalKey<FormState>();
  TextEditingController _reasonController = TextEditingController();
  var box = Hive.box('userdata');

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
        title: Text('Approval Proposal'),
        leading: Container(
          margin: EdgeInsets.all(4),
          child: IconButton(
            onPressed: () {
              context.go('/');
              Provider.of<DropdownService>(context, listen: false)
                  .changeStatusApproval(null);
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
                      Column(
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
                                      Expanded(
                                        child: Text(
                                          state.proposal.proposalStatus,
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              fontSize: 14, fontWeight: FontWeight.bold,color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            color: Colors.lightBlueAccent,
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
                      ),
                      SizedBox(height: 24.0),
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
                      SizedBox(height: 5.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Approval Proposal", style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 18)),
                        ],
                      ),
                      _buildFormApproval(state.proposal.proposalToken)
                    ],
                  );
                } else if (state is ProposalDetailError) {
                  return ErrorMessage(message: state.message);
                }
                return const SizedBox();
              },
            )
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
      separatorBuilder: (context, index) =>
          Divider(
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

  Widget _buildFormApproval(String proposalToken) {
    return Consumer<DropdownService>(
        builder: (BuildContext context, dropdownService, Widget? child) {
          return SingleChildScrollView(
              padding: EdgeInsets.all(20.0),
              child: Form(
                  key: _approvalForm,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _reasonController,
                        minLines: 1,
                        maxLines: 2,
                        decoration: InputDecoration(
                          labelText: 'Reason Proposal',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.length == 0) {
                            return 'Reason tidak boleh kosong!';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DropdownButtonFormField(
                        value: dropdownService.getSelectedStatusApproval(),
                        items: [
                          DropdownMenuItem(
                            value: 'Approve',
                            child: Text('Approve'),
                          ),
                          DropdownMenuItem(
                            value: 'Reject',
                            child: Text('Reject'),
                          ),
                        ],
                        onChanged: (value) {
                          Provider.of<DropdownService>(context, listen: false)
                              .changeStatusApproval(value);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Pilih opsi terlebih dahulu';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Pilih Status'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Consumer<AuthService>(builder:
                          (BuildContext context, authService, Widget? child) {
                        return Column(
                          children: [
                            if (authService.getIsAuthenticating())
                              const CircularProgressIndicator(),
                            if (!authService.getIsAuthenticating())
                              ElevatedButton(
                                onPressed: () {
                                  if (_approvalForm.currentState!.validate()) {
                                    print(
                                        'Status: ${dropdownService
                                            .getSelectedStatusApproval()},');
                                    print('Reason: ${_reasonController.text},');
                                    print('Proposal: ${proposalToken},');
                                    print('Employee Number: ${box.get(
                                        'employeeNumber')} ');

                                    ApprovalPostsModel approvalPostsModel = ApprovalPostsModel(
                                        proposalToken: proposalToken,
                                        employeeIdNumber: box.get(
                                            'employeeNumber'),
                                        approvalReason: _reasonController.text,
                                        approvalStatus: dropdownService
                                            .getSelectedStatusApproval()!
                                    );

                                    ApprovalsUseCases().postApprovalData(
                                        approvalPostsModel: approvalPostsModel,
                                        context: context
                                    );
                                    _reasonController.text = "";
                                  }
                                },
                                child: Text('Process', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size.fromHeight(50),
                                  backgroundColor: Colors.cyan
                                ),
                              )
                          ],
                        );
                      })
                    ],
                  )));
        });
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

  const TimelineItem({required this.title,
    required this.description,
    required this.date,
    required this.status,
    required this.icon,
    required this.position});
}
