import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';

import '../../presentation/views/main_wrapper_screen.dart';

part 'app_router.gr.dart';

//! Use the [watch] flag to watch the files' system for edits and rebuild as necessary.
/// flutter packages pub run build_runner watch
//! if you want the generator to run one time and exit, use
/// flutter packages pub run build_runner build

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    // add your routes here
    AutoRoute(
      page: MainWrapperRoute.page,
      initial: true,
      path: '/main',
    ),
  ];
}

final appRouter = AppRouter();