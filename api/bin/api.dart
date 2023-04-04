import 'dart:io';
import 'package:api/api.dart';
import 'package:api/api.dart' as api;
import 'package:conduit/conduit.dart';


Future<void> main(List<String> arguments) async {
  final port = int.parse(Platform.environment["PORT"] ?? "8888");

  final service = Application<DatabaseChannel>()
  ..options.port = port
  ..options.certificateFilePath = 'config.yaml';

  await service.start(numberOfInstances: 3, consoleLogging: true);
}
