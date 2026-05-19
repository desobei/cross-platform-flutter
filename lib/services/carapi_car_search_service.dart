import 'dart:convert';

import 'package:http/http.dart' as http;

import '../data/car_store_repository.dart';
import '../models/car_store_models.dart';

class CarApiCarSearchService {
  CarApiCarSearchService({required String apiToken, http.Client? httpClient})
    : _apiToken = apiToken,
      _httpClient = httpClient ?? http.Client();

  static final _vinPattern = RegExp(r'^[A-HJ-NPR-Z0-9]{17}$');

  final String _apiToken;
  final http.Client _httpClient;

  Future<List<CarListing>> queryCars(String query) async {
    final normalized = query.trim();

    if (_apiToken.isNotEmpty &&
        _vinPattern.hasMatch(normalized.toUpperCase())) {
      final apiMatches = await _queryVin(normalized.toUpperCase());
      if (apiMatches.isNotEmpty) {
        return apiMatches;
      }
    }

    return _queryLocalListings(normalized);
  }

  Future<List<CarListing>> _queryVin(String vin) async {
    final uri = Uri.https('api.carapi.dev', '/v1/vin-decode/$vin', {
      'token': _apiToken,
    });

    try {
      final response = await _httpClient.get(uri);
      if (response.statusCode != 200) {
        return const <CarListing>[];
      }

      final decoded = jsonDecode(response.body);
      if (decoded is! Map<String, dynamic>) {
        return const <CarListing>[];
      }

      final specifications = decoded['specifications'];
      if (specifications is! Map<String, dynamic>) {
        return const <CarListing>[];
      }

      return _listingsMatchingApiSpecs(specifications);
    } catch (_) {
      return const <CarListing>[];
    }
  }

  List<CarListing> _listingsMatchingApiSpecs(Map<String, dynamic> specs) {
    final make = specs['make']?.toString().toLowerCase();
    final model = specs['model']?.toString().toLowerCase();

    if (make == null && model == null) {
      return const <CarListing>[];
    }

    return CarStoreRepository.listings
        .where((car) {
          final carMake = car.make.toLowerCase();
          final carModel = car.model.toLowerCase();

          if (make != null && carMake.contains(make)) {
            return true;
          }

          if (model != null && carModel.contains(model)) {
            return true;
          }

          return false;
        })
        .toList(growable: false);
  }

  List<CarListing> _queryLocalListings(String query) {
    final normalized = query.toLowerCase();
    return CarStoreRepository.listings
        .where((car) {
          final haystack = [
            car.title,
            car.highlight,
            car.description,
            car.drivetrain,
            car.transmission,
            ...car.colors,
          ].join(' ').toLowerCase();
          return haystack.contains(normalized);
        })
        .toList(growable: false);
  }
}
