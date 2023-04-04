import 'dart:io';
import 'package:conduit/conduit.dart';

import 'controllers/auth_controller.dart';
import 'controllers/category_controller.dart';
import 'controllers/post_controller.dart';
import 'controllers/token_controller.dart';
import 'controllers/user_controller.dart';

import 'models/user.dart';
import 'models/post.dart';
import 'models/category.dart';

class DatabaseChannel extends ApplicationChannel {
  late final ManagedContext context;

  @override
  Future prepare() async {
    final persistentStore = _initDatabase();
    final dataModel = ManagedDataModel([Post, User, Category]);

    context = ManagedContext(dataModel, persistentStore);
    return super.prepare();
  }

  @override
  Controller get entryPoint => Router()
    ..route('/user/[:id]').link(TokenController.new)!.link(() => UserController(context))
    ..route('/category/[:id]').link(() => CategoryController(context))
    ..route('post/[:id]').link(() => PostController(context))
    ..route('token/[:refresh]').link(() => MyAuthController(context));

  PersistentStore _initDatabase() {
    final username = Platform.environment['DB_USERNAME'] ?? 'postgres';
    final password = Platform.environment['DB_PASSWORD'] ?? '333';
    final host = Platform.environment['DB_HOST'] ?? '172.19.0.2';
    final port = int.parse(Platform.environment['DB_PORT'] ?? '5432');
    final databaseName = Platform.environment['DB_NAME'] ?? 'Conduit';
    return PostgreSQLPersistentStore(
        username, password, host, port, databaseName);
  }
}