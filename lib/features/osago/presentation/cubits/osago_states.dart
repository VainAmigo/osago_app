

import '../../domain/entities/osago.dart';

abstract class OsagoStates {}

// initial
class OsagoInitial extends OsagoStates {}

//loading
class OsagoLoading extends OsagoStates {}

// uploading
class OsagoUploading extends OsagoStates{}

// uploaded
class OsagoUploaded extends OsagoStates{}

class OsagoCheckResult extends OsagoStates {
  final bool hasActiveOsago;

  OsagoCheckResult({required this.hasActiveOsago});
}


// error
class OsagoError extends OsagoStates {
  final String message;
  OsagoError(this.message);
}

//loaded
class OsagoLoaded extends OsagoStates {
  final List<Osago> osago;
  OsagoLoaded(this.osago);
}

// for every one states
class PeriodSate extends OsagoStates{}