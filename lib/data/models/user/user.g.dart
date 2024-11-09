// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: (json['id'] as num).toInt(),
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      birthDate: DateTime.parse(json['birthDate'] as String),
      address: json['address'] as String,
      photo: json['photo'] as String?,
      phoneNumber: json['phoneNumber'] as String,
      position: json['position'] as String,
      company: json['company'] as String,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'birthDate': instance.birthDate.toIso8601String(),
      'address': instance.address,
      'photo': instance.photo,
      'phoneNumber': instance.phoneNumber,
      'position': instance.position,
      'company': instance.company,
    };
