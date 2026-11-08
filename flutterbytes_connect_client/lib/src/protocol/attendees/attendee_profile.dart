/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutterbytes_connect_client/src/protocol/protocol.dart'
    as _i5ajnshz;
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class AttendeeProfile
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AttendeeProfile._({
    this.id,
    required this.name,
    required this.role,
    required this.skills,
    required this.interests,
    this.githubHandle,
    required this.personaTitle,
    required this.bioHook,
    required this.avatarSeed,
    required this.createdAt,
  });

  factory AttendeeProfile({
    int? id,
    required String name,
    required String role,
    required List<String> skills,
    required String interests,
    String? githubHandle,
    required String personaTitle,
    required String bioHook,
    required int avatarSeed,
    required DateTime createdAt,
  }) = _AttendeeProfileImpl;

  factory AttendeeProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return AttendeeProfile(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      role: jsonSerialization['role'] as String,
      skills: _i5ajnshz.Protocol().deserialize<List<String>>(
        jsonSerialization['skills'],
      ),
      interests: jsonSerialization['interests'] as String,
      githubHandle: jsonSerialization['githubHandle'] as String?,
      personaTitle: jsonSerialization['personaTitle'] as String,
      bioHook: jsonSerialization['bioHook'] as String,
      avatarSeed: jsonSerialization['avatarSeed'] as int,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String role;

  List<String> skills;

  String interests;

  String? githubHandle;

  String personaTitle;

  String bioHook;

  int avatarSeed;

  DateTime createdAt;

  /// Returns a shallow copy of this [AttendeeProfile]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AttendeeProfile copyWith({
    int? id,
    String? name,
    String? role,
    List<String>? skills,
    String? interests,
    String? githubHandle,
    String? personaTitle,
    String? bioHook,
    int? avatarSeed,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AttendeeProfile',
      if (id != null) 'id': id,
      'name': name,
      'role': role,
      'skills': skills.toJson(),
      'interests': interests,
      if (githubHandle != null) 'githubHandle': githubHandle,
      'personaTitle': personaTitle,
      'bioHook': bioHook,
      'avatarSeed': avatarSeed,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AttendeeProfile',
      if (id != null) 'id': id,
      'name': name,
      'role': role,
      'skills': skills.toJson(),
      'interests': interests,
      if (githubHandle != null) 'githubHandle': githubHandle,
      'personaTitle': personaTitle,
      'bioHook': bioHook,
      'avatarSeed': avatarSeed,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AttendeeProfileImpl extends AttendeeProfile {
  _AttendeeProfileImpl({
    int? id,
    required String name,
    required String role,
    required List<String> skills,
    required String interests,
    String? githubHandle,
    required String personaTitle,
    required String bioHook,
    required int avatarSeed,
    required DateTime createdAt,
  }) : super._(
         id: id,
         name: name,
         role: role,
         skills: skills,
         interests: interests,
         githubHandle: githubHandle,
         personaTitle: personaTitle,
         bioHook: bioHook,
         avatarSeed: avatarSeed,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AttendeeProfile]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AttendeeProfile copyWith({
    Object? id = _Undefined,
    String? name,
    String? role,
    List<String>? skills,
    String? interests,
    Object? githubHandle = _Undefined,
    String? personaTitle,
    String? bioHook,
    int? avatarSeed,
    DateTime? createdAt,
  }) {
    return AttendeeProfile(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      skills: skills ?? this.skills.map((e0) => e0).toList(),
      interests: interests ?? this.interests,
      githubHandle: githubHandle is String? ? githubHandle : this.githubHandle,
      personaTitle: personaTitle ?? this.personaTitle,
      bioHook: bioHook ?? this.bioHook,
      avatarSeed: avatarSeed ?? this.avatarSeed,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
