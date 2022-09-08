import 'package:booking_app/blocs/booking_time/booking_time_cubit.dart';
import 'package:booking_app/shared/methods/register_services.dart';
import 'package:booking_app/ui/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/authentication/authentication_cubit.dart';
import 'network/services/navigation_service.dart';
import 'ui/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  registerServices();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AuthenticationCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => BookingTimeCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Booking',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: const LoginScreen(),
        navigatorKey: NavigationService.navigatorKey,
        initialRoute: '/login',
        routes: {
          '/login': (BuildContext context) => const LoginScreen(),
          '/home': (BuildContext context) => HomeScreen(),
          // '/admin': (BuildContext context) => const AdminPage(),
        },
      ),
    );
  }
}
