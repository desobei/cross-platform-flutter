import 'dart:async';
import 'dart:io';

import 'package:cross_platform/app/car_store_app.dart';
import 'package:cross_platform/app/car_store_state.dart';
import 'package:cross_platform/data/car_store_local_repository.dart';
import 'package:cross_platform/data/car_store_repository.dart';
import 'package:cross_platform/database/car_store_database.dart';
import 'package:cross_platform/models/car_feedback.dart';
import 'package:cross_platform/models/car_store_models.dart';
import 'package:cross_platform/services/carapi_car_search_service.dart';
import 'package:cross_platform/services/cloud_car_features_service.dart';
import 'package:cross_platform/services/dealer_chat_service.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<SharedPreferences> freshPreferences() async {
    SharedPreferences.setMockInitialValues({});
    return SharedPreferences.getInstance();
  }

  Future<CarStoreApp> buildTestApp({
    RecordingCloudFeaturesService? cloudFeaturesService,
  }) async {
    final preferences = await freshPreferences();
    return CarStoreApp(
      sharedPreferences: preferences,
      searchService: CarApiCarSearchService(apiToken: ''),
      chatService: LocalDealerChatService(preferences: preferences),
      cloudFeaturesService:
          cloudFeaturesService ?? RecordingCloudFeaturesService(),
      localRepository: CarStoreLocalRepository.memoryFallback(),
    );
  }

  Future<void> closeWidgetTree(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpAndSettle();
  }

  testWidgets('CarStore shows login before entering the app', (tester) async {
    await tester.pumpWidget(await buildTestApp());
    await tester.pumpAndSettle();

    expect(
      find.text('Sign in to continue into your curated garage.'),
      findsOneWidget,
    );
    expect(find.text('Log in'), findsOneWidget);

    await closeWidgetTree(tester);
  });

  testWidgets('logging in opens discover screen', (tester) async {
    await tester.pumpWidget(await buildTestApp());
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, 'Log in'));
    await tester.pumpAndSettle();

    expect(find.text('Showrooms near me'), findsOneWidget);
    expect(find.text('Velocity EV House'), findsOneWidget);

    await closeWidgetTree(tester);
  });

  testWidgets('showroom detail page opens from discover screen', (tester) async {
    await tester.pumpWidget(await buildTestApp());
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, 'Log in'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Velocity EV House'));
    await tester.pumpAndSettle();

    expect(find.text('Velocity EV House'), findsWidgets);
    expect(find.text('Inventory'), findsOneWidget);

    await closeWidgetTree(tester);
  });

  testWidgets('search field returns local car results', (tester) async {
    await tester.pumpWidget(await buildTestApp());
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, 'Log in'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byType(TextField).first,
      'Tesla',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Search'));
    await tester.pumpAndSettle();

    expect(find.text('Search results'), findsOneWidget);
    expect(find.text('2025 Tesla Model S Plaid'), findsOneWidget);

    await closeWidgetTree(tester);
  });

  testWidgets('advisor tab is reachable from bottom navigation', (tester) async {
    await tester.pumpWidget(await buildTestApp());
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, 'Log in'));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.chat_bubble_outline_rounded).first);
    await tester.pumpAndSettle();

    expect(find.text('Advisor Chat'), findsWidgets);
    expect(
      find.text('Welcome back. Ask me about inventory, delivery, or financing.'),
      findsOneWidget,
    );

    await closeWidgetTree(tester);
  });

  test('search service matches make, model and drivetrain', () async {
    final searchService = CarApiCarSearchService(apiToken: '');

    final teslaResults = await searchService.queryCars('Tesla');
    expect(teslaResults.map((car) => car.id), contains('model-s-plaid'));

    final awdResults = await searchService.queryCars('AWD');
    expect(awdResults, isNotEmpty);
    expect(awdResults.every((car) => car.drivetrain.contains('AWD')), isTrue);
  });

  test('local chat saves user message and advisor auto-reply', () async {
    final preferences = await freshPreferences();
    final chatService = LocalDealerChatService(preferences: preferences);

    addTearDown(chatService.dispose);

    expect(await chatService.signIn('Alex Driver', ''), isNull);
    await chatService.sendMessage('Is the Model S available?');

    final messages = await chatService.watchMessages().first;

    expect(messages, hasLength(3));
    expect(messages[0].senderName, 'CarStore Advisor');
    expect(
      messages[0].text,
      'Got it. I can help with availability, financing, or delivery.',
    );
    expect(messages[1].senderName, 'Alex Driver');
    expect(messages[1].text, 'Is the Model S available?');
  });

  test('submitting an order saves it locally and syncs to cloud service', () async {
    final preferences = await freshPreferences();
    final cloudFeaturesService = RecordingCloudFeaturesService();
    final state = CarStoreState(
      preferences: preferences,
      searchService: CarApiCarSearchService(apiToken: ''),
      chatService: LocalDealerChatService(preferences: preferences),
      cloudFeaturesService: cloudFeaturesService,
      localRepository: CarStoreLocalRepository.memoryFallback(),
    );

    addTearDown(state.dispose);

    state.addReservation(
      CarStoreRepository.listings.first,
      'Signature package',
    );
    await state.submitOrder(
      customerName: 'Alex Driver',
      mode: ReservationMode.homeDelivery,
      pickupDateLabel: 'Date/time pending',
    );

    expect(state.orders, hasLength(1));
    expect(state.orders.single.customerName, 'Alex Driver');
    expect(cloudFeaturesService.savedOrders, hasLength(1));
    expect(cloudFeaturesService.savedOrders.single.id, state.orders.single.id);
  });

  test('favorite toggle syncs the Firebase favorite feature', () async {
    final preferences = await freshPreferences();
    final cloudFeaturesService = RecordingCloudFeaturesService();
    final state = CarStoreState(
      preferences: preferences,
      searchService: CarApiCarSearchService(apiToken: ''),
      chatService: LocalDealerChatService(preferences: preferences),
      cloudFeaturesService: cloudFeaturesService,
      localRepository: CarStoreLocalRepository.memoryFallback(),
    );

    addTearDown(state.dispose);

    final carId = CarStoreRepository.listings.first.id;
    state.toggleFavorite(carId);
    await Future<void>.delayed(const Duration(milliseconds: 10));
    state.toggleFavorite(carId);
    await Future<void>.delayed(const Duration(milliseconds: 10));

    expect(cloudFeaturesService.savedFavoriteCarIds, contains(carId));
    expect(cloudFeaturesService.deletedFavoriteCarIds, contains(carId));
  });

  test('Firebase feedback feature records and streams comments', () async {
    final cloudFeaturesService = RecordingCloudFeaturesService();
    final carId = CarStoreRepository.listings.first.id;

    await cloudFeaturesService.sendFeedback(
      carId: carId,
      text: 'Great cabin and fast charging.',
    );

    final feedback = await cloudFeaturesService.watchFeedback(carId).first;

    expect(feedback, hasLength(1));
    expect(feedback.single.carId, carId);
    expect(feedback.single.text, 'Great cabin and fast charging.');
  });

  test('repository writes submitted order to in-memory Drift database', () async {
    final database = CarStoreDatabase.memory();
    final localRepository = CarStoreLocalRepository(database);

    addTearDown(localRepository.close);

    final order = PurchaseOrder(
      id: 'ORD-TEST-1',
      customerName: 'Alex Driver',
      mode: ReservationMode.homeDelivery,
      pickupDateLabel: 'Date/time pending',
      items: [
        ReservationItem(
          car: CarStoreRepository.listings.first,
          packageName: 'Signature package',
        ),
      ],
      status: 'Preparing delivery',
    );

    await localRepository.saveOrder(order);
    final savedOrders = await localRepository.findOrders();

    expect(savedOrders, hasLength(1));
    expect(savedOrders.single.id, 'ORD-TEST-1');
    expect(savedOrders.single.items.single.packageName, 'Signature package');
  });

  test('orders persist after reopening file-backed Drift database', () async {
    final tempDir = await Directory.systemTemp.createTemp('car_store_test_');
    final dbFile = File('${tempDir.path}/car_store.sqlite');

    addTearDown(() async {
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    });

    final order = PurchaseOrder(
      id: 'ORD-PERSIST-1',
      customerName: 'Alex Driver',
      mode: ReservationMode.homeDelivery,
      pickupDateLabel: 'Date/time pending',
      items: [
        ReservationItem(
          car: CarStoreRepository.listings.first,
          packageName: 'Signature package',
        ),
      ],
      status: 'Preparing delivery',
    );

    final firstRepository = CarStoreLocalRepository(
      CarStoreDatabase(NativeDatabase(dbFile)),
    );
    await firstRepository.saveOrder(order);
    await firstRepository.close();

    final secondRepository = CarStoreLocalRepository(
      CarStoreDatabase(NativeDatabase(dbFile)),
    );
    addTearDown(secondRepository.close);

    final savedOrders = await secondRepository.findOrders();

    expect(savedOrders, hasLength(1));
    expect(savedOrders.single.id, 'ORD-PERSIST-1');
    expect(savedOrders.single.customerName, 'Alex Driver');
  });
}

