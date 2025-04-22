import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osago_bloc_app/common/components/my_button.dart';
import 'package:osago_bloc_app/common/components/top_text_block.dart';
import 'package:osago_bloc_app/common/localization/language_constants.dart';
import 'package:osago_bloc_app/features/cars/presentation/pages/car_plate_page.dart';
import 'package:osago_bloc_app/features/tunduc/presentation/cubits/person_doc_cubit.dart';
import '../cubits/person_doc_states.dart';

class SearchPersonByInn extends StatefulWidget {
  const SearchPersonByInn({super.key});

  @override
  State<SearchPersonByInn> createState() => _SearchPersonByInnState();
}

class _SearchPersonByInnState extends State<SearchPersonByInn> {
  late final personDocCubit = context.read<PersonDocCubit>();

  final innController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    innController.dispose();
  }

  void fetchPersonDoc() {
    if (innController.text.length == 15) {
      personDocCubit.fetchPersonDocByInn(innController.text);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              topTextBlock(
                title: translation(context).searchPersonByInnTopTitle,
                text: translation(context).searchPersonByInnTopText,
              ),

              SizedBox(height: 24),

              // inn text field
              TextField(
                onChanged: (value) => fetchPersonDoc(),
                controller: innController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.onSecondary),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  label: Text(translation(context).searchPersonByInnInputLabel),
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  fillColor: Theme.of(context).colorScheme.inversePrimary,
                  filled: true,
                ),
              ),

              SizedBox(height: 24),

              BlocTextField(),

            ],
          ),
        ),
      ),
    );
  }
}

class BlocTextField extends StatelessWidget {
  const BlocTextField({
    super.key,
  });

  String maskName(String firstName, String secondName) {
    return '${firstName[0]}******* ${secondName[0]}*******';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonDocCubit, PersonDocState>(
      builder: (context, state) {
        if (state is PersonDocLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PersonDocLoaded) {
          final personDocDoc = state.personDoc;

          if (personDocDoc == null) {
            return Center(child: Text(translation(context).createOsagoModalSheetAnotherCar));
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      translation(context).searchPersonByInnPersonCardName,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    SizedBox(height: 2),
                    Text(
                      maskName(
                        personDocDoc.firstName,
                        personDocDoc.secondName,
                      ),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                    SizedBox(height: 25),
                    MyButton(
                      text: translation(context).buttonContinue,
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CarPlatePage(
                              inn: personDocDoc.inn,
                              carOwnerName: '${personDocDoc.firstName} ${personDocDoc.secondName}',
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        } else if (state is PersonDocError) {
          return Center(child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(translation(context).searchPersonByInnNotFoundText),
          ));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
