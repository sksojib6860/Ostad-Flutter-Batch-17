import 'package:flutter/material.dart';
import 'package:module_9_local_db/DB/database.dart';
import 'package:module_9_local_db/home/utils/alert_dialog_edit.dart';
import 'package:module_9_local_db/model/task_model.dart';

/// The main workspace screen of the task manager, featuring an elegant Material 3
/// interface, task completion progress, bulk deletion capabilities, and clean state handling.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Controller for the new task entry
  final TextEditingController _textController = TextEditingController();

  // List holding all tasks retrieved from the local database
  List<TaskModel> _tasks = [];

  // Tracks selection mode state
  bool _isSelectionMode = false;

  // Holds the IDs of tasks selected for bulk operations
  final Set<int> _selectedTaskIds = {};

  // Loading state to present an elegant skeleton/loader while fetching data
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  /// Fetches tasks from the SQLite database and updates the UI state.
  Future<void> _loadTasks() async {
    setState(() => _isLoading = true);
    try {
      final loadedTasks = await TaskDatabase.getTasks();
      setState(() {
        _tasks = loadedTasks;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      _showSnackBar('Failed to load tasks from local storage.', isError: true);
    }
  }

  /// Adds a new task to the database.
  Future<void> _addTask(String text) async {
    final cleanText = text.trim();
    if (cleanText.isEmpty) {
      _showSnackBar('Please enter a valid task description.', isError: true);
      return;
    }

    try {
      await TaskDatabase.insertTask(TaskModel(text: cleanText, isDone: false));
      _textController.clear();
      _loadTasks();
      _showSnackBar('Task added successfully!');
    } catch (e) {
      _showSnackBar('Failed to save task.', isError: true);
    }
  }

  /// Toggles the completion status of a single task.
  Future<void> _toggleTaskStatus(TaskModel task, bool? isDone) async {
    try {
      final updatedTask = task.copyWith(isDone: isDone ?? false);
      await TaskDatabase.updateTask(updatedTask);
      _loadTasks();
    } catch (e) {
      _showSnackBar('Failed to update task status.', isError: true);
    }
  }

  /// Renames a task description.
  Future<void> _updateTaskText(TaskModel task, String newText) async {
    try {
      final updatedTask = task.copyWith(text: newText);
      await TaskDatabase.updateTask(updatedTask);
      _loadTasks();
      _showSnackBar('Task updated successfully!');
    } catch (e) {
      _showSnackBar('Failed to update task.', isError: true);
    }
  }

  /// Deletes a single task with an elegant slide/fade animation or simple prompt confirmation.
  Future<void> _deleteTask(int id) async {
    try {
      await TaskDatabase.deleteTask(id);
      // Remove from selection set if it was selected
      _selectedTaskIds.remove(id);
      if (_selectedTaskIds.isEmpty) {
        _isSelectionMode = false;
      }
      _loadTasks();
      _showSnackBar('Task deleted.');
    } catch (e) {
      _showSnackBar('Failed to delete task.', isError: true);
    }
  }

  /// Deletes all selected tasks in a single database transaction.
  Future<void> _deleteSelectedTasks() async {
    if (_selectedTaskIds.isEmpty) return;

    final confirmed = await _showConfirmDeleteDialog(_selectedTaskIds.length);
    if (confirmed != true) return;

    try {
      await TaskDatabase.deleteTasks(_selectedTaskIds.toList());
      _showSnackBar('${_selectedTaskIds.length} tasks deleted successfully!');
      _selectedTaskIds.clear();
      _isSelectionMode = false;
      _loadTasks();
    } catch (e) {
      _showSnackBar('Failed to delete selected tasks.', isError: true);
    }
  }

  /// Toggles selection of a task. Activates selection mode if not already active.
  void _toggleSelection(int taskId) {
    setState(() {
      if (_selectedTaskIds.contains(taskId)) {
        _selectedTaskIds.remove(taskId);
        if (_selectedTaskIds.isEmpty) {
          _isSelectionMode = false;
        }
      } else {
        _selectedTaskIds.add(taskId);
        _isSelectionMode = true;
      }
    });
  }

  /// Selects or deselects all currently listed tasks.
  void _toggleSelectAll() {
    setState(() {
      if (_selectedTaskIds.length == _tasks.length) {
        _selectedTaskIds.clear();
        _isSelectionMode = false;
      } else {
        _selectedTaskIds.clear();
        for (final task in _tasks) {
          if (task.id != null) {
            _selectedTaskIds.add(task.id!);
          }
        }
        _isSelectionMode = true;
      }
    });
  }

  /// Cancels selection mode and clears selected list.
  void _exitSelectionMode() {
    setState(() {
      _selectedTaskIds.clear();
      _isSelectionMode = false;
    });
  }

  /// Helper to display snackbars with high visual distinction.
  void _showSnackBar(String message, {bool isError = false}) {
    final theme = Theme.of(context);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: isError
                ? theme.colorScheme.onError
                : theme.colorScheme.onInverseSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: isError
            ? theme.colorScheme.error
            : theme.colorScheme.inverseSurface,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// Confirmation dialog before executing destructive bulk operations.
  Future<bool?> _showConfirmDeleteDialog(int count) {
    final theme = Theme.of(context);
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: theme.colorScheme.error,
              size: 28,
            ),
            const SizedBox(width: 12),
            const Text('Delete Tasks?'),
          ],
        ),
        content: Text(
          'Are you sure you want to permanently delete $count selected task(s)? This action cannot be undone.',
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.error,
              foregroundColor: theme.colorScheme.onError,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Delete',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  /// Native Date Formatter that builds a warm greeting without depending on external libraries.
  String _getFormattedDate() {
    final now = DateTime.now();
    final weekdays = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
    ];
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    // Adjusting for DateTime weekday representation (1 = Monday, 7 = Sunday)
    final weekdayStr = weekdays[now.weekday % 7];
    final monthStr = months[now.month - 1];
    return '$weekdayStr, $monthStr ${now.day}';
  }

  /// Opens an elegant modal bottom sheet designed with smooth aesthetics and perfect keyboard spacing.
  void _openAddTaskBottomSheet() {
    final theme = Theme.of(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(28),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top drag-indicator bar
                Center(
                  child: Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onSurfaceVariant.withValues(
                        alpha: 0.3,
                      ),
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Icon(
                      Icons.add_task_rounded,
                      color: theme.colorScheme.primary,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Add New Task',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                TextFormField(
                  controller: _textController,
                  autofocus: true,
                  textCapitalization: TextCapitalization.sentences,
                  style: theme.textTheme.bodyLarge,
                  maxLines: 2,
                  minLines: 1,
                  maxLength: 150,
                  decoration: InputDecoration(
                    hintText: 'What needs to be done?',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    filled: true,
                    fillColor: theme.colorScheme.surfaceContainerHighest
                        .withValues(alpha: 0.3),
                    counterText:
                        '', // Keep clean layout without standard counters
                  ),
                  onFieldSubmitted: (value) {
                    Navigator.pop(context);
                    _addTask(value);
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          _textController.clear();
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          final text = _textController.text;
                          Navigator.pop(context);
                          _addTask(text);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: theme.colorScheme.onPrimary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Create Task',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                   ],
                 ),
                 SizedBox(height: MediaQuery.of(context).padding.bottom + 20),
               ],
             ),
           ),
         );
       },
     );
   }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final completedCount = _tasks.where((t) => t.isDone).length;
    final totalCount = _tasks.length;
    final double completionRatio = totalCount == 0
        ? 0
        : completedCount / totalCount;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Dynamic Professional Header (changes on Selection Mode)
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: _isSelectionMode
                  ? _buildSelectionHeader()
                  : _buildStandardHeader(
                      completedCount,
                      totalCount,
                      completionRatio,
                    ),
            ),

            // Task List or Loading / Empty States
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _tasks.isEmpty
                  ? _buildEmptyState()
                  : _buildTaskList(),
            ),
          ],
        ),
      ),
      // Sleek Floating Action Button for Adding Tasks
      floatingActionButton: _isSelectionMode
          ? null
          : FloatingActionButton.extended(
              onPressed: _openAddTaskBottomSheet,
              icon: const Icon(Icons.add, size: 24),
              label: const Text(
                'Add Task',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              elevation: 4,
            ),
    );
  }

  /// Builds the standard elegant workspace header with task completion statistics.
  Widget _buildStandardHeader(int completed, int total, double ratio) {
    final theme = Theme.of(context);
    return Container(
      key: const ValueKey('standard_header'),
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getFormattedDate(),
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant.withValues(
                        alpha: 0.8,
                      ),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Workspace',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
              // App logo or avatar placeholder
              CircleAvatar(
                radius: 24,
                backgroundColor: theme.colorScheme.primary.withValues(
                  alpha: 0.1,
                ),
                child: Icon(
                  Icons.playlist_add_check_rounded,
                  color: theme.colorScheme.primary,
                  size: 28,
                ),
              ),
            ],
          ),
          if (total > 0) ...[
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Task Progress',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      Text(
                        '$completed of $total completed',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: ratio,
                      minHeight: 8,
                      backgroundColor: theme.colorScheme.primary.withValues(
                        alpha: 0.15,
                      ),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Builds the selection header when item(s) are selected for bulk action.
  Widget _buildSelectionHeader() {
    final theme = Theme.of(context);
    final count = _selectedTaskIds.length;
    final isAllSelected = count == _tasks.length;

    return Container(
      key: const ValueKey('selection_header'),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: _exitSelectionMode,
            icon: Icon(
              Icons.close_rounded,
              color: theme.colorScheme.onPrimaryContainer,
            ),
            tooltip: 'Cancel Selection',
          ),
          const SizedBox(width: 12),
          Text(
            '$count Selected',
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          // Toggle select/deselect all
          IconButton(
            onPressed: _toggleSelectAll,
            icon: Icon(
              isAllSelected ? Icons.deselect_rounded : Icons.select_all_rounded,
              color: theme.colorScheme.onPrimaryContainer,
            ),
            tooltip: isAllSelected ? 'Deselect All' : 'Select All',
          ),
          // Delete selected items
          IconButton(
            onPressed: _deleteSelectedTasks,
            icon: Icon(
              Icons.delete_sweep_rounded,
              color: theme.colorScheme.error,
            ),
            tooltip: 'Delete Selected Tasks',
          ),
        ],
      ),
    );
  }

  /// Builds a gorgeous empty state widget when there are no tasks in the list.
  Widget _buildEmptyState() {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.task_alt_rounded,
              size: 72,
              color: theme.colorScheme.primary.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'All Caught Up!',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'No tasks found. Tap the button below to add your first task and stay productive!',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the modern task card list with support for standard list operations and bulk select.
  Widget _buildTaskList() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
      itemCount: _tasks.length,
      itemBuilder: (context, index) {
        final task = _tasks[index];
        final isSelected = _selectedTaskIds.contains(task.id);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(bottom: 12),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                if (_isSelectionMode) {
                  _toggleSelection(task.id!);
                } else {
                  _toggleTaskStatus(task, !task.isDone);
                }
              },
              onLongPress: () {
                if (!_isSelectionMode && task.id != null) {
                  _toggleSelection(task.id!);
                }
              },
              borderRadius: BorderRadius.circular(16),
              child: Card(
                elevation: isSelected ? 2 : 0.5,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(
                            context,
                          ).colorScheme.outlineVariant.withValues(alpha: 0.5),
                    width: isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                color: isSelected
                    ? Theme.of(
                        context,
                      ).colorScheme.primaryContainer.withValues(alpha: 0.2)
                    : task.isDone
                    ? Theme.of(context).colorScheme.surfaceContainerHighest
                          .withValues(alpha: 0.4)
                    : Theme.of(context).colorScheme.surface,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: Row(
                    children: [
                      // Leading Element (Selection Checkbox vs Status Checkbox)
                      _isSelectionMode
                          ? Checkbox(
                              value: isSelected,
                              activeColor: Theme.of(
                                context,
                              ).colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              onChanged: (_) => _toggleSelection(task.id!),
                            )
                          : Checkbox(
                              value: task.isDone,
                              activeColor: Theme.of(
                                context,
                              ).colorScheme.primary,
                              shape: const CircleBorder(),
                              onChanged: (val) => _toggleTaskStatus(task, val),
                            ),

                      // Task Description
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 12,
                          ),
                          child: Text(
                            task.text,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  decoration: task.isDone
                                      ? TextDecoration.lineThrough
                                      : null,
                                  color: task.isDone
                                      ? Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant
                                            .withValues(alpha: 0.5)
                                      : Theme.of(context).colorScheme.onSurface,
                                  fontWeight: task.isDone
                                      ? FontWeight.normal
                                      : FontWeight.w500,
                                ),
                          ),
                        ),
                      ),

                      // Trailing Actions (Only visible in normal mode)
                      if (!_isSelectionMode)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () async {
                                final String? newText =
                                    await showDialog<String>(
                                      context: context,
                                      builder: (context) => EditTaskDialog(
                                        initialText: task.text,
                                      ),
                                    );
                                if (newText != null &&
                                    newText.isNotEmpty &&
                                    newText != task.text) {
                                  _updateTaskText(task, newText);
                                }
                              },
                              icon: const Icon(Icons.edit_outlined),
                              color: Colors.amber.shade700,
                              tooltip: 'Edit Task',
                            ),
                            IconButton(
                              onPressed: () => _deleteTask(task.id!),
                              icon: const Icon(Icons.delete_outline_rounded),
                              color: Theme.of(context).colorScheme.error,
                              tooltip: 'Delete Task',
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
