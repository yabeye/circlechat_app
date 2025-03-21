import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:circlechat_app/core/enums/theme_enum.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(selectedTheme: AppTheme.system));

  void setTheme(AppTheme theme) {
    emit(ThemeState(selectedTheme: theme));
  }
}
