import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:workmanagerexample/core/components/main_layout.dart';
import 'package:workmanagerexample/core/services/notification_service.dart';
import 'package:workmanagerexample/features/water/data/repositories/water_consumption_sqlite_repository_impl.dart';
import 'package:workmanagerexample/features/water/presentation/providers/water_consumption_provider.dart';
import 'package:workmanagerexample/features/water/presentation/providers/water_history_provider.dart';
import 'features/water/domain/repositories/water_consumption_repository.dart';
import 'features/profile/data/repositories/user_profile_repository_impl.dart';
import 'features/profile/domain/repositories/user_profile_repository.dart';
import 'features/profile/presentation/providers/user_profile_provider.dart';
import 'core/database/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final dbHelper = await DatabaseHelper.instance.database;

  // Initialize notification service
  await NotificationService().initialize();
  await NotificationService().showWaterReminder();

  runApp(MyApp(prefs: prefs, dbHelper: dbHelper));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  final Database dbHelper;

  const MyApp({super.key, required this.prefs, required this.dbHelper});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            // Using SQLite implementation
            final WaterConsumptionRepository repository =
                WaterConsumptionSqliteRepositoryImpl(dbHelper);
            final provider = WaterConsumptionProvider(repository);
            provider.loadConsumption();
            return provider;
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            // Using SQLite implementation
            final WaterConsumptionRepository repository =
                WaterConsumptionSqliteRepositoryImpl(dbHelper);
            final provider = WaterHistoryProvider(repository);
            provider.loadHistory();
            // provider.loadConsumption();
            return provider;
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            final UserProfileRepository repository = UserProfileRepositoryImpl(
              prefs,
            );
            final WaterConsumptionRepository waterConsumptionRepository =
                WaterConsumptionSqliteRepositoryImpl(dbHelper);
            final provider = UserProfileProvider(
              repository,
              waterConsumptionRepository,
            );
            provider.loadProfile();
            return provider;
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: const MainLayout(),
      ),
    );
  }
}
