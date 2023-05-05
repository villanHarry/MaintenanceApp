import 'package:hive/hive.dart';
part 'User.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  late String accessToken;
  @HiveField(1)
  late String id;
  @HiveField(2)
  late String username;
  @HiveField(3)
  late String email;
  @HiveField(4)
  late String usertype;
  @HiveField(5)
  late String image;
  @HiveField(6)
  late int contactNumber;
  @HiveField(7)
  late int floorNumber;
  @HiveField(8)
  late String address;
  @HiveField(9)
  late int unitNumber;
}
