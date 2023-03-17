import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';

import '../../app/routes.dart';
import '../../core/constants.dart';
import '../../core/enum/box_types.dart';
import '../../service_locator.dart';

class ServerUrlPage extends StatelessWidget {
  ServerUrlPage({Key? key}) : super(key: key);

  final _nameController = TextEditingController();
  final _formState = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      key: const Key('server_name_page_view'),
      valueListenable: locator
          .get<Box<dynamic>>(instanceName: BoxType.settings.stringValue)
          .listenable(
        keys: [serverNameKey],
      ),
      builder: (context, value, _) {
        return Scaffold(
          key: const Key('server_name_scaffold'),
          resizeToAvoidBottomInset: true,
          body: Align(
            alignment: Alignment.center,
            child: SafeArea(
              child: FractionallySizedBox(
                widthFactor: 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    Text('Server URL',
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                              letterSpacing: 0.8,
                            )),
                    const SizedBox(height: 6),
                    Text(
                      "Set the listening url",
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.75),
                            letterSpacing: 0.6,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Form(
                      key: _formState,
                      child: TextFormField(
                        key: const Key('user_name_textfield'),
                        controller: _nameController,
                        decoration: const InputDecoration(
                          hintText: "Server url",
                          label: Text("Url"),
                        ),
                        keyboardType: TextInputType.name,
                        validator: (val) {
                          if (val!.length >= 3) {
                            return null;
                          } else {
                            return "Enter valid url";
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              if (_formState.currentState!.validate()) {
                value
                    .put(serverNameKey, _nameController.text)
                    .then((value) => context.go(timeDurationPagePath));
              }
            },
            backgroundColor: Theme.of(context).colorScheme.primary,
            extendedPadding: const EdgeInsets.symmetric(horizontal: 24),
            label: const Icon(Icons.arrow_forward),
            icon: Text(
              "Next",
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
            ),
          ),
        );
      },
    );
  }
}
