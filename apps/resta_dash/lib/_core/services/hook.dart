import 'package:resta_dash/main.export.dart';

void useDelayedEffect(Function() effect, [Duration? duration, List<Object?>? keys]) {
  useEffect(() {
    Future.delayed(duration ?? Duration.zero, effect);
    return null;
  }, keys);
}
