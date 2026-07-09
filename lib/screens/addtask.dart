import 'package:flutter/material.dart';
import 'package:task_flow/models/task.dart';
import 'package:task_flow/models/taskdata.dart';
import 'package:task_flow/screens/navbar.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController(text: "mm/dd/yyyy");
  final _formkey = GlobalKey<FormState>();
  DateTime? selectedDate;

  final List<String> priorities = ["LOW", "MED", "HIGH"];
  String selectedPriority = "MED";

  @override
  void dispose() {
    titleController.dispose();
    dateController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  String? isValidName(String? name) {
    if (name!.isEmpty) {
      return "Enter Title";
    }
    return null;
  }

  String? isValidDate(String? name) {
    if ( name == "mm/dd/yyyy") {
      return "Select Date";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FD),

      appBar: AppBar(
        backgroundColor: const Color(0xffF5F6FD),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
              return Navbar();
            }));
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xff0D47A1),
            size: 30,
          ),
        ),

        title: const Text(
          "New Task",
          style: TextStyle(
            color: Color(0xff102A56),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: Colors.black54, size: 30),
          ),
        ],
      ),

      body: Form(
        key: _formkey,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusManager.instance.primaryFocus!.unfocus();
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                buildHeaderCard(),

                const SizedBox(height: 25),

                buildTitleField(),

                const SizedBox(height: 20),

                buildDescriptionField(),
                const SizedBox(height: 20),

                buildDateField(),

                const SizedBox(height: 20),

                buildPrioritySelector(),

                const SizedBox(height: 20),

                buildSaveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //======================== HEADER CARD ========================

  Widget buildSaveButton() {
    return GestureDetector(
      onTap: () {
        if (_formkey.currentState!.validate()) {
          var t1 = Task(
            title: titleController.text,
            description: descriptionController.text,
            date: selectedDate!,
            priority: selectedPriority,
            completed: false,
          );
          tasks.add(t1);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
            return Navbar();
          }));
        }
      },
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xff0D47A1)),
          borderRadius: BorderRadius.circular(15),
          color: Color(0xff0D47A1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.save, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              "Save Task",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeaderCard() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(
            color: Colors.black12.withValues(alpha: .05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Stack(
        children: [
          Positioned(
            right: -30,
            bottom: -25,
            child: Icon(Icons.task_alt, size: 130, color: Colors.blue.shade100),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: const [
              Text(
                "Create with Focus",
                style: TextStyle(
                  fontSize: 32,
                  color: Color(0xff0D47A1),
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10),

              Text(
                "Break down your goals into actionable steps.",
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //======================== TITLE FIELD ========================

  Widget buildTitleField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const Text(
          "TASK TITLE *",

          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),

        const SizedBox(height: 12),

        TextFormField(
          controller: titleController,
          validator: isValidName,
          decoration: InputDecoration(
            hintText: "e.g., Weekly Sync Meeting",

            hintStyle: const TextStyle(fontSize: 18, color: Colors.grey),

            filled: true,
            fillColor: Colors.white,

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 18,
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),

              borderSide: const BorderSide(color: Color(0xffC9D0E3)),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),

              borderSide: const BorderSide(color: Color(0xffC9D0E3)),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),

              borderSide: const BorderSide(color: Color(0xff0D47A1), width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPrioritySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const Text(
          "PRIORITY LEVEL",

          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),

        const SizedBox(height: 15),

        Container(
          height: 60,

          decoration: BoxDecoration(
            color: const Color(0xffE9ECFA),

            borderRadius: BorderRadius.circular(20),
          ),

          child: Row(
            children: priorities.map((priority) {
              bool selected = priority == selectedPriority;

              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedPriority = priority;
                    });
                  },

                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),

                    margin: const EdgeInsets.all(5),

                    decoration: BoxDecoration(
                      color: selected ? Colors.white : Colors.transparent,

                      borderRadius: BorderRadius.circular(15),
                    ),

                    child: Center(
                      child: Text(
                        priority,

                        style: TextStyle(
                          fontSize: 18,

                          fontWeight: FontWeight.bold,

                          color: selected
                              ? const Color(0xff0D47A1)
                              : Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const Text(
          "DUE DATE",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),

        const SizedBox(height: 12),

        TextFormField(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,

              initialDate: DateTime.now(),

              firstDate: DateTime(2024),

              lastDate: DateTime(2035),
            );

            if (pickedDate != null) {
              setState(() {
                selectedDate = pickedDate;
               dateController.text = selectedDate == null
        ? "mm/dd/yyyy"
        : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}";
              });
            }
          },
          validator: isValidDate,
          controller: dateController ,
          style: TextStyle(
            fontSize: 18,
        
            color: selectedDate == null ? Colors.grey : Colors.black87,
          ),
          readOnly: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
        
              borderSide: const BorderSide(color: Color(0xffC9D0E3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
        
              borderSide: const BorderSide(color: Color(0xffC9D0E3)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
        
              borderSide: const BorderSide(color: Color(0xffC9D0E3)),
            ),
            suffixIcon: const Icon(Icons.calendar_month, size: 30),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ],
    );
  }
  //======================== DESCRIPTION ========================

  Widget buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const Text(
          "DESCRIPTION",

          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),

        const SizedBox(height: 12),

        TextFormField(
          controller: descriptionController,

          maxLines: 4,

          decoration: InputDecoration(
            hintText: "What needs to be done?",

            hintStyle: const TextStyle(fontSize: 18, color: Colors.grey),

            filled: true,

            fillColor: Colors.white,

            contentPadding: const EdgeInsets.all(20),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),

              borderSide: const BorderSide(color: Color(0xffC9D0E3)),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),

              borderSide: const BorderSide(color: Color(0xffC9D0E3)),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),

              borderSide: const BorderSide(color: Color(0xff0D47A1), width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
