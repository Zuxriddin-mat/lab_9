import 'package:flutter/material.dart';
import 'db_helper.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  User? user;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    final dbHelper = DBHelper();
    user = await dbHelper.getUserData();
    setState(
        () {}); // No need to check if user is not null as getUserData already does that
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            Text(
              'Username:',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 8.0),
            Text(user!.username, style: Theme.of(context).textTheme.bodyText1),
            const SizedBox(height: 20.0),
            Text(
              'Phone:',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 8.0),
            Text(user!.phone, style: Theme.of(context).textTheme.bodyText1),
            const SizedBox(height: 20.0),
            Text(
              'Email:',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 8.0),
            Text(user!.email, style: Theme.of(context).textTheme.bodyText1),
            const SizedBox(height: 20.0),
            Text(
              'Address:',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 8.0),
            Text(user!.address, style: Theme.of(context).textTheme.bodyText1),
          ],
        ),
      ),
    );
  }
}
