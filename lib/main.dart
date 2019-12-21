import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_using_bloc/bloc/weather_bloc.dart';
import 'package:weather_app_using_bloc/repositories/weather_repository.dart';
import 'models/weather.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.grey[900],

          body: BlocProvider(
            create: (context) => WeatherBloc(WeatherRepository()),
            child: SearchPage(),
          ),
        )
    );
  }
}

class SearchPage extends StatelessWidget {

  final cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        /*Center(
            child: Container(
              child: FlareActor("assets/WorldSpin.flr", fit: BoxFit.contain, animation: "roll",),
              height: 300,
              width: 300,
            )
        ),*/

        BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state){
            if(state is WeatherIsLoading)
              return Center(child : CircularProgressIndicator());
            else if(state is WeatherIsLoaded)
              return ShowWeather(state.getWeather, cityController.text);
            else if(state is WeatherIsNotLoaded)
              return Container(
                padding: EdgeInsets.only(left: 40, right: 40),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text("${state.message}",style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600)),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 40,
                        child: FlatButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))),
                          onPressed: () {
                            BlocProvider.of<WeatherBloc>(context).add(ResetWeather());
                          },
                          color: Colors.lightBlue,
                          child: Text(
                            "Back To Home Page",
                            style: TextStyle(color: Colors.white70, fontSize: 15),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              );
            return _getInitialPage(context);
          },
        ),


      ],
    );
  }

  Widget _getInitialPage(context) {
    return Container(
      padding: EdgeInsets.only(left: 32, right: 32),
      child: Column(
        children: <Widget>[
          Text(
            "Search Weather",
            style: TextStyle(
                fontSize: 40, fontWeight: FontWeight.w500, color: Colors.white70),
          ),
          Text(
            "Instantly",
            style: TextStyle(
                fontSize: 40, fontWeight: FontWeight.w200, color: Colors.white70),
          ),
          SizedBox(
            height: 24,
          ),
          TextFormField(
            controller: cityController,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white70,
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                      color: Colors.white70, style: BorderStyle.solid)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide:
                  BorderSide(color: Colors.blue, style: BorderStyle.solid)),
              hintText: "City Name",
              hintStyle: TextStyle(color: Colors.white70),
            ),
            style: TextStyle(color: Colors.white70),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            height: 50,
            child: FlatButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              onPressed: () {
                BlocProvider.of<WeatherBloc>(context).add(FetchWeather(cityController.text));
              },
              color: Colors.lightBlue,
              child: Text(
                "Search",
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
            ),
          )
        ],
      ),
    );
  }

}

class ShowWeather extends StatelessWidget {

  final WeatherMain weather;
  final city;

  ShowWeather(this.weather, this.city);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(right: 32, left: 32, top: 10),
        child: Column(
          children: <Widget>[
            Text(
              city,
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              weather.temp.round().toString() + "C",
              style: TextStyle(color: Colors.white70, fontSize: 50),
            ),
            Text(
              "Temprature",
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      weather.tempMin.round().toString() + "C",
                      style: TextStyle(color: Colors.white70, fontSize: 30),
                    ),
                    Text(
                      "Min Temprature",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      weather.tempMax.round().toString() + "C",
                      style: TextStyle(color: Colors.white70, fontSize: 30),
                    ),
                    Text(
                      "Max Temprature",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 50,
              child: FlatButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                onPressed: () {
                  BlocProvider.of<WeatherBloc>(context).add(ResetWeather());
                },
                color: Colors.lightBlue,
                child: Text(
                  "Search",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ),
            )
          ],
        ));
  }
}
