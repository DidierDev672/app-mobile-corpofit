import 'package:animate_do/animate_do.dart';
import 'package:corpofit_mobile/sports_activity/domain/domain.dart';
import 'package:corpofit_mobile/utils/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class CardSummarySportsActivityWidget extends StatelessWidget {
  final SportsActivity sportsActivity;
  const CardSummarySportsActivityWidget({
    super.key,
    required this.sportsActivity,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        ListTile(
          leading: Icon(
            Icons.sports,
            size: 35,
            color: sportsActivity.playAnySport ? Colors.orange : Colors.grey,
          ),
          title: Text(
            sportsActivity.playAnySport ? 'Si' : 'No',
            style: textStyle.titleMedium?.copyWith(fontSize: size.width * 0.05),
          ),
          subtitle: Text(
            '¿Practica algún deporte?',
            style: textStyle.titleSmall?.copyWith(fontSize: size.width * 0.05),
          ),
        ),
        SizedBox(height: size.height * 0.02),
        FadeInLeft(
          duration: const Duration(milliseconds: 500),
          child: Divider(
            color:
                sportsActivity.playAnySport
                    ? Colors.deepOrangeAccent
                    : Colors.grey,
          ),
        ),
        if (sportsActivity.playAnySport) ...{
          SizedBox(height: 16),
          ListTile(
            leading: Icon(
              Icons.sports_basketball,
              size: 35,
              color: Colors.deepOrangeAccent,
            ),
            title: Text(
              sportsActivity.whichSport!,
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
            subtitle: Text(
              '¿Cual?',
              style: textStyle.titleSmall?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          ListTile(
            leading: Icon(
              Icons.not_interested_sharp,
              size: 35,
              color: Colors.deepOrangeAccent,
            ),
            title: Text(
              sportsActivity.indicateAnnoyance!,
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
            subtitle: Text(
              'Indique la molestia',
              style: textStyle.titleSmall?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          ListTile(
            leading: Icon(
              Icons.nineteen_mp_rounded,
              size: 35,
              color: Colors.orangeAccent,
            ),
            title: Text(
              sportsActivity.dayWeek.toString(),
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
            subtitle: Text(
              'Días a la semana',
              style: textStyle.titleSmall?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          ListTile(
            leading: Icon(Icons.timelapse, size: 35, color: Colors.red),
            title: Text(sportsActivity.timeDay.toString()),
            subtitle: Text(
              'Tiempo por día (minutos)',
              style: textStyle.titleSmall?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          Divider(color: Colors.deepOrangeAccent),
          SizedBox(height: size.height * 0.02),
          Center(
            child: Text(
              '¿Hace cuánto practica este deporte?',
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          ListTile(
            leading: Icon(
              Icons.calendar_month_outlined,
              size: 35,
              color: Colors.redAccent,
            ),
            title: Text(
              sportsActivity.year!.toString(),
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
            subtitle: Text(
              'Años',
              style: textStyle.titleSmall?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          ListTile(
            leading: Icon(
              Icons.calendar_today_rounded,
              size: 35,
              color: Colors.amberAccent,
            ),
            title: Text(
              sportsActivity.month!.toString(),
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
            subtitle: Text(
              'Meses',
              style: textStyle.titleSmall?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          Divider(color: Colors.deepOrangeAccent),
          Text(
            'Indique el objetivo de esta práctica',
            style: textStyle.titleMedium?.copyWith(fontSize: size.width * 0.05),
          ),
          SizedBox(height: 16),
          ListTile(
            leading: Icon(
              Icons.spoke_outlined,
              size: 35,
              color:
                  sportsActivity.sportsCreation! ? Colors.amber : Colors.grey,
            ),
            title: Text(
              'Recreación deportiva',
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
          ),
          SizedBox(height: 16),
          ListTile(
            leading: Icon(
              Icons.sports_basketball_outlined,
              size: 35,
              color:
                  sportsActivity.sportsTraining!
                      ? Colors.deepOrangeAccent
                      : Colors.grey,
            ),
            title: Text(
              'Formación profesional',
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
          ),
          SizedBox(height: 16),
          ListTile(
            leading: Icon(
              Icons.sports_cricket_outlined,
              size: 35,
              color:
                  sportsActivity.professionalPreparation!
                      ? Colors.deepOrange
                      : Colors.grey,
            ),
            title: Text(
              'Preparación profesional',
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
          ),
          SizedBox(height: 16),
          ListTile(
            leading: Icon(
              Icons.style_rounded,
              size: 35,
              color:
                  sportsActivity.aestheticResult!
                      ? Colors.limeAccent
                      : Colors.grey,
            ),
            title: Text(
              'Resultados estéticos',
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
          ),
          SizedBox(height: 16),
          ListTile(
            leading: Icon(
              Icons.nature_people_sharp,
              size: 35,
              color: sportsActivity.healthyState! ? Colors.lime : Colors.grey,
            ),
            title: Text(
              'Estado saludable',
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          Divider(color: Colors.deepOrangeAccent),
          SizedBox(height: size.height * 0.02),
          ListTile(
            leading: Icon(
              Icons.accessibility_new_rounded,
              size: 35,
              color:
                  sportsActivity.practiceCauseDiscomfort!
                      ? Colors.lightGreenAccent
                      : Colors.grey,
            ),
            title: Text(
              sportsActivity.practiceCauseDiscomfort! ? 'Si' : 'No',
              style: textStyle.titleMedium?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
            subtitle: Text(
              'Realiza esta práctica le genera algún malestar',
              style: textStyle.titleSmall?.copyWith(
                fontSize: size.width * 0.05,
              ),
            ),
          ),
          if (sportsActivity.practiceCauseDiscomfort!) ...{
            SizedBox(height: size.height * 0.02),
            ListTile(
              leading: Icon(
                Icons.wrap_text_outlined,
                size: 35,
                color:
                    sportsActivity.practiceCauseDiscomfort!
                        ? Colors.lightGreen
                        : Colors.grey,
              ),
              title: Text(
                sportsActivity.which!,
                style: textStyle.titleMedium?.copyWith(
                  fontSize: size.width * 0.05,
                ),
              ),
              subtitle: Text(
                '¿Cual?',
                style: textStyle.titleSmall?.copyWith(
                  fontSize: size.width * 0.05,
                ),
              ),
            ),
          },

          SizedBox(height: size.height * 0.02),
          CustomButton(label: 'Enviar resumen', onPressed: () {}),
          SizedBox(height: size.height * 0.02),
        },
      ],
    );
  }
}
