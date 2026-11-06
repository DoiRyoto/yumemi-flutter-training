// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherResponse _$WeatherResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'WeatherResponse',
      json,
      ($checkedConvert) {
        final val = WeatherResponse(
          weatherCondition: $checkedConvert(
            'weather_condition',
            (v) => $enumDecode(_$WeatherConditionEnumMap, v),
          ),
          maxTemperature: $checkedConvert(
            'max_temperature',
            (v) => (v as num).toInt(),
          ),
          minTemperature: $checkedConvert(
            'min_temperature',
            (v) => (v as num).toInt(),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'weatherCondition': 'weather_condition',
        'maxTemperature': 'max_temperature',
        'minTemperature': 'min_temperature',
      },
    );

const _$WeatherConditionEnumMap = {
  WeatherCondition.sunny: 'sunny',
  WeatherCondition.cloudy: 'cloudy',
  WeatherCondition.rainy: 'rainy',
};
