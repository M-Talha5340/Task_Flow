import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_flow/firbaseservices/firestore_services.dart';
import 'package:task_flow/models/task.dart';
import 'package:task_flow/screens/addtask.dart';
import 'package:task_flow/screens/navbar.dart';

class CalendarScreen extends StatefulWidget {
  
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {

  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  List<Task> task = [];

  List<Task> getEvents(DateTime day) {
    return task.where((t)=> t.date.day == day.day && 
    t.date.month == day.month && t.date.year == day.year).toList();
  }

  @override
  Widget build(BuildContext context) {

    final todayEvents = getEvents(_selectedDay);

    return Scaffold(

      backgroundColor: const Color(0xffF5F6FC),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child:  StreamBuilder<List<Task>>(
                    stream: FirestoreServices.instance.viewTask(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError){
                        return Center(
                          child: Text("Something went Wrong"),
                        );
                      }
                      if(snapshot.connectionState == ConnectionState.waiting){
                         return Center(
                            child: CircularProgressIndicator(),
                         );
                      }
                      task = snapshot.data ?? [];          
            return Column(
            
              children: [
            
                Container(
            
                  padding: const EdgeInsets.all(15),
            
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                      )
                    ],
                  ),
            
                  child: TableCalendar(
            
                    firstDay: DateTime(2020),
                    lastDay: DateTime(2035),
            
                    focusedDay: _focusedDay,
            
                    selectedDayPredicate: (day) {
                     
                      return isSameDay(day, _selectedDay);
                    },
            
                    onDaySelected: (selectedDay, focusedDay) {
            
                      setState(() {
            
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
            
                      });
            
                    },
            
                    eventLoader: (day) {
            
                      return getEvents(day);
            
                    },
            
                    headerStyle: const HeaderStyle(
            
                      titleCentered: true,
            
                      formatButtonVisible: false,
            
                      leftChevronIcon: Icon(Icons.chevron_left),
            
                      rightChevronIcon: Icon(Icons.chevron_right),
            
                    ),
            
                    calendarStyle: CalendarStyle(
            
                      todayDecoration: BoxDecoration(
            
                        color: Colors.blue.shade200,
            
                        shape: BoxShape.circle,
            
                      ),
            
                      selectedDecoration: const BoxDecoration(
            
                        color: Color(0xff0D47A1),
            
                        shape: BoxShape.circle,
            
                      ),
            
                      markerDecoration: const BoxDecoration(
            
                        color: Colors.red,
            
                        shape: BoxShape.circle,
            
                      ),
            
                    ),
            
                  ),
                ),
            
                const SizedBox(height: 10),
            
                Row(
            
                  children: [
            
                    const Text(
            
                      "Today's Schedule",
            
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
            
                    ),                
                     SizedBox(width: 10,),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>NewTaskScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff0D47A1),
                      ),
            
                      icon: const Icon(Icons.add,color: Colors.white),
            
                      label: const Text(
                        "New Task",
                        style: TextStyle(color: Colors.white),
                      ),
            
                    )
            
                  ],
            
                ),
            
                const SizedBox(height: 15),
            
                Expanded(
                  child: todayEvents.isEmpty
            
                      ? const Center(
            
                          child: Text(
            
                            "No Tasks",
            
                            style: TextStyle(fontSize: 20),
            
                          ),
            
                        )
            
                      :  ListView.builder(
                              physics:  BouncingScrollPhysics(),
                              itemCount: todayEvents.length,
                          
                              itemBuilder: (context, index) {
                          
                                final event = todayEvents[index];
                          
                                return Card(
                          
                                  margin: const EdgeInsets.only(bottom: 15),
                          
                                  shape: RoundedRectangleBorder(
                          
                                    borderRadius: BorderRadius.circular(15),
                          
                                  ),
                          
                                  child: ListTile(
                          
                                    leading: CircleAvatar(
                          
                                      backgroundColor: Colors.blue.shade100,
                          
                                      child: const Icon(
                                        Icons.calendar_today,
                                        color: Color(0xff0D47A1),
                                      ),
                          
                                    ),
                          
                                    title: Text(
                          
                                      event.title,
                          
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                          
                                    ),
                          
                                    subtitle: Column(
                          
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                          
                                      children: [
                          
                                        Text(DateFormat("dd MMM yyyy").format(event.date)),
                          
                                        
                          
                                      ],
                          
                                    ),
                          
                                    trailing:  IconButton(
                                      iconSize: 18,
                                      icon:Icon(Icons.arrow_forward_ios),                              
                                      onPressed: (){
                                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>
                                       Navbar()));
                                    },                                                          
                          
                                    ),
                          
                                  ),
                          
                                );
                          
                              },
                      
                            )
                        
                      
            
                ),
            
              ],
            
            );
          }
        ),
      ),
    );
  }
}