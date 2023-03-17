import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/enum/box_types.dart';
import 'core/enum/message_status.dart';
import 'data/message/data_sources/message_manager_local_data_source.dart';
import 'data/message/data_sources/message_manager_local_data_source_impl.dart';
import 'data/message/model/message.dart';
import 'data/message/repository/message_repository_impl.dart';
import 'domain/message/repository/message_repository.dart';
import 'domain/message/use_case/message_use_case.dart';
import 'presentation/message/bloc/message_bloc.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  await _setupHive();
  _localSources();
  _setupRepository();
  _setupUseCase();
  _setupBloc();
}

Future<void> _setupHive() async {
  await Hive.initFlutter();
  Hive
    ..registerAdapter(MessageAdapter())
    ..registerAdapter(MessageStatusAdapter());

  final messageBox = await Hive.openBox<Message>(BoxType.message.stringValue);
  locator.registerLazySingleton<Box<Message>>(() => messageBox);

  final boxDynamic = await Hive.openBox(BoxType.settings.stringValue);
  locator.registerLazySingleton<Box<dynamic>>(() => boxDynamic,
      instanceName: BoxType.settings.stringValue);
}

void _setupUseCase() {
  locator.registerLazySingletonAsync(
      () async => GetMessageUseCase(messageRepository: await locator.getAsync()));
  locator.registerLazySingletonAsync(
      () async => DeleteMessageUseCase(messageRepository: await locator.getAsync()));
  locator.registerLazySingletonAsync(
      () async => AddMessageUseCase(messageRepository: await locator.getAsync()));
  locator.registerLazySingletonAsync(
      () async => ClearAllMessageUseCase(messageRepository: await locator.getAsync()));
}

void _localSources() {
  locator.registerLazySingletonAsync<LocalMessageManagerDataSource>(
      () async => LocalMessageManagerDataSourceImpl(locator.get()));
}

void _setupRepository() {
  locator.registerLazySingletonAsync<MessageRepository>(
    () async => MessageRepositoryImpl(
      dataSource: await locator.getAsync<LocalMessageManagerDataSource>(),
    ),
  );
}

void _setupBloc() {
  locator.registerFactoryAsync(() async => MessageBloc(
      messageUseCase: await locator.getAsync(),
      addMessageUseCase: await locator.getAsync(),
      deleteMessageUseCase: await locator.getAsync(),
      clearAllMessageUseCase: await locator.getAsync()));
}
