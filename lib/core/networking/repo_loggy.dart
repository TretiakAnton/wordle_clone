import 'package:loggy/loggy.dart';

mixin RepoLoggy implements LoggyType {
  @override
  Loggy<RepoLoggy> get loggy => Loggy<RepoLoggy>('Rest Loggy - $runtimeType');
}