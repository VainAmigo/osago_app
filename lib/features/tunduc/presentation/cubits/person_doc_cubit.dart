import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osago_bloc_app/features/tunduc/domain/repo/person_docRepo.dart';
import 'package:osago_bloc_app/features/tunduc/presentation/cubits/person_doc_states.dart';

class PersonDocCubit extends Cubit<PersonDocState> {
  final PersonDocRepo personDocRepo;

  PersonDocCubit({required this.personDocRepo}) : super(PersonDocInitial());

  Future<void> fetchPersonDocByInn(String inn) async {
    try {
      emit(PersonDocLoading());
      final personDoc = await personDocRepo.fetchDocByInn(inn);
      emit(PersonDocLoaded(personDoc));

    } catch (e) {
      emit(PersonDocError('Failed to fetch person doc (cubit) $e'));
    }
  }
  // Future<void> fetchPersonDocByInn(String inn) async {
  //   if (inn.isEmpty) {
  //     emit(PersonDocError('ИНН не может быть пустым'));
  //     return;
  //   }
  //
  //   emit(PersonDocLoading());
  //
  //   try {
  //     final personDoc = await personDocRepo.fetchDocByInn(inn);
  //     emit(PersonDocLoaded(personDoc));
  //   } catch (e) {
  //     emit(PersonDocError('Ошибка при получении данных: ${e.toString()}'));
  //   }
  // }
}
