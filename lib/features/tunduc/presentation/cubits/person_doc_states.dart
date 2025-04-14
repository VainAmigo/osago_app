import '../../domain/entities/person_doc.dart';

abstract class PersonDocState {}

//initial
class PersonDocInitial extends PersonDocState {}

// loading
class PersonDocLoading extends PersonDocState {}



// error
class PersonDocError extends PersonDocState {
  final String message;
  PersonDocError(this.message);
}

// Loaded
class PersonDocLoaded extends PersonDocState {
  final PersonDoc personDoc;
  PersonDocLoaded(this.personDoc);
}

// Loaded
// class PersonDocLoaded extends PersonDocState {
//   final List<PersonDoc> personDoc;
//   PersonDocLoaded(this.personDoc);
// }