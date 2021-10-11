import 'package:logger/logger.dart';

class AppLogger {
  AppLogger({String tag}) : tag = tag ?? 'Logger';

  final String tag;
  Logger logger = Logger(
    printer: PrettyPrinter(),
  );

  void d(dynamic log) {
    logger.d('D/$tag : $log');
  }

  void i(dynamic log) {
    logger.i('I/$tag : $log');
  }

  void w(dynamic log) {
    // ignore: avoid_print
    print(
      'W/$tag Warning ========================================================',
    );
    logger.w(log);
    // ignore: avoid_print
    print(
      '=======================================================================',
    );
  }

  void e(dynamic log) {
    // ignore: avoid_print
    print('E/$tag ----------------------Error----------------------');
    logger.e(log);
    // ignore: avoid_print
    print('---------------------------------------------------------');
  }
}
