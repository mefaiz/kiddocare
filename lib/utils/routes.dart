import 'package:flutter/material.dart';
import 'package:kiddocare/screens/detail_screen.dart';
import 'package:kiddocare/screens/listing_screen.dart';

class AppRoutes {

  static const String listingScreen = '/listing';
  static const String detailScreen = '/detail';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      listingScreen: (BuildContext context) => const ListingScreen(),
      detailScreen: (BuildContext context) {
        // pass arguments here when to reuse this route
        final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
        return DetailScreen(kindergartenId: args?["kindergartenId"] ?? 0);
      },
    };
  }
}
