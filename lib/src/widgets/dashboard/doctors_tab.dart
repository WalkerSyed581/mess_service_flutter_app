import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../blocs/user_bloc.dart';
import '../../models/user_model.dart';

class DoctorsTab extends StatefulWidget {
  int patientID;

  DoctorsTab(this.patientID);

  @override
  State<StatefulWidget> createState() {
    return DoctorsTabState();
  }
}

class DoctorsTabState extends State<DoctorsTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    UserBloc userBloc = Provider.of<UserBloc>(context);
    userBloc.fetchDoctors(1);

    return StreamBuilder(
      stream: userBloc.doctorsStream,
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
              return ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, index) {
                  return ListTile(
                    title:
                        const Text("No doctors have permission to view data"),
                    subtitle: const Text("Tap to add doctors"),
                    onTap: () {
                      Navigator.pushNamed(context, '/add_doctors',
                          arguments: {'patientID': widget.patientID});
                    },
                    trailing: const Icon(Icons.add),
                  );
                },
              );
            } else if (!doctorsSnapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            List<UserModel> doctors = doctorsSnapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              shrinkWrap: true,
              itemCount: doctors.length + 1,
              itemBuilder: (context, int index) {
                if (index < doctors.length) {
                  return Column(
                    children: [
                      Dismissible(
                        key: Key(doctors[index].cnic),
                        onDismissed: (DismissDirection direction) {
                          userBloc.revokeDoctorPermission(
                              widget.patientID, doctors[index].id);
                          setState(() {
                            doctors.removeAt(index);
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  '${doctors[index].firstName} ${doctors[index].lastName} dismissed'),
                            ),
                          );
                        },
                        background: Container(color: Colors.red),
                        child: ListTile(
                          title: Text(
                              '${doctors[index].firstName} ${doctors[index].lastName}'),
                          subtitle: const Text("Tap to view assessments"),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/assessments',
                              arguments: {
                                "patientID": userBloc.id,
                                "doctorID": doctors[index].id,
                              },
                            );
                          },
                        ),
                      ),
                      const Divider(),
                    ],
                  );
                } else {
                  return ListTile(
                    title: const Text("Want more?"),
                    subtitle: const Text("Tap to add doctors"),
                    onTap: () {
                      Navigator.pushNamed(context, '/add_doctors',
                          arguments: {'patientID': widget.patientID});
                    },
                    trailing: const Icon(Icons.add),
                  );
                }
              },
            );
          },
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
