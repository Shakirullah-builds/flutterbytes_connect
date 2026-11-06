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
import 'dart:async' as _ida;
import 'package:flutterbytes_connect_server/src/generated/protocol.dart'
    as _ibxo2jij;
import 'package:serverpod/serverpod.dart' as _is;

abstract class AttendeeProfile
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
      skills: _ibxo2jij.Protocol().deserialize<List<String>>(
        jsonSerialization['skills'],
      ),
      interests: jsonSerialization['interests'] as String,
      githubHandle: jsonSerialization['githubHandle'] as String?,
      personaTitle: jsonSerialization['personaTitle'] as String,
      bioHook: jsonSerialization['bioHook'] as String,
      avatarSeed: jsonSerialization['avatarSeed'] as int,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = AttendeeProfileTable();

  static const db = AttendeeProfileRepository._();

  @override
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

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [AttendeeProfile]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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

  static AttendeeProfileInclude include() {
    return AttendeeProfileInclude._();
  }

  static AttendeeProfileIncludeList includeList({
    _is.WhereExpressionBuilder<AttendeeProfileTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AttendeeProfileTable>? orderBy,
    _is.OrderByListBuilder<AttendeeProfileTable>? orderByList,
    AttendeeProfileInclude? include,
  }) {
    return AttendeeProfileIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AttendeeProfile.t),
      orderByList: orderByList?.call(AttendeeProfile.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
  @_is.useResult
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

class AttendeeProfileUpdateTable extends _is.UpdateTable<AttendeeProfileTable> {
  AttendeeProfileUpdateTable(super.table);

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<String, String> role(String value) => _is.ColumnValue(
    table.role,
    value,
  );

  _is.ColumnValue<List<String>, List<String>> skills(List<String> value) =>
      _is.ColumnValue(
        table.skills,
        value,
      );

  _is.ColumnValue<String, String> interests(String value) => _is.ColumnValue(
    table.interests,
    value,
  );

  _is.ColumnValue<String, String> githubHandle(String? value) =>
      _is.ColumnValue(
        table.githubHandle,
        value,
      );

  _is.ColumnValue<String, String> personaTitle(String value) => _is.ColumnValue(
    table.personaTitle,
    value,
  );

  _is.ColumnValue<String, String> bioHook(String value) => _is.ColumnValue(
    table.bioHook,
    value,
  );

  _is.ColumnValue<int, int> avatarSeed(int value) => _is.ColumnValue(
    table.avatarSeed,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class AttendeeProfileTable extends _is.Table<int?> {
  AttendeeProfileTable({super.tableRelation})
    : super(tableName: 'attendee_profile') {
    updateTable = AttendeeProfileUpdateTable(this);
    name = _is.ColumnString(
      'name',
      this,
    );
    role = _is.ColumnString(
      'role',
      this,
    );
    skills = _is.ColumnSerializable<List<String>>(
      'skills',
      this,
    );
    interests = _is.ColumnString(
      'interests',
      this,
    );
    githubHandle = _is.ColumnString(
      'githubHandle',
      this,
    );
    personaTitle = _is.ColumnString(
      'personaTitle',
      this,
    );
    bioHook = _is.ColumnString(
      'bioHook',
      this,
    );
    avatarSeed = _is.ColumnInt(
      'avatarSeed',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final AttendeeProfileUpdateTable updateTable;

  late final _is.ColumnString name;

  late final _is.ColumnString role;

  late final _is.ColumnSerializable<List<String>> skills;

  late final _is.ColumnString interests;

  late final _is.ColumnString githubHandle;

  late final _is.ColumnString personaTitle;

  late final _is.ColumnString bioHook;

  late final _is.ColumnInt avatarSeed;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    name,
    role,
    skills,
    interests,
    githubHandle,
    personaTitle,
    bioHook,
    avatarSeed,
    createdAt,
  ];
}

class AttendeeProfileInclude extends _is.IncludeObject {
  AttendeeProfileInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => AttendeeProfile.t;
}

class AttendeeProfileIncludeList extends _is.IncludeList {
  AttendeeProfileIncludeList._({
    _is.WhereExpressionBuilder<AttendeeProfileTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AttendeeProfile.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => AttendeeProfile.t;
}

class AttendeeProfileRepository {
  const AttendeeProfileRepository._();

  /// Returns a list of [AttendeeProfile]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<AttendeeProfile>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AttendeeProfileTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AttendeeProfileTable>? orderBy,
    _is.OrderByListBuilder<AttendeeProfileTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AttendeeProfile>(
      where: where?.call(AttendeeProfile.t),
      orderBy: orderBy?.call(AttendeeProfile.t),
      orderByList: orderByList?.call(AttendeeProfile.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Emits [AttendeeProfile]s matching the given query parameters every time the
  /// source tables are modified.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// Use [throttle] to specify the minimum interval between queries. It can
  /// also be set to `null`, in which case the stream will only be throttled
  /// when its subscription is paused.
  ///
  /// Source tables are collected from the queried table, [where], [orderBy],
  /// [orderByList], and the [include] graph. [alsoTriggerOnTables] is added
  /// to that set. Pass [Table] instances such as `AttendeeProfile.t`.
  ///
  /// Raw [Expression] SQL is not inspected. Tables referenced only in raw
  /// SQL must be passed via [alsoTriggerOnTables].
  ///
  /// The stream always reads committed state and never joins an ambient
  /// [Transaction]. Emissions for a write fire after that write commits.
  ///
  /// Currently only supported on SQLite. Calling this method on PostgreSQL
  /// throws an [UnsupportedError].
  ///
  /// ```dart
  /// var subscription = Persons.db.watch(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// ).listen((persons) {
  ///   // Handle the latest matching rows.
  /// });
  /// ```
  _ida.Stream<List<AttendeeProfile>> watch(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AttendeeProfileTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AttendeeProfileTable>? orderBy,
    _is.OrderByListBuilder<AttendeeProfileTable>? orderByList,
    Duration? throttle = const Duration(milliseconds: 30),
    Iterable<_is.Table>? alsoTriggerOnTables,
  }) {
    return session.db.watch<AttendeeProfile>(
      where: where?.call(AttendeeProfile.t),
      orderBy: orderBy?.call(AttendeeProfile.t),
      orderByList: orderByList?.call(AttendeeProfile.t),
      limit: limit,
      offset: offset,
      throttle: throttle,
      alsoTriggerOnTables: alsoTriggerOnTables,
    );
  }

  /// Returns the first matching [AttendeeProfile] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<AttendeeProfile?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AttendeeProfileTable>? where,
    int? offset,
    _is.OrderByBuilder<AttendeeProfileTable>? orderBy,
    _is.OrderByListBuilder<AttendeeProfileTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AttendeeProfile>(
      where: where?.call(AttendeeProfile.t),
      orderBy: orderBy?.call(AttendeeProfile.t),
      orderByList: orderByList?.call(AttendeeProfile.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AttendeeProfile] by its [id] or null if no such row exists.
  Future<AttendeeProfile?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AttendeeProfile>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AttendeeProfile]s in the list and returns the inserted rows.
  ///
  /// The returned [AttendeeProfile]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AttendeeProfile>> insert(
    _is.DatabaseSession session,
    List<AttendeeProfile> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<AttendeeProfile>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [AttendeeProfile] and returns the inserted row.
  ///
  /// The returned [AttendeeProfile] will have its `id` field set.
  Future<AttendeeProfile> insertRow(
    _is.DatabaseSession session,
    AttendeeProfile row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<AttendeeProfile>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [AttendeeProfile]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [AttendeeProfile]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AttendeeProfile>> upsert(
    _is.DatabaseSession session,
    List<AttendeeProfile> rows, {
    required _is.ColumnSelections<AttendeeProfileTable> conflictColumns,
    _is.ColumnSelections<AttendeeProfileTable>? updateColumns,
    _is.WhereExpressionBuilder<AttendeeProfileTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<AttendeeProfile>(
      rows,
      conflictColumns: conflictColumns(AttendeeProfile.t),
      updateColumns: updateColumns?.call(AttendeeProfile.t),
      updateWhere: updateWhere?.call(AttendeeProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [AttendeeProfile] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [AttendeeProfile] will have its `id` field set.
  Future<AttendeeProfile?> upsertRow(
    _is.DatabaseSession session,
    AttendeeProfile row, {
    required _is.ColumnSelections<AttendeeProfileTable> conflictColumns,
    _is.ColumnSelections<AttendeeProfileTable>? updateColumns,
    _is.WhereExpressionBuilder<AttendeeProfileTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<AttendeeProfile>(
      row,
      conflictColumns: conflictColumns(AttendeeProfile.t),
      updateColumns: updateColumns?.call(AttendeeProfile.t),
      updateWhere: updateWhere?.call(AttendeeProfile.t),
      transaction: transaction,
    );
  }

  /// Updates all [AttendeeProfile]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AttendeeProfile>> update(
    _is.DatabaseSession session,
    List<AttendeeProfile> rows, {
    _is.ColumnSelections<AttendeeProfileTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<AttendeeProfile>(
      rows,
      columns: columns?.call(AttendeeProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [AttendeeProfile]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AttendeeProfile> updateRow(
    _is.DatabaseSession session,
    AttendeeProfile row, {
    _is.ColumnSelections<AttendeeProfileTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<AttendeeProfile>(
      row,
      columns: columns?.call(AttendeeProfile.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AttendeeProfile] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AttendeeProfile?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<AttendeeProfileUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<AttendeeProfile>(
      id,
      columnValues: columnValues(AttendeeProfile.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AttendeeProfile]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AttendeeProfile>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<AttendeeProfileUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<AttendeeProfileTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AttendeeProfileTable>? orderBy,
    _is.OrderByListBuilder<AttendeeProfileTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<AttendeeProfile>(
      columnValues: columnValues(AttendeeProfile.t.updateTable),
      where: where(AttendeeProfile.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AttendeeProfile.t),
      orderByList: orderByList?.call(AttendeeProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [AttendeeProfile]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AttendeeProfile>> delete(
    _is.DatabaseSession session,
    List<AttendeeProfile> rows, {
    _is.OrderByBuilder<AttendeeProfileTable>? orderBy,
    _is.OrderByListBuilder<AttendeeProfileTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<AttendeeProfile>(
      rows,
      orderBy: orderBy?.call(AttendeeProfile.t),
      orderByList: orderByList?.call(AttendeeProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [AttendeeProfile].
  Future<AttendeeProfile> deleteRow(
    _is.DatabaseSession session,
    AttendeeProfile row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AttendeeProfile>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AttendeeProfile>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AttendeeProfileTable> where,
    _is.OrderByBuilder<AttendeeProfileTable>? orderBy,
    _is.OrderByListBuilder<AttendeeProfileTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<AttendeeProfile>(
      where: where(AttendeeProfile.t),
      orderBy: orderBy?.call(AttendeeProfile.t),
      orderByList: orderByList?.call(AttendeeProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AttendeeProfileTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<AttendeeProfile>(
      where: where?.call(AttendeeProfile.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AttendeeProfile] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AttendeeProfileTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AttendeeProfile>(
      where: where(AttendeeProfile.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
