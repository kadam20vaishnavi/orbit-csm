
import 'package:http/http.dart';
import 'package:orbit_csm/networking/api_services.dart';
import 'package:orbit_csm/ui/OpenTasks/OpenTasksResModel.dart';

class OpenTasksRepo{

  final ApiServices apiServices = ApiServices();

  Future<OpentaskResModel> getOpenTasksListAPI(String intskst_id,String daysAgo,String startDate,String endDate,String token) async {
    return await apiServices.getOpenTasksList(intskst_id,daysAgo,startDate,endDate,token) as Future<OpentaskResModel>;
  }
}