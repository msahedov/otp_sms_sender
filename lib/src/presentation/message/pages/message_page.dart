import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/time_extensions.dart';
import '../../../data/message/model/message.dart';
import '../../../presentation/message/bloc/message_bloc.dart';
import '../../../presentation/widgets/future_resolve.dart';
import '../../../service_locator.dart';

class MessagePage extends StatefulWidget {
  final Message message;
  const MessagePage({Key? key, required this.message}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return FutureResolve<MessageBloc>(
        future: locator.getAsync<MessageBloc>(),
        builder: (value) {
          final MessageBloc messageBloc = value;
          return BlocProvider(
            create: (context) => messageBloc,
            child: BlocConsumer(
                bloc: messageBloc,
                listener: (context, state) {
                  if (state is MessageDeletedState) {}
                },
                builder: (context, state) {
                  return Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: SafeArea(
                      child: Material(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ListTile(
                              title: Text(
                                'Message Details',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                            MessageDetailField(
                                valueText: widget.message.recipient,
                                labelText: 'Phone'),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: MessageDetailField(
                                      valueText: widget.message.body,
                                      labelText: 'Password'),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: MessageDetailField(
                                      valueText: widget
                                          .message.timestamp.formattedDateFull,
                                      labelText: 'Time'),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: ElevatedButton(
                                onPressed: () {
                                  context.read<MessageBloc>().add(
                                      ClearMessageEvent(
                                          widget.message.superId!));
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size.fromWidth(
                                      MediaQuery.of(context).size.width - 48),
                                  padding: const EdgeInsets.all(16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32.0),
                                  ),
                                ),
                                child: Text(
                                  'Delete',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        ?.fontSize,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: OutlinedButton(
                                onPressed: () => Navigator.of(context).pop(),
                                style: OutlinedButton.styleFrom(
                                  fixedSize: Size.fromWidth(
                                      MediaQuery.of(context).size.width - 48),
                                  padding: const EdgeInsets.all(16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32.0),
                                  ),
                                ),
                                child: Text(
                                  'Close',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        ?.fontSize,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20)
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          );
        });
  }
}

class MessageDetailField extends StatelessWidget {
  final String valueText;
  final String labelText;
  const MessageDetailField(
      {Key? key, required this.valueText, required this.labelText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      child: TextFormField(
        enabled: false,
        initialValue: valueText,
        autocorrect: true,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.zero,
          ),
        ),
      ),
    );
  }
}
