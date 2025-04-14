import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osago_bloc_app/common/localization/language_constants.dart';
import 'package:osago_bloc_app/features/tunduc/presentation/cubits/person_doc_cubit.dart';

import '../../auth/domain/entities/app_user.dart';
import '../../auth/presentation/cubits/auth_cubit.dart';
import '../../tunduc/presentation/cubits/person_doc_states.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  late final personDocCubit = context.read<PersonDocCubit>();

  late final authCubit = context.read<AuthCubit>();
  late AppUser? currentUser = authCubit.currentUser;

  void fetchPersonDoc() {
    personDocCubit.fetchPersonDocByInn(currentUser!.inn);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPersonDoc();
  }

  @override
  Widget build(BuildContext context) {
    String maskName(String firstName, String secondName) {
      return '${firstName[0]}******* ${secondName[0]}*******';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          translation(context).settingsPersonalDataAppBarTitle,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<PersonDocCubit, PersonDocState>(
          builder: (context, state) {
            if (state is PersonDocLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PersonDocLoaded) {
              final personDocDoc = state.personDoc;

              if (personDocDoc == null) {
                return Center(child: Text(translation(context).settingsPersonalDataInfoNotFound));
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            translation(context).settingsPersonalDataInputPin,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            personDocDoc.inn,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.tertiary),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFFE9ECF2),
                        ),
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            translation(context).settingsPersonalDataInputName,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            maskName(
                              personDocDoc.firstName,
                              personDocDoc.secondName,
                            ),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is PersonDocError) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text(translation(context).settingsPersonalDataInfoNotFound));
            }
          },
        ),
      ),
    );
  }
}
