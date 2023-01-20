// ignore_for_file: must_be_immutable

part of 'adduser_bloc.dart';

class AdduserState extends Equatable {
  AdduserState({
    this.firstname = '',
    this.lastname = '',
    this.mobilenumber = '',
    this.male = "Male",
    this.female = "Female",
    this.isselectedgender = '',
    this.selectrole = const [
      "Batter",
      "WicketKeeper Batter",
      "Batting Allrounder",
      "Allrounder",
      "Bowler",
      "Bowling Allrounder"
    ],
    this.isselectedrole = '',
  });

  String? firstname;
  String? lastname;
  String? mobilenumber;
  String? male;
  String? female;
  String? isselectedgender;
  List<String> selectrole;
  String? isselectedrole;

  @override
  List<Object?> get props => [
        firstname,
        lastname,
        mobilenumber,
        male,
        female,
        isselectedgender,
        selectrole,
        isselectedrole
      ];

  AdduserState copyWith({
    String? firstname,
    String? lastname,
    String? mobilenumber,
    String? male,
    String? female,
    String? isselectedgender,
    List<String>? selectrole,
    String? isselectedrole,
  }) {
    return AdduserState(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      mobilenumber: mobilenumber ?? this.mobilenumber,
      male: male ?? this.male,
      female: female ?? this.female,
      isselectedgender: isselectedgender ?? this.isselectedgender,
      selectrole: selectrole ?? this.selectrole,
      isselectedrole: isselectedrole ?? this.isselectedrole,
    );
  }
}

class UserInitial extends AdduserState {
  @override
  List<Object> get props => [];
}

class DisplayUsers extends AdduserState {
  final List<User> user;

  DisplayUsers({required this.user});
  @override
  List<Object> get props => [user];
}

class DisplaySpecificUser extends AdduserState {
  final User user;

  DisplaySpecificUser({required this.user});
  @override
  List<Object> get props => [user];
}
