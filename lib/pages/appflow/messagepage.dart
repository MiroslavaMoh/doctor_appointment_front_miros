import 'package:flutter/material.dart';

class Messagepage extends StatefulWidget {
  const Messagepage({super.key});

  @override
  State<Messagepage> createState() => _MessagepageState();
}

class _MessagepageState extends State<Messagepage> {
  List<Map<String, dynamic>> messages = [
    {
      "name": "Onigiri",
      "message": "Nos vemos mañana a las 10 AM ",
      "time": "09:45",
      "image": "assets/img/Onigiri_1.png",
      "unread": true,
    },
    {
      "name": "Dr. Milanesa",
      "message": "Recuerda traer bocadillos.",
      "time": "Ayer",
      "image": "assets/img/Onigiri_2.png",
      "unread": false,
    },
    {
      "name": "Fetuchini",
      "message": "Tu cita fue confirmada",
      "time": "Domingo",
      "image": "assets/img/Onigiri_3.png",
      "unread": false,
    },
  ];

  int selectIndex = 0;
  List catArr = [
    {"icon": "assets/img/Onigiri_1.png", "title": "Onigiri"},
    {"icon": "assets/img/Onigiri_2.png", "title": "Milanesa"},
    {"icon": "assets/img/Onigiri_3.png", "title": "Fetuchini"},
    {"icon": "assets/img/Onigiri_1.png", "title": "Onigiri"},
    {"icon": "assets/img/Onigiri_2.png", "title": "Milanesa"},
    {"icon": "assets/img/Onigiri_3.png", "title": "Fetuchini"},
    {"icon": "assets/img/all.png", "title": "Todo"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f8f8),
      
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "Mensajes",
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
            ),
            // inicio - Barra de búsqueda
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Buscar conversación...",
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ),
            //fin barra busqueda
        
             //Inicio-Sección deslizable con fichas de especialidades
        
                SizedBox(
                height: 120,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var cObj = catArr[index];
                      return InkWell(
                        onTap: () {
                          selectIndex = index;
                           setState(() {});
                        },
                        child: Column(children: [
                          Container(
                            width: 55,
                            height: 55,
                            decoration: BoxDecoration(
                                color: selectIndex == index
                                    ? Colors.deepPurple[200] //Color de fondo de ficha seleccionada
                                    : Colors.grey[200], //Color de fondo de ficha no seleccionada
                                borderRadius: BorderRadius.circular(20)),
                            alignment: Alignment.center,
                            child: Image.asset(
                             cObj["icon"]  ,
                              width: 50,
                              height: 50,
                              //color: Colors.white , //color icon
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            cObj["title"],
                            style: TextStyle(
                              color: selectIndex == index ? Colors.grey[600]
                                  : Colors.grey[400],
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ]),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          width: 20,
                        ),
                    itemCount: catArr.length ),
              ),
              //Fin-Sección deslizable con fichas de especialidades
        
            // Lista de mensajes
            Expanded(
              child: ListView.separated(
                itemCount: messages.length,
                separatorBuilder: (_, __) => const Divider(height: 0),
                itemBuilder: (context, index) {
                  final msg = messages[index];
                  return InkWell(
                    onTap: () {
                      // Aquí puedes navegar a la pantalla de chat individual
                    },
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundImage: AssetImage(msg["image"]),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  msg["name"],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  msg["message"],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: msg["unread"]
                                        ? Colors.black
                                        : Colors.grey[600],
                                    fontWeight: msg["unread"]
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                msg["time"],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 6),
                              if (msg["unread"])
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: const BoxDecoration(
                                    color: Colors.blueAccent,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}