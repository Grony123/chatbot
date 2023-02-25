import 'package:flutter/material.dart';


class Profile extends StatefulWidget {
  final String mail;
  final String user;
  const Profile({Key? key, required this.user, required this.mail}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          centerTitle: true,
          backgroundColor: Colors.grey[900],
          leading: BackButton(
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          color: Colors.grey[850],
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 70.0, 10.0, 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [ 
                const Center(
                  child: CircleAvatar(
                    radius: 65.0,
                    backgroundImage: AssetImage('assets/images/best.jpg'),
                  ),
                ),
                Divider(height: 120, color: Colors.grey[900], thickness: 3, indent: 20.0, endIndent: 20.0),
                Row(
                    children:[
                      const SizedBox(width: 20.0),
                      const Text(
                        'username : ',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        widget.user,
                        style: const TextStyle(
                          fontSize: 23.0,
                          color: Colors.amber,
                        ),
                      )
                    ]
                ),
                const SizedBox(height: 20.0),
                Row(
                  children:[
                    const SizedBox(width: 20.0),
                    const Text(
                      'email : ',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      widget.mail,
                      style: const TextStyle(
                        fontSize: 23.0,
                        color: Colors.amber,
                      ),
                    )
                  ]
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
