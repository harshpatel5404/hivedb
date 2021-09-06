import 'package:hive/hive.dart';
part 'form_model.g.dart';

@HiveType(typeId: 0)
class FormModel {
  @HiveField(0)
  final name;
  @HiveField(1)
  final logindate;
  @HiveField(2)
  final loginamt;
  @HiveField(3)
  final status;
  @HiveField(4)
  final sanctionamt;
  @HiveField(5)
  final sanctiondate;
  @HiveField(6)
  final disburdeddate;
  @HiveField(7)
  final disburdedamt;

  const FormModel({
    this.name,
    this.logindate,
    this.loginamt,
    this.status,
    this.sanctionamt,
    this.sanctiondate,
    this.disburdeddate,
    this.disburdedamt,
  });
}
