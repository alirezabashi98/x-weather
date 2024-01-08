// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    DetailWeatherRoute.name: (routeData) {
      final args = routeData.argsAs<DetailWeatherRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DetailWeatherScreen(
          key: args.key,
          cityName: args.cityName,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const HomeScreen()),
      );
    },
  };
}

/// generated route for
/// [DetailWeatherScreen]
class DetailWeatherRoute extends PageRouteInfo<DetailWeatherRouteArgs> {
  DetailWeatherRoute({
    Key? key,
    required String cityName,
    List<PageRouteInfo>? children,
  }) : super(
          DetailWeatherRoute.name,
          args: DetailWeatherRouteArgs(
            key: key,
            cityName: cityName,
          ),
          initialChildren: children,
        );

  static const String name = 'DetailWeatherRoute';

  static const PageInfo<DetailWeatherRouteArgs> page =
      PageInfo<DetailWeatherRouteArgs>(name);
}

class DetailWeatherRouteArgs {
  const DetailWeatherRouteArgs({
    this.key,
    required this.cityName,
  });

  final Key? key;

  final String cityName;

  @override
  String toString() {
    return 'DetailWeatherRouteArgs{key: $key, cityName: $cityName}';
  }
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