class RecordingCloudFeaturesService extends CloudCarFeaturesService {
  final Set<String> savedFavoriteCarIds = <String>{};
  final Set<String> deletedFavoriteCarIds = <String>{};
  final List<PurchaseOrder> savedOrders = <PurchaseOrder>[];
  final Map<String, List<CarFeedback>> feedbackByCarId =
      <String, List<CarFeedback>>{};

  @override
  Future<void> saveFavoriteCar(String carId) async {
    savedFavoriteCarIds.add(carId);
  }

  @override
  Future<void> deleteFavoriteCar(String carId) async {
    deletedFavoriteCarIds.add(carId);
  }

  @override
  Future<void> saveOrder(PurchaseOrder order) async {
    savedOrders.add(order);
  }

  @override
  Stream<List<CarFeedback>> watchFeedback(String carId) async* {
    yield List<CarFeedback>.unmodifiable(
      feedbackByCarId[carId] ?? const <CarFeedback>[],
    );
  }

  @override
  Future<void> sendFeedback({required String carId, required String text}) async {
    feedbackByCarId.putIfAbsent(carId, () => <CarFeedback>[]).insert(
      0,
      CarFeedback(
        id: 'feedback-${feedbackByCarId.length}',
        carId: carId,
        text: text.trim(),
        driverName: 'Test Driver',
        userId: 'test-user',
        createdAt: DateTime(2026),
      ),
    );
  }
}
