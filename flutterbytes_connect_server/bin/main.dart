import 'package:flutterbytes_connect_server/server.dart';

/// This is the starting point for your Serverpod server. Typically, there is
/// no need to modify this file.
void main(List<String> args) {
  final effectiveArgs = [
    if (!args.contains('--apply-migrations')) '--apply-migrations',
    ...args,
  ];
  run(effectiveArgs);
}
