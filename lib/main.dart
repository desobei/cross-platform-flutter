import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/car_store_app.dart';
import 'data/car_store_local_repository.dart';
import 'database/car_store_database.dart';
import 'firebase_options.dart';
import 'services/carapi_car_search_service.dart';
import 'services/cloud_car_features_service.dart';
import 'services/dealer_chat_service.dart';
import 'services/firebase_car_features_service.dart';
import 'services/firebase_dealer_chat_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const useFirebase = bool.fromEnvironment('USE_FIREBASE');
  final sharedPreferences = await SharedPreferences.getInstance();
  DealerChatService chatService = LocalDealerChatService(
    preferences: sharedPreferences,
  );
  CloudCarFeaturesService cloudFeaturesService = LocalCloudCarFeaturesService();

  if (useFirebase) {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      chatService = FirebaseDealerChatService();
      cloudFeaturesService = FirebaseCarFeaturesService();
    } catch (error) {
      debugPrint('Firebase was requested but could not initialize: $error');
    }
  }
  final localRepository = _openLocalRepository();
  const carApiToken = String.fromEnvironment('CARAPI_TOKEN');
  final searchService = CarApiCarSearchService(apiToken: carApiToken);
  runApp(
    CarStoreApp(
      sharedPreferences: sharedPreferences,
      searchService: searchService,
      chatService: chatService,
      cloudFeaturesService: cloudFeaturesService,
      localRepository: localRepository,
    ),
  );
}


CarStoreLocalRepository _openLocalRepository() {
  try {
    return CarStoreLocalRepository(CarStoreDatabase());
  } catch (error) {
    debugPrint('Local database could not start, using in-memory storage: $error');
    return CarStoreLocalRepository.memoryFallback();
  }
}
