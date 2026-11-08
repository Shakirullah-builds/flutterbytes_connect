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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class CollabMatch
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CollabMatch._({
    this.id,
    required this.devOneId,
    required this.devTwoId,
    required this.devOneName,
    required this.devTwoName,
    required this.projectTitle,
    required this.tagline,
    required this.devOneResponsibility,
    required this.devTwoResponsibility,
    required this.createdAt,
  });

  factory CollabMatch({
    int? id,
    required int devOneId,
    required int devTwoId,
    required String devOneName,
    required String devTwoName,
    required String projectTitle,
    required String tagline,
    required String devOneResponsibility,
    required String devTwoResponsibility,
    required DateTime createdAt,
  }) = _CollabMatchImpl;

  factory CollabMatch.fromJson(Map<String, dynamic> jsonSerialization) {
    return CollabMatch(
      id: jsonSerialization['id'] as int?,
      devOneId: jsonSerialization['devOneId'] as int,
      devTwoId: jsonSerialization['devTwoId'] as int,
      devOneName: jsonSerialization['devOneName'] as String,
      devTwoName: jsonSerialization['devTwoName'] as String,
      projectTitle: jsonSerialization['projectTitle'] as String,
      tagline: jsonSerialization['tagline'] as String,
      devOneResponsibility: jsonSerialization['devOneResponsibility'] as String,
      devTwoResponsibility: jsonSerialization['devTwoResponsibility'] as String,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int devOneId;

  int devTwoId;

  String devOneName;

  String devTwoName;

  String projectTitle;

  String tagline;

  String devOneResponsibility;

  String devTwoResponsibility;

  DateTime createdAt;

  /// Returns a shallow copy of this [CollabMatch]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CollabMatch copyWith({
    int? id,
    int? devOneId,
    int? devTwoId,
    String? devOneName,
    String? devTwoName,
    String? projectTitle,
    String? tagline,
    String? devOneResponsibility,
    String? devTwoResponsibility,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CollabMatch',
      if (id != null) 'id': id,
      'devOneId': devOneId,
      'devTwoId': devTwoId,
      'devOneName': devOneName,
      'devTwoName': devTwoName,
      'projectTitle': projectTitle,
      'tagline': tagline,
      'devOneResponsibility': devOneResponsibility,
      'devTwoResponsibility': devTwoResponsibility,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CollabMatch',
      if (id != null) 'id': id,
      'devOneId': devOneId,
      'devTwoId': devTwoId,
      'devOneName': devOneName,
      'devTwoName': devTwoName,
      'projectTitle': projectTitle,
      'tagline': tagline,
      'devOneResponsibility': devOneResponsibility,
      'devTwoResponsibility': devTwoResponsibility,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CollabMatchImpl extends CollabMatch {
  _CollabMatchImpl({
    int? id,
    required int devOneId,
    required int devTwoId,
    required String devOneName,
    required String devTwoName,
    required String projectTitle,
    required String tagline,
    required String devOneResponsibility,
    required String devTwoResponsibility,
    required DateTime createdAt,
  }) : super._(
         id: id,
         devOneId: devOneId,
         devTwoId: devTwoId,
         devOneName: devOneName,
         devTwoName: devTwoName,
         projectTitle: projectTitle,
         tagline: tagline,
         devOneResponsibility: devOneResponsibility,
         devTwoResponsibility: devTwoResponsibility,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [CollabMatch]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CollabMatch copyWith({
    Object? id = _Undefined,
    int? devOneId,
    int? devTwoId,
    String? devOneName,
    String? devTwoName,
    String? projectTitle,
    String? tagline,
    String? devOneResponsibility,
    String? devTwoResponsibility,
    DateTime? createdAt,
  }) {
    return CollabMatch(
      id: id is int? ? id : this.id,
      devOneId: devOneId ?? this.devOneId,
      devTwoId: devTwoId ?? this.devTwoId,
      devOneName: devOneName ?? this.devOneName,
      devTwoName: devTwoName ?? this.devTwoName,
      projectTitle: projectTitle ?? this.projectTitle,
      tagline: tagline ?? this.tagline,
      devOneResponsibility: devOneResponsibility ?? this.devOneResponsibility,
      devTwoResponsibility: devTwoResponsibility ?? this.devTwoResponsibility,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
