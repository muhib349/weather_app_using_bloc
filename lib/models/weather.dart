class WeatherMain {
  double _temp;
  double _feelsLike;
  double _tempMin;
  double _tempMax;
  int _pressure;
  int _humidity;
  int _seaLevel;
  int _grndLevel;


  WeatherMain(this._temp, this._feelsLike, this._tempMin, this._tempMax,
      this._pressure, this._humidity, this._seaLevel, this._grndLevel);


  double get temp => _temp - 272.5;

  WeatherMain.fromJson(Map<String, dynamic> json) {
    _temp = json['temp'];
    _feelsLike = json['feels_like'];
    _tempMin = json['temp_min'];
    _tempMax = json['temp_max'];
    _pressure = json['pressure'];
    _humidity = json['humidity'];
    _seaLevel = json['sea_level'];
    _grndLevel = json['grnd_level'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temp'] = this._temp;
    data['feels_like'] = this._feelsLike;
    data['temp_min'] = this._tempMin;
    data['temp_max'] = this._tempMax;
    data['pressure'] = this._pressure;
    data['humidity'] = this._humidity;
    data['sea_level'] = this._seaLevel;
    data['grnd_level'] = this._grndLevel;
    return data;
  }

  double get tempMin => _tempMin - 272.5;

  double get tempMax => _tempMax - 272.5;


}
