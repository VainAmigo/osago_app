import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:osago_bloc_app/features/tunduc/domain/entities/person_doc.dart';
import 'package:osago_bloc_app/features/tunduc/domain/repo/person_docRepo.dart';

class FirebasePersonDocRepo implements PersonDocRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final CollectionReference personDocCollection =
      FirebaseFirestore.instance.collection('tunduc');

  @override
  Future<PersonDoc> fetchDocByInn(String inn) async {
    try {
      final personDocSnapshot =
          await personDocCollection.where('inn', isEqualTo: inn).get();

      final personDoc = personDocSnapshot.docs
          .map((doc) => PersonDoc.fromJson(doc.data() as Map<String, dynamic>))
          .first;

      return personDoc;
    } catch (e) {
      throw Exception('Error to fetch perosn doc by id $e');
    }
  }

  // @override
  // Future<PersonDoc> fetchDocByInn(String inn) async {
  //   try {
  //     final docSnapshot = await personDocCollection.doc(inn).get();
  //
  //     if (docSnapshot.exists) {
  //       return PersonDoc.fromJson(docSnapshot.data() as Map<String, dynamic>);
  //     } else {
  //       throw Exception('Документ с ИНН $inn не найден');
  //     }
  //   } catch (e) {
  //     throw Exception('Ошибка при получении документа по ИНН: $e');
  //   }
  // }
}
