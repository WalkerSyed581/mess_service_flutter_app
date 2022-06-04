import 'package:mess_service/src/widgets/misc/doctor_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../blocs/user_bloc.dart';
import '../models/user_model.dart';

class AddDoctorScreen extends StatelessWidget {
  int patientID;

  AddDoctorScreen(this.patientID);

  @override
  Widget build(BuildContext context) {
    UserBloc userBloc = Provider.of<UserBloc>(context);
    userBloc.fetchAllDoctors(1);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Doctors'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: StreamBuilder(
        stream: userBloc.allDoctorsStream,
        builder: (BuildContext context,
            AsyncSnapshot<Future<List<UserModel>?>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return FutureBuilder(
            future: snapshot.data,
            builder: (BuildContext context,
                AsyncSnapshot<List<UserModel>?> doctorsSnapshot) {
              if (doctorsSnapshot.hasError) {
                return const Center(
                  child: Text('No doctors available :('),
                );
              } else if (!doctorsSnapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              List<UserModel> doctors = doctorsSnapshot.data!;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: doctors.length,
                  itemBuilder: (context, int index) {
                    return DoctorListItem(doctors[index], patientID);
                  },
                  padding: const EdgeInsets.all(10),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
