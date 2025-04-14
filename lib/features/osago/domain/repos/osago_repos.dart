import '../entities/osago.dart';

abstract class OsagoRepo {
  Future<List<Osago>> fetchUserOsago(String userId);
  Future<void> createOsago(Osago osago);
  Future<bool> fetchOsagoByGovPlate(String govPlate);
}