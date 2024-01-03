import 'package:go_router/go_router.dart';
import '../todo/view/home.dart';

final router = GoRouter(routes: [
  GoRoute(path: '/', redirect: (context, state) => '/home'),
  GoRoute(path: '/home', builder: (context, state) => const Home())
]);
