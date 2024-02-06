part of 'invite_member_cubit.dart';

@immutable
sealed class InviteMemberState {}

final class InviteMemberInitial extends InviteMemberState {}

final class InviteMemberLoadingState extends InviteMemberState {}
