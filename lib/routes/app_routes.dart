part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const DASHBOARD = _Paths.DASHBOARD;
  static const LOGIN = _Paths.LOGIN;
  static const REGISTER = _Paths.REGISTER;
}

abstract class _Paths {
  static const DASHBOARD = '/dashboard';
  static const LOGIN = '/login';
  static const REGISTER = '/register';
}
