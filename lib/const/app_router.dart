import 'package:chatapp/presentation/views/chatPage.dart';
import 'package:chatapp/presentation/views/login_page.dart';
import 'package:chatapp/presentation/views/register_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const String login = '/';
  static const String register = '/registerView';
  static const String chat = '/chatView';
  static final routers = GoRouter(
    routes: [
      GoRoute(path: login, builder: (context, state) => loginView()),
      GoRoute(path: register, builder: (context, state) => registerView()),
      GoRoute(
        path: chat,
        builder: (context, state) {
          final email = state.extra;
          return chatView(email: email as String);
        },
      ),
    ],
  );
}
