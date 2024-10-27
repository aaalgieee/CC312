// lib/screens/home_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tla_1n2/providers/todo_provider.dart';
import 'package:tla_1n2/widgets/cupertino_progress_bar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _handleSubmit(String value) {
    if (value.isNotEmpty) {
      ref.read(todoProvider.notifier).addTodo(value);
      _textController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(todoProvider).todos;
    final completedTodos = todos.where((todo) => todo.isCompleted).length;

    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: const CupertinoNavigationBar(
        middle: Text('My Tasks'),
        backgroundColor: CupertinoColors.systemBackground,
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Progress Section
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: CupertinoColors.systemBackground,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: CupertinoColors.systemGrey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Progress',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: CupertinoColors.label.resolveFrom(context),
                        ),
                      ),
                      Text(
                        '$completedTodos/${todos.length} tasks',
                        style: TextStyle(
                          fontSize: 16,
                          color: CupertinoColors.secondaryLabel
                              .resolveFrom(context),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  CupertinoProgressBar(
                    value: todos.isEmpty ? 0 : completedTodos / todos.length,
                    backgroundColor: CupertinoColors.systemGrey5,
                    valueColor: CupertinoColors.activeBlue,
                    height: 8,
                  ),
                ],
              ),
            ),

            // Add Todo Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: CupertinoColors.systemBackground,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: CupertinoColors.systemGrey.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: CupertinoTextField(
                  controller: _textController,
                  padding: const EdgeInsets.all(16),
                  placeholder: 'Add a new task',
                  placeholderStyle: TextStyle(
                    color: CupertinoColors.placeholderText.resolveFrom(context),
                  ),
                  decoration: null,
                  onSubmitted: _handleSubmit,
                  suffix: CupertinoButton(
                    padding: const EdgeInsets.only(right: 16),
                    child: const Icon(
                      CupertinoIcons.add_circled_solid,
                      color: CupertinoColors.activeBlue,
                    ),
                    onPressed: () => _handleSubmit(_textController.text),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Tasks List
            Expanded(
              child: todos.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.check_mark_circled,
                            size: 64,
                            color: CupertinoColors.secondaryLabel
                                .resolveFrom(context),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No tasks yet',
                            style: TextStyle(
                              fontSize: 20,
                              color: CupertinoColors.secondaryLabel
                                  .resolveFrom(context),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: todos.length,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemBuilder: (context, index) {
                        final todo = todos[index];
                        return Dismissible(
                          key: Key(todo.id),
                          background: Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                              color: CupertinoColors.destructiveRed,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            child: const Icon(
                              CupertinoIcons.delete,
                              color: CupertinoColors.white,
                            ),
                          ),
                          onDismissed: (_) {
                            ref.read(todoProvider.notifier).removeTodo(todo.id);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                              color: CupertinoColors.systemBackground,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: CupertinoColors.systemGrey
                                      .withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: CupertinoListTile(
                              title: Text(
                                todo.title,
                                style: TextStyle(
                                  decoration: todo.isCompleted
                                      ? TextDecoration.lineThrough
                                      : null,
                                  color: todo.isCompleted
                                      ? CupertinoColors.secondaryLabel
                                          .resolveFrom(context)
                                      : CupertinoColors.label
                                          .resolveFrom(context),
                                ),
                              ),
                              trailing: CupertinoSwitch(
                                value: todo.isCompleted,
                                activeColor: CupertinoColors.activeGreen,
                                onChanged: (_) {
                                  ref
                                      .read(todoProvider.notifier)
                                      .toggleTodo(todo.id);
                                },
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
