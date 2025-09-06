import 'package:corpofit_mobile/anamnesis/domain/basic_data.dart';
import 'package:corpofit_mobile/anamnesis/infrastructure/services/local_basic_data_service.dart';
import 'package:corpofit_mobile/anamnesis/presentation/widgets/summary_discomfort_when_exercise_widget.dart';
import 'package:corpofit_mobile/anamnesis/presentation/widgets/summary_medication_use_widget.dart';
import 'package:flutter/material.dart';

class SummaryOfAnamnesisWidget extends StatefulWidget {
  const SummaryOfAnamnesisWidget({super.key});

  @override
  State<SummaryOfAnamnesisWidget> createState() =>
      _SummaryOfAnamnesisWidgetState();
}

class _SummaryOfAnamnesisWidgetState extends State<SummaryOfAnamnesisWidget> {
  BasicData? basicData;
  bool _isLoading = false;
  bool _hasError = false;

  String name = '';
  String height = '';
  String weight = '';
  String gender = '';
  String birthDate = '';
  String country = '';
  String city = '';
  String address = '';
  String region = '';

  @override
  void initState() {
    super.initState();
    _initializeHive();
  }

  Future<void> _initializeHive() async {
    try {
      setState(() {
        _isLoading = true;
        _hasError = false;

        name = LocalBasicDataService.read<String>('name_full') ?? '';
        height = LocalBasicDataService.read<String>('height') ?? '';
        weight = LocalBasicDataService.read<String>('weight') ?? '';
        gender = LocalBasicDataService.read<String>('gender') ?? '';
        birthDate = LocalBasicDataService.read<String>('birth_date') ?? '';
        country = LocalBasicDataService.read<String>('country') ?? '';
        city = LocalBasicDataService.read<String>('city') ?? '';
        address = LocalBasicDataService.read<String>('address') ?? '';
        region = LocalBasicDataService.read<String>('region') ?? '';

        basicData = BasicData(
          id: 0,
          name: name,
          height: double.parse(height),
          weight: double.parse(weight),
          gender: gender,
          birthDate: DateTime.parse(birthDate),
          country: country,
          city: city,
          address: address,
          region: region,
          createdAt: DateTime.now(),
        );
      });
    } catch (e) {
      setState(() {
        _hasError = true;
      });
      debugPrint('Error al inicializar Hive: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (basicData == null) {
      return Center(
        child: Text('No hay datos disponibles', style: textStyle.titleMedium),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(25),
          topLeft: Radius.circular(15),
          topRight: Radius.circular(25),
        ),
        gradient: LinearGradient(
          colors: [Colors.grey.shade300, Colors.grey.shade200],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          UserSammaryCard(basicData: basicData!),
          SummaryMedicationUseWidget(),
          SummaryDiscomfortWhenExerciseWidget(),
          SizedBox(height: 16),
          ElevatedButton(
            autofocus: true,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            onPressed: () {},
            child: Text(
              'Enviar anamnesis',
              style: textStyle.titleMedium?.copyWith(
                color: Colors.white,
                fontSize: size.width * 0.05,
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

class UserSammaryCard extends StatelessWidget {
  final BasicData basicData;
  const UserSammaryCard({super.key, required this.basicData});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    return Card(
      elevation: 2,
      color: isDarkMode ? Colors.black : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Resumen de anamnesis',
              style: theme.textTheme.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
            SizedBox(height: 16),
            Text(
              basicData.name,
              style: theme.textTheme.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),

            SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.date_range_outlined, size: 34),
              title: Text(
                basicData.birthDate.toString(),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: size.width * 0.05,
                ),
              ),
            ),
            SizedBox(height: 8),
            ListTile(
              leading: Icon(Icons.line_weight, size: 34),
              title: Text(
                basicData.weight.toString(),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: size.width * 0.05,
                ),
              ),
            ),

            SizedBox(height: 8),
            ListTile(
              leading: Icon(Icons.height, size: 34),
              title: Text(
                basicData.height.toString(),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: size.width * 0.05,
                ),
              ),
            ),
            SizedBox(height: 8),
            ListTile(
              leading: Icon(Icons.heat_pump_sharp, size: 34),
              title: Text(
                basicData.gender,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: size.width * 0.05,
                ),
              ),
            ),

            SizedBox(height: 8),
            ListTile(
              leading: Icon(Icons.location_city, size: 34),
              title: Text(
                basicData.country,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: size.width * 0.05,
                ),
              ),
            ),
            SizedBox(height: 8),
            ListTile(
              leading: Icon(Icons.local_activity, size: 34),
              title: Text(
                basicData.city,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: size.width * 0.05,
                ),
              ),
            ),
            SizedBox(height: 8),
            ListTile(
              leading: Icon(Icons.location_on_sharp, size: 34),
              title: Text(
                basicData.region,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: size.width * 0.05,
                ),
              ),
            ),
            SizedBox(height: 8),
            ListTile(
              leading: Icon(Icons.home, size: 34),
              title: Text(
                basicData.address,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: size.width * 0.05,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
