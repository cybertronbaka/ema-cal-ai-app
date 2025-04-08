class CustomRoute {
  const CustomRoute({required this.name, required this.path});

  final String Function([Map<String, String>? args]) path;
  final String name;
}

abstract class Routes {
  static final CustomRoute authEntry = CustomRoute(
    name: 'authEntry',
    path: ([args]) => '/',
  );
}
