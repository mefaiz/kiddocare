import 'dart:developer';

import 'package:flutter/foundation.dart';
import '../services/api_service.dart';
import '../models/kindergarten.dart';

class KindergartenProvider with ChangeNotifier {

  final ApiService _apiService = ApiService();
  bool _isLoading = false;
  String _error = '';

  int _currentPage = 1;
  int _perPage = 10;

  List<Kindergarten> _allKindergartens = [];
  String _searchQuery = '';

  // the getters and setters
  bool get isLoading => _isLoading;
  String get error => _error;
  List<Kindergarten> get kindergartens => _searchQuery.isEmpty 
    ? _allKindergartens 
    : _allKindergartens.where((k) => 
        k.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        k.city.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        k.state.toLowerCase().contains(_searchQuery.toLowerCase())
      ).toList();
  int get currentPage => _currentPage;
  int get perPage => _perPage;
  set currentPage(int page) => _currentPage = page;
  set perPage(int page) => _perPage = page;


  // fetch list of kindergartens
  Future<void> fetchKindergartens({
    required int currentPage,
    required int perPage,
  }) async {
    if (_isLoading) return;
    
    setLoading(true);
    log('currentPage: $currentPage --> perPage: $perPage');
    try {
      // delay for 2 seconds - to show the loading indicator
      await Future.delayed(const Duration(seconds: 2));
      final response = await _apiService.getKindergartens(
        page: _currentPage,
        perPage: _perPage,
      );


      if (_currentPage == 1) {
        _allKindergartens.clear();
      }
      
      // if there are kindergartens, add to the list
      if (response.isNotEmpty) {
        _allKindergartens.addAll(response);
        _currentPage++;
      }

      setLoading(false);
      notifyListeners();
      
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // kindergarten details
  Future<Kindergarten?> getKindergartenDetails(int id) async {
    try {
      final kindergarten = await _apiService.getKindergartenDetails(id);
      _error = '';
      return kindergarten;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return null;
    }
  }

  // to set the loading state
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // search kindergartens
  void searchKindergartens(String query) {
    _searchQuery = query;
    notifyListeners();
  }

} 