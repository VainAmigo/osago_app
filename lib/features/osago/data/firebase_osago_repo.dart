import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:osago_bloc_app/features/osago/domain/entities/osago.dart';
import 'package:osago_bloc_app/features/osago/domain/repos/osago_repos.dart';

class FirebaseOsagoRepo implements OsagoRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final CollectionReference osagoCollection = FirebaseFirestore.instance
      .collection('osago');

  @override
  Future<void> createOsago(Osago osago) async {
    try {
      await osagoCollection.doc(osago.id).set(osago.toJson());
    } catch (e) {
      throw UnimplementedError('Error create osago $e');
    }
  }


  @override
  Future<bool> fetchOsagoByGovPlate(String govPlate) async {
    try {
      final osagoByGovPlateSnapshot = await osagoCollection
          .where('carPlate', isEqualTo: govPlate)
          .where('status', isEqualTo: false)
          .get();

      return osagoByGovPlateSnapshot.docs.isNotEmpty;
    } catch (e) {
      throw Exception('Error fetching OSAGO by govPlate: $e');
    }
  }

  @override
  Future<List<Osago>> fetchUserOsago(String userId) async {
    try {
      final userOsagoSnapshot = await osagoCollection.where(
          'userId', isEqualTo: userId).get();

      final userOsago = userOsagoSnapshot.docs.map((doc) =>
          Osago.fromJson(doc.data() as Map<String, dynamic>)).toList();

      return userOsago;
    } catch (e) {
      throw Exception('Error fetching user Osago by user id: $e');
    }
  }


}