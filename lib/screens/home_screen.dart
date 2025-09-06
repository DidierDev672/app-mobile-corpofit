import 'package:flutter/material.dart';

import '../utils/widgets/widget.dart';

class HomeScreen extends StatefulWidget {
  final Function(bool) onThemeChanged;
  const HomeScreen({super.key, required this.onThemeChanged});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String currentPage = 'inicio';
  bool _isDarkMode = false;

  void _onMenuItemSelected(String page) {
    setState(() {
      currentPage = page;
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text('Corpofit'),
        actions: [
          IconButton(
            icon: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: Icon(
                isDark ? Icons.light_mode : Icons.dark_mode,
                key: ValueKey(isDark),
              ),
            ),
            onPressed: () {
              setState(() {
                _isDarkMode = !_isDarkMode;
              });

              widget.onThemeChanged(_isDarkMode);
            },

            tooltip: isDark ? 'Modo claro' : 'Modo oscuro',
          ),

          //? Perfil de usuario
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () => _showProfileMenu(context),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: isDark ? Colors.black : Colors.white,
                child: Icon(
                  Icons.person,
                  color: isDark ? Colors.white : Colors.black,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: CustomSideMenu(
        currentPage: currentPage,
        onMenuItemSelected: _onMenuItemSelected,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white60, Colors.white70],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(_getPageIcon(), size: 100, color: Colors.deepPurple),
            SizedBox(height: 20),
            Text(
              'Página actual: $currentPage',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Abre el menú deslizando desde la izquierda\no tocando el ícono del menú',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProfileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white60, Colors.white70],
              ),
            ),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
            
          ],
        ),
          ),
    );
  }

  IconData _getPageIcon() {
    switch (currentPage) {
      case 'Inicio':
        return Icons.home;
      case 'Análisis':
        return Icons.bar_chart;
      case 'Custionario de actividad física':
        return Icons.sports_gymnastics;
      case 'Cuestionario de hábitos alimentarios':
        return Icons.food_bank;
      case 'Condición física':
        return Icons.sports_gymnastics;
      case 'Recomendaciones del programa':
        return Icons.settings;
      case 'Cerrar sesión':
        return Icons.logout;

      default:
        return Icons.home;
    }
  }
}
