import 'package:go_router/go_router.dart';
import 'package:todo/todo/view/add.dart';
import '../todo/view/home.dart';
import '../todo/view/edit.dart';

final router = GoRouter(routes: [
  GoRoute(path: '/', redirect: (context, state) => '/home'),
  GoRoute(path: '/home', builder: (context, state) => const Home()),
  GoRoute(path: '/add', builder: (context, state) => const AddTodo()),
  GoRoute(path: '/edit', builder: (context, state) => const EditTodo())
]);
