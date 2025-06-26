import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_test/presentation/provider/todo_provider.dart';
import 'data/todo_repository.dart';
import 'presentation/screens/todo_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final repository = TodoRepo();
  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final TodoRepo repository;
  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoProvider(repository)),
      ],
      child: MaterialApp(
        title: 'ToDo test App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        ),
        home: const TodoPage(),
      ),
    );
  }
}
