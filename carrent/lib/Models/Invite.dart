import 'package:carrent/Models/Team.dart';
import 'package:carrent/Models/User.dart';

enum InvitationStatus {
  pending,
  accepted,
  refused,
}

class Invitation {
  String id = "";
  String leaderId = "";
  User leader = User();
  String userId = "";
  String teamId = "";
  Team team = Team();
  InvitationStatus status = InvitationStatus.pending;
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();

  Invitation();

  Invitation.fromJson(Map<String, dynamic> json) {
    id = json['_id'];

    if (json['leaderId'] is Map<String, dynamic>) {
      leader = User.fromJson(json['leaderId']);
    } else {
      json['leaderId'] = leaderId;
    }
    if (json['teamId'] is Map<String, dynamic>) {
      team = Team.fromJson(json['teamId']);
    } else {
      json['teamId'] = teamId;
    }
    userId = json['userId'];
    status = InvitationStatus.values.byName(json['status']);
    createdAt = DateTime.parse(json['createdAt']);
    updatedAt = DateTime.parse(json['updatedAt']);
  }
}
