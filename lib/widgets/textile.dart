import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_flow/models/task.dart';
import 'package:task_flow/providers/taskprovider.dart';

class Textile extends StatefulWidget {
  final String id;
  const Textile({super.key, required this.id});

  @override
  State<Textile> createState() => _TextileState();
}

class _TextileState extends State<Textile> {
  @override
  Widget build(BuildContext context) {
    return Selector<Taskprovider, Task>(
      selector: (_, provider) => provider.getTaskById(widget.id),
      builder: (context, tasks, child) {
      
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(width: 1.5, color: Colors.white),
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: Slidable(
              endActionPane: ActionPane(
                motion: StretchMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) async {
                      try {
                         context.read<Taskprovider>().deleteTask(tasks);
                      } catch (e) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    },
                    icon: Icons.delete_forever,
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ],
              ),
              child: ListTile(
                leading: Checkbox(
                  value: tasks.completed,
                  onChanged: (value) async {
                    Task updateTask= tasks.copyWith(
                      completed: value!,
                    );
                    try {
                      context.read<Taskprovider>().updateTask(updateTask);
                    } catch (e) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  },
                ),
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        tasks.title,
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                          color: Color(0xff102A5C),
                          decoration: tasks.completed
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Container(
                      padding: EdgeInsets.all(2),

                      decoration: BoxDecoration(
                        color: tasks.priority == "HIGH"
                            ? Colors.orange.shade300
                            : tasks.priority == "MED"
                            ? const Color.fromARGB(255, 82, 197, 250)
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        tasks.priority,
                        style: TextStyle(
                          decoration: tasks.completed
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: tasks.priority == "HIGH"
                              ? Colors.brown
                              : tasks.priority == "MED"
                              ? Colors.green
                              : const Color.fromARGB(255, 81, 80, 80),
                        ),
                      ),
                    ),
                  ],
                ),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tasks.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        decoration: tasks.completed
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      DateFormat("dd MMM yyyy").format(tasks.date),
                      style: TextStyle(
                        decoration: tasks.completed
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                  ],
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 5),
              ),
            ),
          ),
        );
      },
    );
  }
}
