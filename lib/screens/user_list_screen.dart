import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_z_rabota/blocs/user_bloc.dart';
import 'package:t_z_rabota/blocs/user_state.dart';
import 'package:t_z_rabota/generated/locale_keys.g.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({super.key});

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        backgroundColor: Colors.yellowAccent,
        leading: IconButton(
          onPressed: () {
            showLanguageDialog();
          },
          icon: const Icon(Icons.language),
        ),
        title: Text(LocaleKeys.users_list.tr()),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserLoaded) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                return makeCard(context, user);
              },
            );
          } else if (state is UserError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }

  Widget makeListTile(BuildContext context, dynamic user) => ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: Color.fromRGBO(61, 66, 81, 1),
                      padding: const EdgeInsets.all(10.0),
                      child: Image.network(user['avatar_url']),
                    ),
                  ),
                );
              },
            );
          },
          child: Container(
            padding: const EdgeInsets.only(right: 12.0),
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(width: 1.0, color: Colors.yellowAccent),
              ),
            ),
            child: Image.network(user['avatar_url'], width: 50, height: 50),
          ),
        ),
        title: Text(
          user['login'],
          style: const TextStyle(
              color: Colors.yellowAccent, fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: <Widget>[
            const Icon(Icons.people, color: Colors.greenAccent),
            Text(" ${LocaleKeys.followers.tr()}: ${user['followers']}",
                style: const TextStyle(color: Colors.greenAccent)),
            const SizedBox(width: 10),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(context, '/userDetail', arguments: user);
        },
      );

  Widget makeCard(BuildContext context, dynamic user) => Card(
        elevation: 8.0,
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration:
              const BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
          child: makeListTile(context, user),
        ),
      );

  void showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('🇺🇸 English'),
                onTap: () {
                  context.setLocale(const Locale('en'));
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('🇷🇺 Russian'),
                onTap: () {
                  context.setLocale(const Locale('ru'));
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
