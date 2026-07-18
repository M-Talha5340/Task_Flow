
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_flow/models/task.dart';
import 'package:task_flow/providers/taskprovider.dart';
import 'package:task_flow/providers/userprovider.dart';
import 'package:task_flow/screens/addtask.dart';
import 'package:task_flow/widgets/textile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {  

  @override
  void initState() {
    super.initState();    
  }

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => NewTaskScreen()),
          );
        },

        backgroundColor: Color(0xff0D47A1),
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //================ GREETING ===================
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Selector<Userprovider,String?>(
                selector: (_, provider) => provider.user!.name,
                builder: (context, name, child) {              
                return Text(
                  "Good Morning, $name",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff102A5C),
                  ),
                );
                }
              ),
            ),

            const SizedBox(height: 10),

            Selector<Taskprovider,int>(
              selector: (_, provider) => provider.tasks.where((t)=>!t.completed).length,
              builder: (context, totalpending, child) {              
                return Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "You have $totalpending task to complete today.",
                  style: TextStyle(fontSize: 22, color: Colors.black54), ),
                );
              },
            ),

            const SizedBox(height: 15),

            Selector<Taskprovider,TaskFilter>(
              selector: (context, provider) =>provider.filter ,
              builder: (context, filter, child) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      ChoiceChip(
                        label: Text(
                          "All",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff102A5C),
                          ),
                        ),
                        selected: filter == TaskFilter.all,
                        onSelected: (_) {
                          context.read<Taskprovider>().chandeFilter(
                            TaskFilter.all,
                          );
                        },
                      ),

                      SizedBox(width: 10),

                      ChoiceChip(
                        label: Text(
                          "Pending",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff102A5C),
                          ),
                        ),
                        selected: filter == TaskFilter.pending,
                        onSelected: (_) {
                          context.read<Taskprovider>().chandeFilter(
                            TaskFilter.pending,
                          );
                        },
                      ),

                      SizedBox(width: 10),

                      ChoiceChip(
                        label: Text(
                          "Completed",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff102A5C),
                          ),
                        ),
                        selected: filter == TaskFilter.completed,
                        onSelected: (_) {
                          context.read<Taskprovider>().chandeFilter(
                            TaskFilter.completed,
                          );
                        },
                      ),
                      SizedBox(width: 10),
                      ChoiceChip(
                        label: Text(
                          "Priority",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff102A5C),
                          ),
                        ),
                        selected: filter == TaskFilter.highPriority,
                        onSelected: (_) {
                          context.read<Taskprovider>().chandeFilter(
                            TaskFilter.highPriority,
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            // Placeholder for Part 3
            Selector<Taskprovider,List<Task>>( 

              selector: (_, provider) => provider.filteredTasks ,               
               builder: (context, tasks, child) {  
              
              return Expanded(
                child: ListView.builder(                  
                  itemCount: tasks.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Textile(id: tasks[index].id!,);
                    
                  },
                ),
              );
            }
            ),
          ],
        ),
      ),
    );
  }
}
