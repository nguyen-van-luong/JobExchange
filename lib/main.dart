import 'package:flutter/material.dart';
import 'package:job_exchange/ui/common/utils/jwt_interceptor.dart';
import 'package:job_exchange/ui/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadJwt(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        var isLoading = snapshot.connectionState != ConnectionState.done;
        return buildMaterialApp(isLoading: isLoading);
      },
    );
  }

  Future<void> loadJwt() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    await JwtInterceptor().parseJwt(accessToken, needToRefresh: true);
  }

  Widget buildMaterialApp({bool isLoading = false}) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light().copyWith(
          primary: Colors.indigoAccent,
        ),
      ),
      routerConfig: appRouter,
      builder: (context, child) {
        return isLoading
            ? const Center(child: CircularProgressIndicator())
            : child!;
      },
    );
  }
}