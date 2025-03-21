import 'package:circlechat_app/services/logging_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/locator.dart';

class AppObserver extends BlocObserver {
  AppObserver()
      : _logger = getIt<LoggingService>(),
        super();

  final LoggingService _logger;

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    _logger.debug('${bloc.runtimeType} $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    _logger.debug('${bloc.runtimeType} $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    _logger.debug('${bloc.runtimeType} $error $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}
