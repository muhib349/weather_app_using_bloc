import 'package:equatable/equatable.dart';
import 'package:weather_app_using_bloc/repositories/weather_repository.dart';
import 'package:weather_app_using_bloc/models/weather.dart';
import 'package:bloc/bloc.dart';

class WeatherEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchWeather extends WeatherEvent{
  final _city;

  FetchWeather(this._city);

  @override
  // TODO: implement props
  List<Object> get props => [_city];
}

class ResetWeather extends WeatherEvent{

}

class WeatherState extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];

}


class WeatherIsNotSearched extends WeatherState{

}

class WeatherIsLoading extends WeatherState{

}

class WeatherIsLoaded extends WeatherState{
  final _weather;

  WeatherIsLoaded(this._weather);

  WeatherMain get getWeather => _weather;

  @override
  // TODO: implement props
  List<Object> get props => [_weather];
}

class WeatherIsNotLoaded extends WeatherState{
  final String _message;

  WeatherIsNotLoaded(this._message);


  String get message => _message;

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class WeatherBloc extends Bloc<WeatherEvent, WeatherState>{
  final WeatherRepository _repository;

  WeatherBloc(this._repository);


  @override
  // TODO: implement initialState
  WeatherState get initialState => WeatherIsNotSearched();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if(event is FetchWeather){
      yield WeatherIsLoading();
      try{
        WeatherMain  weather = await _repository.getWeatherData(event._city);
        yield WeatherIsLoaded(weather);
      }catch(e){
        yield WeatherIsNotLoaded(e.toString());
      }
    }else if(event is ResetWeather){
      yield WeatherIsNotSearched();
    }

  }

}