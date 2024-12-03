import 'package:voterseye/feature/auth/auth.dart';
import 'package:voterseye/screens/dashboard/screen.dart';
import 'package:voterseye/screens/launch.dart';
import 'package:voterseye/screens/signup/signup.dart';
import 'package:voterseye/screens/welcome.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  debugLogDiagnostics: true,
  refreshListenable: authChangeNotifier,
  routes: [
    // the root route
    LaunchScreen.navigation.route,
    WelcomeScreen.navigation.route,
    SignupScreen.navigation.route,
    DashboardScreen.navigation.route,
  ],
);
