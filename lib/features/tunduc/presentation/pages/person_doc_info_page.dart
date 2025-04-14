
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osago_bloc_app/common/localization/language_constants.dart';
import 'package:osago_bloc_app/features/tunduc/presentation/cubits/person_doc_states.dart';

import '../../../../common/components/my_button.dart';
import '../../../../common/components/top_text_block.dart';
import '../../../osago/presentation/components/info_tile.dart';
import '../cubits/person_doc_cubit.dart';

class PersonDocInfo extends StatefulWidget {
  final String inn;
  final Function()? onPress;

  const PersonDocInfo({
    super.key,
    required this.onPress,
    required this.inn,
  });

  @override
  State<PersonDocInfo> createState() => _PersonDocInfoState();
}

class _PersonDocInfoState extends State<PersonDocInfo> {
  late final personDocCubit = context.read<PersonDocCubit>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchPersonDoc();
  }

  void fetchPersonDoc() {
    if (widget.inn.isNotEmpty) {
      personDocCubit.fetchPersonDocByInn(widget.inn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: BlocBuilder<PersonDocCubit, PersonDocState>(
          builder: (context, state) {
            if (state is PersonDocLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PersonDocLoaded) {
              final personDocDoc = state.personDoc;
        
              if (personDocDoc == null) {
                return Center(child: Text(translation(context).personInfoNotData));
              }
        
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    topTextBlock(
                      title: translation(context).personInfoTopTitle,
                      text: translation(context).personInfoTopText,
                    ),
                    SizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InfoTile(title: translation(context).personInfoTilePin, content: personDocDoc.inn),
                          InfoTile(
                            title: translation(context).personInfoTileName,
                            content:
                                '${personDocDoc.firstName} ${personDocDoc.secondName}',
                          ),
                          InfoTile(
                            title: translation(context).personInfoTileDateOfBirth,
                            content: personDocDoc.dateOfBirthday,
                          ),
                          InfoTile(
                            title: translation(context).personInfoTileTypeOfDoc,
                            content: personDocDoc.docCategory,
                          ),
                          InfoTile(
                            title: translation(context).personInfoTileDateOfDoc,
                            content: personDocDoc.docDate,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: MyButton(
                        text: translation(context).buttonConfirm,
                        onPress: widget.onPress,
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is PersonDocError) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text(translation(context).personInfoNotData));
            }
          },
        ),
      ),
    );
  }
}
