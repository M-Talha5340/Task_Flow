import 'package:flutter/material.dart';

class CustomBottomNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
         
        children: [
           
          _buildItem(
            index: 0,
            icon: Icons.task_alt_outlined,
            label: "Tasks",
          ),

      
          _buildItem(
            index: 1,
            icon: Icons.calendar_month_outlined,
            label: "Calendar",
          ),

          _buildItem(
            index: 2,
            icon: Icons.person_outline,
            label: "Profile",
          ),
        ],
      ),
    );
  }

  Widget _buildItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    bool selected = selectedIndex == index;

    return InkWell(
      onTap: () => onItemTapped(index),
        child: AnimatedContainer(    
          height: 70,
          width: 80,      
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric( vertical: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xff0D47A1) : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Column(
            
            children: [
          
              Icon(
                icon,
                size: 22,
                color: selected ? Colors.white : Colors.grey[700],
              ),
          
              const SizedBox(height: 5),
          
              Text(
                label,
                style: TextStyle(
                  color: selected ? Colors.white : Colors.grey[700],
                  fontSize: 16,
                  fontWeight:
                      selected ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}