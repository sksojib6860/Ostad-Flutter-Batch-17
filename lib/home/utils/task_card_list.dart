import 'package:flutter/material.dart';

class TaskCardList extends StatelessWidget {
  const TaskCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        final listStatus = [
          'New',
          'In Progress',
          'Completed',
          'Canceled',
          'New',
        ];
        final listColors = [
          Colors.blue,
          Colors.orange,
          Colors.green,
          Colors.red,
          Colors.blue,
        ];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 0.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            leading: CircleAvatar(
              backgroundColor: listColors[index].withOpacity(0.1),
              child: Icon(Icons.assignment_outlined, color: listColors[index]),
            ),
            title: Text(
              'Task ${index + 1}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                const Text(
                  'Develop task management dashboard layout.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: listColors[index].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    listStatus[index],
                    style: TextStyle(
                      color: listColors[index],
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Colors.grey,
            ),
          ),
        );
      },
    );
  }
}
