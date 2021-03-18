

import 'package:get_it/get_it.dart';
import 'package:myhealthapp/providers/team_tile.dart';


GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton(TeamTile());
}