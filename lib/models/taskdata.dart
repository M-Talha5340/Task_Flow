import '../models/task.dart';

List<Task> tasks = [

  Task(
    title: "Redesign Hero Section",
    description:
        "Update the homepage hero section with the new animated shader background.",
    date: DateTime(2026,7,10,14,0),
    priority: "HIGH",
    completed: false,
  ),

  Task(
    title: "Weekly Sync Meeting",
    description:
        "Coordinate with engineering team regarding sprint deliverables.",
    date: DateTime(2026,7,12,16,0),
    priority: "MED",
    completed: false,
  ),

  Task(
    title: "Order Office Supplies",
    description:
        "Restock pens, notebooks and coffee filters.",
    date: DateTime(2026,6,10,14,0),
    priority: "LOW",
    completed: true,
  ),
];