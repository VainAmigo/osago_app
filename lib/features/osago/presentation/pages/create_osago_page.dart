import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osago_bloc_app/common/components/my_button.dart';
import 'package:osago_bloc_app/common/localization/language_constants.dart';
import 'package:osago_bloc_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:osago_bloc_app/features/home/home_page.dart';
import 'package:osago_bloc_app/features/osago/presentation/cubits/osago_cubit.dart';
import 'package:osago_bloc_app/features/osago/presentation/cubits/osago_states.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import '../../../auth/domain/entities/app_user.dart';
import '../../domain/entities/osago.dart';

class CreateOsagoPage extends StatefulWidget {
  final String carPlate;
  final int periodOfPolis;
  final String costOfOsago;
  final String osagoType;

  const CreateOsagoPage({
    super.key,
    required this.carPlate,
    required this.periodOfPolis,
    required this.costOfOsago,
    required this.osagoType,
  });

  @override
  State<CreateOsagoPage> createState() => _CreateOsagoPageState();
}

class _CreateOsagoPageState extends State<CreateOsagoPage> {
  AppUser? currentUser;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;


  void userTappedPay() {
    if (formKey.currentState!.validate()) {
      // only show dialog if form is valid
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(translation(context).createOsagoAlertTitle),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('${translation(context).createOsagoCardNumber} $cardNumber'),
                Text('${translation(context).createOsagoExpiryDate} $expiryDate'),
                Text('${translation(context).createOsagoCardHolderName} $cardHolderName'),
                Text('${translation(context).createOsagoCvv} $cvvCode'),
              ],
            ),
          ),
          actions: [
            // cancel button
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(translation(context).createOsagoAlertCancel),
            ),

            TextButton(
              onPressed: uploadOsago,
              child: Text(translation(context).createOsagoAlertYes),
            ),
          ],
        ),
      );
    }
  }

  void getCurrentUser() async {
    final authCubit = context.read<AuthCubit>();
    currentUser = authCubit.currentUser;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void uploadOsago() {
    final osagoCubit = context.read<OsagoCubit>();

    final DateTime endDate = DateTime.now().add(Duration(days: widget.periodOfPolis));
    // create new osago
    final newOsago = Osago(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: currentUser!.inn,
      carPlate: widget.carPlate,
      costOfOsago: widget.costOfOsago,
      osagoType: widget.osagoType,
      startDate: DateTime.now(),
      endDate: endDate,
      status: true,
    );

    osagoCubit.createOsago(newOsago);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OsagoCubit, OsagoStates>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                // credit card
                CreditCardWidget(
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  showBackView: isCvvFocused,
                  onCreditCardWidgetChange: (p0) {},
                ),

                // credit card form
                CreditCardForm(
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  onCreditCardModelChange: (data) {
                    setState(() {
                      cardNumber = data.cardNumber;
                      expiryDate = data.expiryDate;
                      cardHolderName = data.cardHolderName;
                      cvvCode = data.cvvCode;
                    });
                  },
                  formKey: formKey,
                ),

                const Spacer(),

                MyButton(text: translation(context).buttonContinue, onPress: () => userTappedPay(),),


                const SizedBox(height: 25),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is OsagoUploaded) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
            (route) => false,
          );
        }
      },
    );
  }
}
