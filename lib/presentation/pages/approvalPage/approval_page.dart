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
                              state.proposal.proposalBudget as double)),
                      _buildDetailItem('Note', state.proposal.proposalNote),
                      _buildDetailItem('Type', state.proposal.proposalType),
                      _buildDetailItem('Status', state.proposal.proposalStatus),
                      _buildDetailItem('Negotiation Note',
                          state.proposal.proposalNegotiationNote),
                      _buildDetailItem('Department',
                          state.proposal.departement!.departementName),
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
                      SizedBox(height: 5.0),
                      Text("Approval Proposal"),
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
                                child: Text('Approval'),
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size.fromHeight(50),
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
