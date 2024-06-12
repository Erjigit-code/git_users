import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:t_z_rabota/blocs/user_event.dart';
import 'package:t_z_rabota/blocs/user_state.dart';
import 'package:t_z_rabota/generated/locale_keys.g.dart';
import 'package:t_z_rabota/repositories/user_repository.dart';
import 'package:t_z_rabota/service/connectivity_service.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  final ConnectivityService connectivityService;

  UserBloc({required this.userRepository, required this.connectivityService})
      : super(UserInitial()) {
    on<FetchUsers>((event, emit) async {
      emit(UserLoading());
      bool isConnected = await connectivityService.checkConnectivity();

      try {
        final users = await userRepository.fetchUsers();
        emit(UserLoaded(users));
      } catch (e) {
        if (isConnected) {
          Fluttertoast.showToast(
            msg: LocaleKeys.no_internet_connection.tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
        emit(UserError(LocaleKeys.Error_while_receiving_data.tr()));
      }
    });
  }
}
