import 'package:flutter/material.dart';
import 'package:kiddocare/utils/routes.dart';
import 'package:provider/provider.dart';
import 'providers/kindergarten_provider.dart';
import 'screens/listing_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => KindergartenProvider(),
      child: MaterialApp(
        routes: AppRoutes.getRoutes(),
        title: 'Kiddocare',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const ListingScreen(),
      ),
    );
  }
}
