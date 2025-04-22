// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:osago_bloc_app/features/osago/presentation/pages/osago_types_page.dart';
// import 'package:osago_bloc_app/features/osago/presentation/pages/period_selector_page.dart';
// import 'package:osago_bloc_app/features/tunduc/presentation/pages/person_doc_info_page.dart';
//
// import '../../../auth/domain/entities/app_user.dart';
// import '../../../auth/presentation/cubits/auth_cubit.dart';
// import '../../../cars/domain/entities/car.dart';
//
// class MyInfoPage extends StatefulWidget {
//   final String osagoType;
//   final Car car;
//   final String polisOwnerName;
//
//   const MyInfoPage({
//     super.key,
//     required this.osagoType,
//     required this.car, required this.polisOwnerName,
//   });
//
//   @override
//   State<MyInfoPage> createState() => _MyInfoPageState();
// }
//
// class _MyInfoPageState extends State<MyInfoPage> {
//   late final authCubit = context.read<AuthCubit>();
//
//   late AppUser? currentUser = authCubit.currentUser;
//
//   @override
//   Widget build(BuildContext context) {
//     return PersonDocInfo(
//         onPress: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => PeriodSelectorPage(
//                 car: widget.car,
//                 osagoType: widget.osagoType,
//                 carOwnerName: '',
//                 polisOwnerName: '',
//               ),
//             ),
//           );
//         },
//         inn: currentUser!.inn, polisOwnerName: '',);
//   }
// }
