import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:osago_bloc_app/features/home/components/my_botom_modal_sheet.dart';
import 'package:osago_bloc_app/features/home/osago_details_page.dart';
import 'package:osago_bloc_app/features/osago/presentation/cubits/osago_cubit.dart';
import 'package:osago_bloc_app/features/osago/presentation/cubits/osago_states.dart';
import 'package:osago_bloc_app/pdf_generator_page.dart';
import 'package:osago_bloc_app/save_and_open_pdf.dart';

import '../../common/localization/language_constants.dart';
import '../auth/domain/entities/app_user.dart';
import '../auth/presentation/cubits/auth_cubit.dart';
import 'components/polis_card_date_block.dart';
import 'components/polis_card_status.dart';

class PolisScreen extends StatefulWidget {
  const PolisScreen({super.key});

  @override
  State<PolisScreen> createState() => _PolisScreenState();
}

class _PolisScreenState extends State<PolisScreen> {
  late final osagoCubit = context.read<OsagoCubit>();
  late final authCubit = context.read<AuthCubit>();

  late AppUser? currentUser = authCubit.currentUser;

  @override
  void initState() {
    super.initState();
    fetchUserOsago();
  }

  void getCurrentUser() async {
    final authCubit = context.read()<AuthCubit>();
    currentUser = authCubit.currentUser;
  }

  void fetchUserOsago() {
    osagoCubit.fetchUserOsago(currentUser!.inn);
  }

  // bottom sheet open button pressed
  void _createOsagoButtonPressed() {
    showModalBottomSheet(
        context: context, builder: (context) => MyBottomModalSheet());
  }

  // date time parser
  String _dateTimeParser(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat("dd.MM.yyyy").format(dateTime);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                final simplePdfFile = await SimplePdfApi.generateSimpleTextPdf(
                    'My text text', 'Second text');
                SaveAndOpenDocument.openPdf(simplePdfFile);
              },
              icon: Icon(Icons.picture_as_pdf))
        ],
        title: Text(
          translation(context).homeScreenTitle,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
            color: Theme
                .of(context)
                .colorScheme
                .tertiary,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _createOsagoButtonPressed();
        },
        foregroundColor: Colors.white,
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .primary,
        label: Text(translation(context).homeScreenApplyPolicy),
        icon: const Icon(Icons.add),
      ),
      body: BlocBuilder<OsagoCubit, OsagoStates>(builder: (context, state) {
        // loading
        if (state is OsagoLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // loaded
        else if (state is OsagoLoaded) {
          final allOsago = state.osago;

          if (allOsago.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      translation(context).homeScreenEmptyText,
                      style: TextStyle(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .secondary,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ListView.builder(
              itemCount: allOsago.length,
              itemBuilder: (context, index) {
                // get user osago
                final osago = allOsago[index];

                return InkWell(
                  onTap: () {
                    print(osago.status);
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => OsagoDetailsPage(osago: osago)));
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 8),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                      color: Theme
                          .of(context)
                          .colorScheme
                          .inversePrimary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        //   cart top
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //   auto number
                            Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Theme
                                        .of(context)
                                        .colorScheme
                                        .surface,
                                    border: Border.all(
                                        color: Theme
                                            .of(context)
                                            .colorScheme
                                            .secondary,
                                        width: 1.0),
                                  ),
                                  child: Icon(
                                    Icons.car_crash_outlined,
                                    color: Theme
                                        .of(context)
                                        .colorScheme
                                        .primary,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  osago.carPlate,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Theme
                                        .of(context)
                                        .colorScheme
                                        .tertiary,
                                  ),
                                ),
                              ],
                            ),

                            //   card status
                            StatusMark(
                              isActive: osago.status,
                            ),
                          ],
                        ),

                        Divider(
                          height: 20,
                          color: Theme
                              .of(context)
                              .colorScheme
                              .onSecondary,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),

                        Column(
                          children: <Widget>[
                            DateBlock(
                                text: translation(context)
                                    .homeScreenPolisCardDateStart,
                                dateText:
                                _dateTimeParser(osago.startDate.toString())),
                            const SizedBox(height: 5),
                            DateBlock(
                                text: translation(context)
                                    .homeScreenPolisCardDateEnd,
                                dateText:
                                _dateTimeParser(osago.endDate.toString()))
                          ],
                        ),

                        //   cart bottom
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }

        // error
        else if (state is OsagoError) {
          return Center(child: Text(state.message));
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
