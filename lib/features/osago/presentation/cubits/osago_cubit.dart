import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osago_bloc_app/features/osago/domain/repos/osago_repos.dart';

import '../../domain/entities/osago.dart';
import 'osago_states.dart';

class OsagoCubit extends Cubit<OsagoStates> {
  final OsagoRepo osagoRepo;

  OsagoCubit({
    required this.osagoRepo,
  }) : super(OsagoInitial());

  // fetch user osago
  Future<void> fetchUserOsago(String userId) async {
    try {
      emit(OsagoLoading());
      final osago = await osagoRepo.fetchUserOsago(userId);
      emit(OsagoLoaded(osago));
    } catch (e) {
      emit(
          OsagoError('Failed to fetch user osago by user is (cubit page): $e'));
    }
  }

  //
  // Future<void> checkOsagoByGovPlate(String govPlate) async {
  //   try {
  //     emit(OsagoLoading());
  //     final hasActiveOsago = await osagoRepo.fetchOsagoByGovPlate(govPlate);
  //     emit(OsagoCheckResult(hasActiveOsago: hasActiveOsago));
  //   } catch (e) {
  //     emit(OsagoError('Error checking OSAGO by govPlate: $e'));
  //   }
  // }

  Future<bool> checkOsagoByGovPlate(String govPlate) async {
    try {
      emit(OsagoLoading());
      final hasActiveOsago = await osagoRepo.fetchOsagoByGovPlate(govPlate);
      emit(OsagoCheckResult(hasActiveOsago: hasActiveOsago));
      return hasActiveOsago;
    } catch (e) {
      emit(OsagoError('Error checking OSAGO by govPlate: $e'));
      return true;
    }
  }


  Future<void> createOsago(Osago osago) async {
    try {
      final newOsago = osago.copyWith();
      await osagoRepo.createOsago(newOsago);
      emit(OsagoUploaded());
    } catch (e) {
      emit(OsagoError('Failed to create new polis: $e'));
    }
  }
}
