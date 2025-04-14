import 'package:osago_bloc_app/features/tunduc/domain/entities/person_doc.dart';

abstract class PersonDocRepo {

  // Future<List<PersonDoc>> fetchDocByInn (String inn);
  Future<PersonDoc> fetchDocByInn (String inn);
}
