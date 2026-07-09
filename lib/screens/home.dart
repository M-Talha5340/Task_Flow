import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_flow/models/task.dart';
import 'package:task_flow/models/taskdata.dart';
import 'package:task_flow/screens/addtask.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   int totalPending = 0;
  int currentindex = 0;
  
   
  List<Task> get filteredTasks {
    switch (currentindex) {
      case 0:
        return tasks;
      case 1:
        return tasks.where((t) => t.completed == false).toList();
      case 2:             
        return tasks.where((t) => t.completed == true).toList();
      case 3:
        return tasks.where((t) => t.priority == "HIGH").toList();
      default:
        return tasks;
    }
  }

  @override
  void initState() {
    super.initState();
    totalPending = tasks.where((t) => t.completed == false).length;
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       floatingActionButton: FloatingActionButton(onPressed: (){
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>NewTaskScreen()));
      },
      
      backgroundColor:  Color(0xff0D47A1),child: Icon(Icons.add,color: Colors.white,),
      ),         
        body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //================ GREETING ===================
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: const Text(
                "Good Morning, Alex",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff102A5C),
                ),
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                "You have $totalPending tasks to complete today.",
                style: TextStyle(fontSize: 22, color: Colors.black54),
              ),
            ),

            const SizedBox(height: 15),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ChoiceChip(
                    label: Text("All",style: TextStyle(fontWeight: FontWeight.bold,
                  color: Color(0xff102A5C)),),
                    selected: currentindex == 0,
                    onSelected: (_) {
                      setState(() {
                        currentindex = 0;
                      });
                    },
                  ),

                  SizedBox(width: 10),

                  ChoiceChip(
                    label: Text("Pending",style: TextStyle(fontWeight: FontWeight.bold,
                  color: Color(0xff102A5C)),),
                    selected: currentindex == 1,
                    onSelected: (_) {
                      setState(() {
                        currentindex = 1;
                      });
                    },
                  ),

                  SizedBox(width: 10),

                  ChoiceChip(
                    label: Text("Completed",style: TextStyle(fontWeight: FontWeight.bold,
                  color: Color(0xff102A5C)),),
                    selected: currentindex == 2,
                    onSelected: (_) {
                      setState(() {
                         currentindex = 2;
                      });
                    },
                  ),
                  SizedBox(width: 10),
                  ChoiceChip(
                    label: Text("Priority",style: TextStyle(fontWeight: FontWeight.bold,
                  color: Color(0xff102A5C)),),
                    selected: currentindex == 3,
                    onSelected: (_) {
                      setState(() {
                        currentindex = 3;
                      });
                    },
                  ),
                ],
              ),
            ),
            // Placeholder for Part 3
            Expanded(
              child: ListView.builder(
                itemCount: filteredTasks.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(                      
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.5, color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: ListTile(
                        leading: Checkbox(
                          value: filteredTasks[index].completed,
                          onChanged: (value) {
                            setState(() {                            
                              filteredTasks[index].completed = value!;
                              totalPending = tasks.where((t) => t.completed == false).length;
                            });
                          },
                        ),
                        title: Row(                        
                          children: [
                            Expanded(
                              child: Text(
                                filteredTasks[index].title,
                                maxLines: 1,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                  color: Color(0xff102A5C),
                                  decoration: filteredTasks[index].completed
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                            ),
                             SizedBox(width: 5),
                            Container(
                              padding: EdgeInsets.all(2),
                                                        
                              decoration: BoxDecoration(
                                color: filteredTasks[index].priority == "HIGH"
                                    ? Colors.orange.shade300
                                    : filteredTasks[index].priority == "MED"
                                    ? const Color.fromARGB(255, 82, 197, 250)
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                filteredTasks[index].priority,
                                style: TextStyle(
                                  decoration: filteredTasks[index].completed
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                  color: filteredTasks[index].priority == "HIGH"
                                      ? Colors.brown
                                      : filteredTasks[index].priority == "MED"
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
                          children:[ Text(
                            filteredTasks[index].description
                              ,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              decoration: filteredTasks[index].completed
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          const SizedBox(height: 
                          2,),
                          Text(
                              DateFormat("dd MMM yyyy").format(filteredTasks[index].date)
                              ,                                                      
                            style: TextStyle(
                              decoration: filteredTasks[index].completed
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),

                          ]
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 5),

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