import 'package:carrent/Models/Invite.dart';
import 'package:carrent/Models/User.dart';

class Team {
  String id = "";
  User leader = User();
  List<User> members = [];
  List<Invitation> pendingInvitations = [];
  String name = "";
  String description = "";
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();

  Team();

  Team.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    if (json['leader'] is Map<String, dynamic>) {
      leader = User.fromJson(json['leader']);
    }
    if (json['members'] is List<dynamic>) {
      for (var e in json['members']) {
        if (e is Map<String, dynamic>) {
          members.add(User.fromJson(e));
        }
      }
    }
    if (json['pendingInvitations'] is List<dynamic>) {
      for (final e in json['pendingInvitations'] as List<dynamic>) {
        if (e is Map<String, dynamic>) {
          pendingInvitations.add(Invitation.fromJson(e));
        }
      }
    }

    name = json['name'] ?? "";
    description = json['description'] ?? "";
    if (json['createdAt'] != null) {
      createdAt = DateTime.parse(json['createdAt']);
    }

    if (json['updatedAt'] != null) {
      updatedAt = DateTime.parse(json['updatedAt']);
    }
  }

  Map<String, dynamic> toJson(String leaderId) {
    final Map<String, dynamic> data = {};
    data['_id'] = id;
    data['leader'] = leader;

    data['name'] = name;
    data['description'] = description;
    data['createdAt'] = createdAt.toString();
    data['updatedAt'] = updatedAt.toString();

    return data;
  }
}
