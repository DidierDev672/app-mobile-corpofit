import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomSideMenu extends StatelessWidget {
  final String currentPage;
  final Function(String) onMenuItemSelected;

  const CustomSideMenu({
    super.key,
    required this.currentPage,
    required this.onMenuItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white70, Colors.white60],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _buildDrawerHeader(),
            _buildMenuItem(
              context: context,
              icon: Icons.home,
              title: 'Inicio',
              path: '/',
            ),
            _buildMenuItem(
              context: context,
              icon: Icons.person,
              title: 'Anamnesis',
              path: '/anamnesis',
            ),
            _buildMenuItem(
              context: context,
              icon: Icons.sports_handball_outlined,
              title: 'Cuestionario de actividad física',
              path: '/physical_activity_questionnaire',
            ),
            _buildMenuItem(
              context: context,
              icon: Icons.food_bank_outlined,
              title: 'Cuestionario de hábitos alimentarios',
              path: '/eating_habits_questionnaire',
            ),
            _buildMenuItem(
              context: context,
              icon: Icons.sports_gymnastics_outlined,
              title: 'Condición  física',
              path: '/physical_condition',
            ),
            _buildMenuItem(
              context: context,
              icon: Icons.sports_kabaddi,
              title: 'Recomendaciones del programa',
              path: '/recomendaciones',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white70, Colors.white60],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blueAccent,
            child: Icon(Icons.person, size: 40, color: Colors.white),
          ),

          SizedBox(height: 10),
          Text(
            'Didier Arias',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'ariasdev672@gmail.com',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String path,
    bool isLogout = false,
  }) {
    final isSelected = currentPage == path;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isLogout ? Colors.red.shade300 : Colors.grey,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isLogout ? Colors.red.shade300 : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: () {
          if (isLogout) {
            _showLogoutDialog();
          } else {
            onMenuItemSelected(path);
            context.go(path);
            print(path);
          }
        },
        trailing:
            isSelected
                ? Icon(Icons.arrow_forward_ios, color: Colors.black, size: 16)
                : null,
      ),
    );
  }

  void _showLogoutDialog() {
    print('Cerrando sesión...');
  }
}
