import 'package:equatable/equatable.dart';

class HomepagesModel extends Equatable {
  int? procurementProposal;
  int? serviceProposal;
  int? completedProposal;
  int? rejectProposal;
  int? waitingProposal;

  HomepagesModel(
      {this.procurementProposal,
        this.serviceProposal,
        this.completedProposal,
        this.rejectProposal,
        this.waitingProposal});

  factory HomepagesModel.fromJson(Map<String, dynamic> json) {
    return HomepagesModel(
        procurementProposal : json['procurementProposal'],
        serviceProposal : json['serviceProposal'],
        completedProposal : json['completedProposal'],
        rejectProposal : json['rejectProposal'],
        waitingProposal : json['waitingProposal']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['procurementProposal'] = procurementProposal;
    data['serviceProposal'] = serviceProposal;
    data['completedProposal'] = completedProposal;
    data['rejectProposal'] = rejectProposal;
    data['waitingProposal'] = waitingProposal;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
