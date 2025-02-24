import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/features/weather/domain/entity/repo_entity.dart';
import 'package:weather_app/features/weather/presentation/widgets/myListTile.dart';

class ForecastScreenBody extends StatelessWidget {
  const ForecastScreenBody({
    super.key,
    required this.response,
  });

  final ResponseEntity response;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: screenHeight * 0.01,
            left: screenWidth * 0.02,
          ),
          child: Row(
            children: [
             
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.03,
                  vertical: screenWidth * 0.03,
                ),
                child: Text(
                  "The weather",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          height: screenHeight * 0.8,
          child: ListView.builder(
            itemCount: response.forecast?.forecastday?.length ?? 0,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                height: screenHeight * 0.12,
                margin: EdgeInsets.all(10),
                child: MyListTile(
                  imagePath: response
                          .forecast?.forecastday?[index].day?.condition?.icon ??
                      "",
                  data: response.forecast?.forecastday?[index].date ?? "",
                  weatherDay: response
                          .forecast?.forecastday?[index].day?.avgtempC
                          .toString() ??
                      "",
                  maxTemp: response.forecast?.forecastday?[index].day?.maxtempC
                          .toString() ??
                      "",
                  minTemp: response.forecast?.forecastday?[index].day?.mintempC
                          .toString() ??
                      "",
                ),
              );
            },
          ),
        )
      ],
    );
  }
}