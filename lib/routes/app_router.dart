import 'package:go_router/go_router.dart';
import 'package:riverpod_learn/screen/autodispose/counter_autodispose_page.dart';
import 'package:riverpod_learn/screen/team_search.dart';

import '../screen/autodispose/index_page.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const IndexPage()),
    GoRoute(path: '/counter', builder: (context, state) => const CounterAutodisposePage()),
    GoRoute(path: '/team_search', builder: (context, state) => const TeamSearch()),
  ],
);

