import 'package:sece_event_calendar/model/configmodel.dart';
import 'package:sece_event_calendar/service/api_interface.dart';
import 'package:sece_event_calendar/utils/sessions.dart';

import 'constants.dart';

class ConfigurationSession{
  static final ConfigurationSession _singleton = ConfigurationSession._internal();
  ConfigurationSession._internal();
  factory ConfigurationSession() {
    return _singleton;
  }

  List<ConfigModel?>? configList;

  List<String?> venue = [];

  Future<void> fetchDataFromConfig() async {
    Sessions().loaderOverRelay = true;
    configList = await ApiInterface().getConfigInfo().whenComplete((){
        populateConfigData();
    });
  }

  Future<void> populateConfigData() async{
    configList?.forEach((element) {
      switch(element?.key){
        case VENUE:
          venue = [];
          for (var value in element?.value??[]) {
            venue.add(value);
          }
      }
    });
  }

}
