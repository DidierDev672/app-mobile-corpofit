import 'package:corpofit_mobile/anamnesis/presentation/screens/anamnesis_screen.dart';
import 'package:corpofit_mobile/auth/presentation/provider/auth_provider.dart';
import 'package:corpofit_mobile/auth/presentation/screens/check_auth_status_screen.dart';
import 'package:corpofit_mobile/auth/presentation/screens/register_screen.dart';
import 'package:corpofit_mobile/physical_activity_questionnaire/presentation/widgets/summary_injuries_or_pathologies_widgets.dart';
import 'package:corpofit_mobile/screens/home_screen.dart';
import 'package:corpofit_mobile/screens/login_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../activity_work/activity_work.dart';
import '../../eating_habits_questionnaire/eating_habits_questionnaire.dart';
import '../../leisure/leisure.dart';
import '../../physical_activity_questionnaire/presentation/screens/screens.dart';
import '../../physical_condition/physical_condition.dart';
import '../../physical_exercise/physical_exercise.dart';
import '../../sports_activity/presentation/screens/screens.dart';
import 'app_router_notifier.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: goRouterNotifier,
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => HomeScreen(onThemeChanged: (value) {}),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/anamnesis',
        builder: (context, state) => const AnamnesisScreen(),
      ),
      GoRoute(
        path: '/physical_activity_questionnaire',
        builder:
            (context, state) => const PhysicalActivityQuestionnaireScreen(),
      ),

      GoRoute(
        path: '/injuries_or_pathologies',
        builder: (context, state) => const InjuriesOrPathologiesScreen(),
      ),
      GoRoute(
        path: '/summary_injuries_or_pathologies',
        builder: (context, state) => const SummaryInjuriesOrPathologiesWidget(),
      ),
      GoRoute(
        path: '/activity_work',
        builder: (context, state) => const ActivityWorkScreen(),
      ),

      GoRoute(
        path: '/summary_activity_work',
        builder: (context, state) => const SummaryActivityWorkScreen(),
      ),

      GoRoute(
        path: '/sports_activity',
        builder: (context, state) => const SportsActivityScreen(),
      ),
      GoRoute(
        path: '/summary_sports_activity',
        builder: (context, state) => const SummarySportsActivityScreen(),
      ),
      GoRoute(
        path: '/leisure',
        builder: (context, state) => const LeisureScreen(),
      ),
      GoRoute(
        path: '/summary_leisure',
        builder: (context, state) => const SummaryLeisureScreen(),
      ),
      GoRoute(
        path: '/physical_exercise',
        builder: (context, state) => const PhysicalExerciseScreen(),
      ),
      GoRoute(
        path: '/summary_physical_exercise',
        builder: (context, state) => const SummaryPhysicalExercise(),
      ),
      GoRoute(
        path: '/eating_habits_questionnaire',
        builder: (context, state) => const EatingHabitsQuestionnaireScreen(),
      ),

      GoRoute(
        path: '/physical_condition',
        builder: (context, state) => const PhysicalConditionScreen(),
      ),
      GoRoute(
        path: '/physical_test',
        builder: (context, state) => const PhysicalTestScreen(),
      ),
      GoRoute(
        path: '/anthropometry',
        builder: (context, state) => const AnthropometryScreen(),
      ),
      GoRoute(
        path: '/clinical_screening',
        builder: (context, state) => const ClinicalScreeningScreen(),
      ),

      GoRoute(
        path: '/summary_anthropometry',
        builder: (context, state) => const SummaryAnthropometryScreen(),
      ),

      GoRoute(
        path: '/summary_physical_test',
        builder: (context, state) => const SummaryPhysicalTestScreen(),
      ),

      GoRoute(
        path: '/summary_clinical_screening',
        builder: (context, state) => const SummaryClinicalScreeningScreen(),
      ),
    ],

    redirect: (context, state) {
      final container = ProviderScope.containerOf(context);
      final authStatus = container.read(authProvider);
      final isGoingTo = state.matchedLocation;

      print("🔄 isGoingTo: $isGoingTo");
      print("🔑 authStatus: ${authStatus.authStatus}");

      if (isGoingTo == '/splash' &&
          authStatus.authStatus == AuthStatus.checking)
        return null;

      if (authStatus.authStatus == AuthStatus.notAuthenticated) {
        if (isGoingTo == '/login' || isGoingTo == '/register') return null;

        return '/login';
      }

      if (authStatus.authStatus == AuthStatus.authenticated) {
        if (isGoingTo == '/login' ||
            isGoingTo == '/register' ||
            isGoingTo == '/splash') {
          return '/home';
        }
      }

      return null;
    },
  );
});
