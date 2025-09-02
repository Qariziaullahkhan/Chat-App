import 'package:chat_app/core/enums/enums.dart';
import 'package:chat_app/core/services/auth_services.dart';
import 'package:chat_app/core/services/database_services.dart';
import 'package:chat_app/ui/screens/home/homeview_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final String uid;
  const HomeScreen({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeviewModel(DatabaseServices(), uid),
      child: Consumer<HomeviewModel>(
        builder: (context, model, _) {
          if (model.state == ViewState.loading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (model.currentuser == null) {
            return const Scaffold(
              body: Center(
                child: Text("User data not found"),
              ),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text("Home"),
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    AuthService().logout();
                  },
                ),
              ],
            ),
            body: Center(
              child: Text(
                "Welcome, ${model.currentuser!.name}", // assuming UserModel has a `name` field
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
