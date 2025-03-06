
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:orbit_csm/ui/OpenTasks/OpenTasksRepo.dart';
import 'package:orbit_csm/ui/OpenTasks/OpenTasksResModel.dart';

class OpenTasksViewModel extends ChangeNotifier {

  final OpenTasksRepo _openTasksRepo = OpenTasksRepo();
  String intskst_id = "1001";

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  final String _successMessage = '';
  String get successMessage => _successMessage;

  String _selectedFilter = 'Last 7 days';
  String get selectedFilter => _selectedFilter;

  List<TaskItem> _tasks = []; // List of tasks
  List<TaskItem> get tasks => _tasks;

  List<OpentaskResModel> _cartList = [];
  List<OpentaskResModel> get cartList => _cartList;

  //List<TaskItem> _tasks = List.generate(10, (index) => TaskItem.dummy(index)); // Dummy data

  void updateFilter(String newFilter) {
    _selectedFilter = newFilter;
    notifyListeners(); // ✅ This will trigger UI updates automatically
  }

  Future<void> getOpenTasksApi(String intskst_id, String daysAgo, String startDate, String endDate, String token) async {

    print("In Open Task Api:StartDate$intskst_id,$daysAgo,$startDate,$endDate,$token");
    _isLoading = true;
    _errorMessage = "";
    notifyListeners();

    if (startDate.isEmpty && endDate.isEmpty) {
      print("In Open IF Task Api");
      _errorMessage = "Please select Start and End date";
    } else {
      print("In Open Else Task Api:$intskst_id ,$daysAgo ,$startDate, $endDate, $token");
      /*try {*/
        final response = await _openTasksRepo.getOpenTasksListAPI(intskst_id, daysAgo, startDate, endDate, token);

        print("Response getOpenTask: $response");
      /*} on DioException catch (e) {
        if (e.type == DioExceptionType.connectionTimeout) {
          _errorMessage = "The server is taking too long to respond. Please try again later.";
        } else {
          _errorMessage = "API call failed: ${e.message}";
        }
        print("Dio Error: $_errorMessage");
      } catch (e) {
        _errorMessage = "Unexpected error: $e";
        print("Error: $_errorMessage");
      }*/
    }
    _isLoading = false;
    notifyListeners();
  }
}