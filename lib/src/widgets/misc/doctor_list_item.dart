import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user_model.dart';
import '../../blocs/user_bloc.dart';

class DoctorListItem extends StatelessWidget {
  final UserModel doctor;
  int patientID;

  DoctorListItem(this.doctor, this.patientID);

  @override
  Widget build(BuildContext context) {
    UserBloc userBloc = Provider.of<UserBloc>(context);

    return Column(
      children: [
        ListTile(
          title: Text('${doctor.firstName} ${doctor.lastName}'),
          subtitle: Text("Age: ${doctor.age}"),
          onTap: () {
            print(doctor.firstName);
            userBloc.addDoctorPermission(patientID, doctor.id);
            Navigator.pop(context);
          },
          trailing: const Icon(Icons.add),
        ),
        const Divider(),
      ],
    );
  }
}
