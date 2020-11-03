import 'package:login/app/shared/repositories/entities/plants_list.dart';

abstract class IPlantsRepository {
  Future getAllLeads();
  Future getLeadSelected(val);
}
