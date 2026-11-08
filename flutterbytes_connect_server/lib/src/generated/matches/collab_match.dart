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
import 'package:serverpod/serverpod.dart' as _is;

abstract class CollabMatch
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = CollabMatchTable();

  static const db = CollabMatchRepository._();

  @override
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

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [CollabMatch]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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

  static CollabMatchInclude include() {
    return CollabMatchInclude._();
  }

  static CollabMatchIncludeList includeList({
    _is.WhereExpressionBuilder<CollabMatchTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CollabMatchTable>? orderBy,
    _is.OrderByListBuilder<CollabMatchTable>? orderByList,
    CollabMatchInclude? include,
  }) {
    return CollabMatchIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CollabMatch.t),
      orderByList: orderByList?.call(CollabMatch.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
  @_is.useResult
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

class CollabMatchUpdateTable extends _is.UpdateTable<CollabMatchTable> {
  CollabMatchUpdateTable(super.table);

  _is.ColumnValue<int, int> devOneId(int value) => _is.ColumnValue(
    table.devOneId,
    value,
  );

  _is.ColumnValue<int, int> devTwoId(int value) => _is.ColumnValue(
    table.devTwoId,
    value,
  );

  _is.ColumnValue<String, String> devOneName(String value) => _is.ColumnValue(
    table.devOneName,
    value,
  );

  _is.ColumnValue<String, String> devTwoName(String value) => _is.ColumnValue(
    table.devTwoName,
    value,
  );

  _is.ColumnValue<String, String> projectTitle(String value) => _is.ColumnValue(
    table.projectTitle,
    value,
  );

  _is.ColumnValue<String, String> tagline(String value) => _is.ColumnValue(
    table.tagline,
    value,
  );

  _is.ColumnValue<String, String> devOneResponsibility(String value) =>
      _is.ColumnValue(
        table.devOneResponsibility,
        value,
      );

  _is.ColumnValue<String, String> devTwoResponsibility(String value) =>
      _is.ColumnValue(
        table.devTwoResponsibility,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class CollabMatchTable extends _is.Table<int?> {
  CollabMatchTable({super.tableRelation}) : super(tableName: 'collab_match') {
    updateTable = CollabMatchUpdateTable(this);
    devOneId = _is.ColumnInt(
      'devOneId',
      this,
    );
    devTwoId = _is.ColumnInt(
      'devTwoId',
      this,
    );
    devOneName = _is.ColumnString(
      'devOneName',
      this,
    );
    devTwoName = _is.ColumnString(
      'devTwoName',
      this,
    );
    projectTitle = _is.ColumnString(
      'projectTitle',
      this,
    );
    tagline = _is.ColumnString(
      'tagline',
      this,
    );
    devOneResponsibility = _is.ColumnString(
      'devOneResponsibility',
      this,
    );
    devTwoResponsibility = _is.ColumnString(
      'devTwoResponsibility',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final CollabMatchUpdateTable updateTable;

  late final _is.ColumnInt devOneId;

  late final _is.ColumnInt devTwoId;

  late final _is.ColumnString devOneName;

  late final _is.ColumnString devTwoName;

  late final _is.ColumnString projectTitle;

  late final _is.ColumnString tagline;

  late final _is.ColumnString devOneResponsibility;

  late final _is.ColumnString devTwoResponsibility;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    devOneId,
    devTwoId,
    devOneName,
    devTwoName,
    projectTitle,
    tagline,
    devOneResponsibility,
    devTwoResponsibility,
    createdAt,
  ];
}

class CollabMatchInclude extends _is.IncludeObject {
  CollabMatchInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => CollabMatch.t;
}

class CollabMatchIncludeList extends _is.IncludeList {
  CollabMatchIncludeList._({
    _is.WhereExpressionBuilder<CollabMatchTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CollabMatch.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => CollabMatch.t;
}

class CollabMatchRepository {
  const CollabMatchRepository._();

  /// Returns a list of [CollabMatch]s matching the given query parameters.
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
  Future<List<CollabMatch>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CollabMatchTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CollabMatchTable>? orderBy,
    _is.OrderByListBuilder<CollabMatchTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CollabMatch>(
      where: where?.call(CollabMatch.t),
      orderBy: orderBy?.call(CollabMatch.t),
      orderByList: orderByList?.call(CollabMatch.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Emits [CollabMatch]s matching the given query parameters every time the
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
  /// to that set. Pass [Table] instances such as `CollabMatch.t`.
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
  _ida.Stream<List<CollabMatch>> watch(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CollabMatchTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CollabMatchTable>? orderBy,
    _is.OrderByListBuilder<CollabMatchTable>? orderByList,
    Duration? throttle = const Duration(milliseconds: 30),
    Iterable<_is.Table>? alsoTriggerOnTables,
  }) {
    return session.db.watch<CollabMatch>(
      where: where?.call(CollabMatch.t),
      orderBy: orderBy?.call(CollabMatch.t),
      orderByList: orderByList?.call(CollabMatch.t),
      limit: limit,
      offset: offset,
      throttle: throttle,
      alsoTriggerOnTables: alsoTriggerOnTables,
    );
  }

  /// Returns the first matching [CollabMatch] matching the given query parameters.
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
  Future<CollabMatch?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CollabMatchTable>? where,
    int? offset,
    _is.OrderByBuilder<CollabMatchTable>? orderBy,
    _is.OrderByListBuilder<CollabMatchTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CollabMatch>(
      where: where?.call(CollabMatch.t),
      orderBy: orderBy?.call(CollabMatch.t),
      orderByList: orderByList?.call(CollabMatch.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CollabMatch] by its [id] or null if no such row exists.
  Future<CollabMatch?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CollabMatch>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CollabMatch]s in the list and returns the inserted rows.
  ///
  /// The returned [CollabMatch]s will have their `id` fields set.
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
  Future<List<CollabMatch>> insert(
    _is.DatabaseSession session,
    List<CollabMatch> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CollabMatch>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CollabMatch] and returns the inserted row.
  ///
  /// The returned [CollabMatch] will have its `id` field set.
  Future<CollabMatch> insertRow(
    _is.DatabaseSession session,
    CollabMatch row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<CollabMatch>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [CollabMatch]s in the list and returns the resulting rows.
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
  /// The returned [CollabMatch]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CollabMatch>> upsert(
    _is.DatabaseSession session,
    List<CollabMatch> rows, {
    required _is.ColumnSelections<CollabMatchTable> conflictColumns,
    _is.ColumnSelections<CollabMatchTable>? updateColumns,
    _is.WhereExpressionBuilder<CollabMatchTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CollabMatch>(
      rows,
      conflictColumns: conflictColumns(CollabMatch.t),
      updateColumns: updateColumns?.call(CollabMatch.t),
      updateWhere: updateWhere?.call(CollabMatch.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CollabMatch] and returns the resulting row.
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
  /// The returned [CollabMatch] will have its `id` field set.
  Future<CollabMatch?> upsertRow(
    _is.DatabaseSession session,
    CollabMatch row, {
    required _is.ColumnSelections<CollabMatchTable> conflictColumns,
    _is.ColumnSelections<CollabMatchTable>? updateColumns,
    _is.WhereExpressionBuilder<CollabMatchTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CollabMatch>(
      row,
      conflictColumns: conflictColumns(CollabMatch.t),
      updateColumns: updateColumns?.call(CollabMatch.t),
      updateWhere: updateWhere?.call(CollabMatch.t),
      transaction: transaction,
    );
  }

  /// Updates all [CollabMatch]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CollabMatch>> update(
    _is.DatabaseSession session,
    List<CollabMatch> rows, {
    _is.ColumnSelections<CollabMatchTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CollabMatch>(
      rows,
      columns: columns?.call(CollabMatch.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CollabMatch]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CollabMatch> updateRow(
    _is.DatabaseSession session,
    CollabMatch row, {
    _is.ColumnSelections<CollabMatchTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<CollabMatch>(
      row,
      columns: columns?.call(CollabMatch.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CollabMatch] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CollabMatch?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<CollabMatchUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<CollabMatch>(
      id,
      columnValues: columnValues(CollabMatch.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CollabMatch]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CollabMatch>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CollabMatchUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<CollabMatchTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CollabMatchTable>? orderBy,
    _is.OrderByListBuilder<CollabMatchTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CollabMatch>(
      columnValues: columnValues(CollabMatch.t.updateTable),
      where: where(CollabMatch.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CollabMatch.t),
      orderByList: orderByList?.call(CollabMatch.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CollabMatch]s in the list and returns the deleted rows.
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
  Future<List<CollabMatch>> delete(
    _is.DatabaseSession session,
    List<CollabMatch> rows, {
    _is.OrderByBuilder<CollabMatchTable>? orderBy,
    _is.OrderByListBuilder<CollabMatchTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CollabMatch>(
      rows,
      orderBy: orderBy?.call(CollabMatch.t),
      orderByList: orderByList?.call(CollabMatch.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CollabMatch].
  Future<CollabMatch> deleteRow(
    _is.DatabaseSession session,
    CollabMatch row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CollabMatch>(
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
  Future<List<CollabMatch>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CollabMatchTable> where,
    _is.OrderByBuilder<CollabMatchTable>? orderBy,
    _is.OrderByListBuilder<CollabMatchTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CollabMatch>(
      where: where(CollabMatch.t),
      orderBy: orderBy?.call(CollabMatch.t),
      orderByList: orderByList?.call(CollabMatch.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CollabMatchTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<CollabMatch>(
      where: where?.call(CollabMatch.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CollabMatch] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CollabMatchTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CollabMatch>(
      where: where(CollabMatch.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
