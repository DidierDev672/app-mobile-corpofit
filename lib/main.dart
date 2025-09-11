import 'dart:developer';
import 'dart:io';

import 'package:corpofit_mobile/activity_work/infrastructure/services/local_activity_work_service.dart';
import 'package:corpofit_mobile/anamnesis/infrastructure/services/local_basic_data_service.dart';
import 'package:corpofit_mobile/anamnesis/infrastructure/services/local_discomfort_when_exercise_service.dart';
import 'package:corpofit_mobile/anamnesis/infrastructure/services/local_medication_user_service.dart';
import 'package:corpofit_mobile/config/constante/enviroment.dart';
import 'package:corpofit_mobile/config/route/app_router.dart';
import 'package:corpofit_mobile/config/theme/app_theme.dart';
import 'package:corpofit_mobile/leisure/infrastructure/services/local_leisure_service.dart';
import 'package:corpofit_mobile/physical_activity_questionnaire/insfrastructure/services/local_Injuries_or_pathology_service.dart';
import 'package:corpofit_mobile/physical_exercise/infrastructure/services/local_physical_exercise.dart';
import 'package:corpofit_mobile/sports_activity/infrastructure/services/local_sports_activity_service.dart';
import 'package:corpofit_mobile/utils/infrastructure/services/key_value_storage_servie_impl.dart';
import 'package:corpofit_mobile/utils/widgets/error_app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'physical_condition/infrastructure/infrastructure.dart';

class InitializationService {
  static bool _isInitialized = false;
  static Future<void>? _initilizationFuture;

  static Future<void> initialize() async {
    if (_isInitialized) return;
    if (_initilizationFuture != null) return _initilizationFuture;

    _initilizationFuture = _performInitialization();
    await _initilizationFuture;
    _isInitialized = true;
  }

  static Future<void> _performInitialization() async {
    if (kDebugMode) {
      Timeline.startSync('LocalServices_Init');
    }

    try {
      final storage = KeyValueStorageServiceImpl();
      await Future.wait([
        storage.initialize(),
        LocalBasicDataService.init(),
        LocalMedicationUserService.init(),
        LocalDiscomfortWhenExerciseService.init(),
        LocalInjuriesOrPathologyService.init(),
        LocalActivityWorkService.init(),
        LocalSportsActivityService.init(),
        LocalLeisureService.init(),
        LocalPhysicalExercise.init(),
        LocalAntropometryService.init(),
        LocalPhysicalTestService.init(),
        LocalClinicalScreeningService.init(),
      ]);

      if (kDebugMode) {
        print('✅ Todos los servicios locales inicializados correctamente');
      }
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print('❌ Error al inicializar servicios: $error');
        print('Stack trace: $stackTrace');
      }
      rethrow;
    } finally {
      if (kDebugMode) {
        Timeline.finishSync();
      }
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    debugPrint('🔄 Forzando modo de renderizado OpenGL ES');
    debugPrint('🔄 OpenGL ES mode is not explicitly configurable. Skipping.');
  }

  if (kDebugMode) {
    Timeline.startSync('main');
  }

  try {
    await Environment.initEnvironment();
    await InitializationService.initialize();

    runApp(const ProviderScope(child: MyApp()));
  } catch (error, stackTrace) {
    if (kDebugMode) {
      print('❌ Error crítico durante inicialización: $error');
      print('Stack trace: $stackTrace');
    }

    runApp(
      MaterialApp(
        home: ErrorApp(message: error.toString()),
        debugShowCheckedModeBanner: false,
      ),
    );
  } finally {
    if (kDebugMode) {
      Timeline.finishSync();
    }
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      routerConfig: appRouter,
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// class MyApp extends ConsumerStatefulWidget {
//   const MyApp({super.key});

//   @override
//   ConsumerState<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends ConsumerState<MyApp> {
//   @override
//   void initState() {
//     super.initState();
//     // Ensure initialization is complete before building the app
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (!InitializationService._isInitialized) {
//         // If not initialized, try to initialize and rebuild
//         InitializationService.initialize().then((_) {
//           if (mounted) setState(() {});
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final router = ref.watch(goRouterProvider);

//     if (!InitializationService._isInitialized) {
//       return const MaterialApp(
//         home: Scaffold(body: Center(child: LoadingApp())),
//         debugShowCheckedModeBanner: false,
//       );
//     }

//     return MaterialApp.router(
//       routerConfig: router,
//       theme: _buildDarkTheme(),
//       darkTheme: _buildLightTheme(),
//       themeMode: ThemeMode.system,
//       debugShowCheckedModeBanner: false,
//       title: 'Corpofit',

//       builder: (context, child) {
//         return MediaQuery(
//           data: MediaQuery.of(context).copyWith(
//             textScaler: TextScaler.linear(
//               MediaQuery.of(context).textScaler.scale(1.0).clamp(0.8, 1.2),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//   }

//   ThemeData _buildLightTheme() {
//     return ThemeData(
//       useMaterial3: true,
//       colorScheme: ColorScheme.fromSeed(
//         seedColor: Colors.blue,
//         brightness: Brightness.light,
//       ),

//       visualDensity: VisualDensity.adaptivePlatformDensity,

//       pageTransitionsTheme: const PageTransitionsTheme(
//         builders: {
//           TargetPlatform.android: CupertinoPageTransitionsBuilder(),
//           TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
//         },
//       ),

//       appBarTheme: const AppBarTheme(
//         centerTitle: true,
//         elevation: 0,
//         scrolledUnderElevation: 1,
//       ),

//       cardTheme: CardThemeData(
//         elevation: 2,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//     );
//   }

//   ThemeData _buildDarkTheme() {
//     return ThemeData(
//       useMaterial3: true,
//       colorScheme: ColorScheme.fromSeed(
//         seedColor: Colors.blue,
//         brightness: Brightness.dark,
//       ),
//       visualDensity: VisualDensity.adaptivePlatformDensity,

//       pageTransitionsTheme: const PageTransitionsTheme(
//         builders: {
//           TargetPlatform.android: CupertinoPageTransitionsBuilder(),
//           TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
//         },
//       ),

//       appBarTheme: const AppBarTheme(
//         centerTitle: true,
//         elevation: 0,
//         scrolledUnderElevation: 1,
//       ),

//       cardTheme: CardThemeData(
//         elevation: 2,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//     );
//   }
// }
