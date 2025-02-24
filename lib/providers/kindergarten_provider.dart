import 'package:flutter/foundation.dart';
import '../services/api_service.dart';
import '../models/kindergarten.dart';

class KindergartenProvider with ChangeNotifier {

  final ApiService _apiService = ApiService();
  final List<Kindergarten> _kindergartens = [];
  bool _isLoading = false;
  String _error = '';

  int _currentPage = 1;
  int _perPage = 10;
  bool _hasMoreData = true;

  // the getters and setters
  bool get isLoading => _isLoading;
  String get error => _error;
  List<Kindergarten> get kindergartens => _kindergartens;
  bool get hasMoreData => _hasMoreData;
  int get currentPage => _currentPage;
  set currentPage(int page) => _currentPage = page;

  // fetch list of kindergartens
  Future<void> fetchKindergartens() async {
    if (_isLoading) return;
    
    setLoading(true);
    try {
      // delay for 2 seconds - to show the loading indicator
      await Future.delayed(const Duration(seconds: 2));
      final response = await _apiService.getKindergartens(
        page: _currentPage,
        perPage: _perPage,
      );

      if (_currentPage == 1) {
        _kindergartens.clear();
      }
      
      if (response.isNotEmpty) {
        _kindergartens.addAll(response);
        _hasMoreData = response.length >= _perPage;
        _currentPage++;
      } else {
        _hasMoreData = false;
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

} 