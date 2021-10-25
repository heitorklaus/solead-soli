import 'package:login/app/shared/repositories/entities/plants_list.dart';
import 'package:login/app/shared/repositories/entities/powerPlantsOnline.dart';

abstract class IPlantsRepository {
  Future getAllLeads();
  Future getLeadSelected(val);
  Future updateLead(body);
  Future deleteLead(val);
}
