import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/enum/message_filters.dart';
import '../../../presentation/message/bloc/message_bloc.dart';
import '../../../presentation/message/widgets/filter_message_toggle_widget.dart';
import '../../../presentation/message/widgets/message_history.dart';
import '../../../presentation/widgets/future_resolve.dart';
import '../../../service_locator.dart';

class MessageListPage extends StatefulWidget {
  const MessageListPage({Key? key}) : super(key: key);

  @override
  State<MessageListPage> createState() => _MessageListPageState();
}

class _MessageListPageState extends State<MessageListPage> {
  final ValueNotifier<FilterMessage> valueNotifier =
      ValueNotifier<FilterMessage>(FilterMessage.daily);

  @override
  Widget build(BuildContext context) {
    return FutureResolve<MessageBloc>(
        future: locator.getAsync<MessageBloc>(),
        builder: (value) {
          final MessageBloc messageBloc = value;
          return BlocProvider(
            create: (context) => messageBloc,
            child: BlocBuilder(
              bloc: messageBloc,
              builder: (context, state) {
                return Scaffold(
                  appBar: AppBar(
                    elevation: 0.0,
                    automaticallyImplyLeading: true,
                    title: const Text('Messages'),
                    actions: [
                      IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (cxt) {
                                return AlertDialog(
                                  buttonPadding: EdgeInsets.zero,
                                  actionsPadding: const EdgeInsets.only(
                                      right: 20, bottom: 15),
                                  title: const Text('IMPORTANT NOTICE'),
                                  content: const SingleChildScrollView(
                                    child:
                                        Text('Do you want to delete all data?'),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.transparent,
                                        elevation: 0.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                      ),
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(cxt).pop();
                                      },
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0.0,
                                        primary: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 40,
                                        ),
                                      ),
                                      onPressed: () {
                                        context
                                            .read<MessageBloc>()
                                            .add(ClearAllMessageEvent());
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        'Delete',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.delete))
                    ],
                  ),
                  body: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        FilterMessageToggleWidget(valueNotifier: valueNotifier),
                        MessageHistory(valueNotifier: valueNotifier)
                      ]),
                );
              },
            ),
          );
        });
  }
}
