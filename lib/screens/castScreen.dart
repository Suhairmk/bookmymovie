import 'package:flutter/material.dart';
import 'package:jobdemo/data%20models/castModel.dart';
import 'package:jobdemo/utlils/api.dart';

class CastScreen extends StatelessWidget {
  const CastScreen({Key? key, required this.castList,required this.title}) : super(key: key);
  final title;
  final List<Cast> castList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: castList != null && castList.isNotEmpty
          ? ListView.builder(
              itemCount: castList.length,
              itemBuilder: (context, index) {
                String dob = castList[index].person.birthday.toString();
                return ExpansionTile(
                  childrenPadding: EdgeInsets.only(left: 60),
                  expandedAlignment: Alignment.bottomLeft,
                  leading: castList[index].character.image != null
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(
                              castList[index].character.image!.medium),
                        )
                      : CircleAvatar(
                          child: Text(castList[index].character.name[0]),
                        ),
                  title: Text(castList[index].character.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(castList[index].person.name),
                    ],
                  ),
                  children: [
                    Text(dob.length > 10
                        ? '  Dob: ' + dob.substring(0, 10)
                        : dob),
                    Text(castList[index].person.gender.toString()),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                );
              },
            )
          : Center(
              child: castList != null
                  ? Text('No cast members found')
                  : CircularProgressIndicator(),
            ),
    );
  }
}
