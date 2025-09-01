// import 'package:chat_app/core/enums/enums.dart';
// import 'package:chat_app/core/services/auth_services.dart';
// import 'package:chat_app/core/services/database_services.dart';
// import 'package:chat_app/ui/screens/home/homeview_model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class HomeScreen extends StatelessWidget {
//   final String uid;
//   const HomeScreen({super.key,required this.uid});

//   // In your HomeScreen widget
// @override
// Widget build(BuildContext context) {
//   return ChangeNotifierProvider(
//     create: (context) => HomeviewModel(DatabaseServices(), uid),
//     child: Consumer<HomeviewModel>(builder: (context, model, _) {
//       return Scaffold(
//         body: model.state == ViewState.loading
//           ? const CircularProgressIndicator()
//           : model.currentuser == null
//             ? const Center(child: Text("User data not found"))
//             : Center(
//                 child: InkWell(
//                   onTap: () {
//                     AuthService().logout();
//                   },
//                   child: Text(model.currentuser.toString()),
//                 ),
//               ),
//       );
//     }),
//   );
// }
// }