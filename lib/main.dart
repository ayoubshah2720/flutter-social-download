import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import http package

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social Downloader',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Welcome to Social Downloader'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController getUrl = TextEditingController();
    final List<Map<String, dynamic>> images = [
      {
        "url": "https://i.ytimg.com/vi/8x0Dty5D6CA/hqdefault.jpg",
        "width": 168,
        "height": 94
      },
      {
        "url": "https://i.ytimg.com/vi/8x0Dty5D6CA/hqdefault.jpg",
        "width": 196,
        "height": 110
      },
      {
        "url": "https://i.ytimg.com/vi/8x0Dty5D6CA/hqdefault.jpg",
        "width": 246,
        "height": 138
      },
      {
        "url": "https://i.ytimg.com/vi/8x0Dty5D6CA/hqdefault.jpg",
        "width": 336,
        "height": 188
      },
      {
        "url": "https://i.ytimg.com/vi/8x0Dty5D6CA/maxresdefault.jpg",
        "width": 1920,
        "height": 1080
      }
    ];
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              child: TextField(
                controller: getUrl,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    prefix: Icon(Icons.video_call),
                    border: OutlineInputBorder(),
                    hintText: 'Paste coppied URL.'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      _downloadYt(getUrl.text, 'download');
                    },
                    // {
                    //   var urlValue = getUrl.text;
                    //   print('Elevated button is clicked. ==>> $urlValue');
                    //   _fetchThumbnail();
                    // },
                    child: Text('Download')),
                ElevatedButton(
                    onPressed: () {
                      _downloadYt(getUrl.text, 'videos');
                    },
                    // {
                    //   var urlValue = getUrl.text;
                    //   print('Elevated button is clicked. ==>> $urlValue');
                    //   _fetchThumbnail();
                    // },
                    child: Text('All Qualities')),
                ElevatedButton(
                    onPressed: () {
                      _downloadYt(getUrl.text, 'thumbnail');
                    },
                    // {
                    //   var urlValue = getUrl.text;
                    //   print('Elevated button is clicked. ==>> $urlValue');
                    //   _fetchThumbnail();
                    // },
                    child: Text('Thumbnails')),
              ],
            ),
            SizedBox(
              height: 100,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Image.network(
                    // images[index]['url'],
                    'https://fastly.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U',
                    width: double.infinity, // Set width to fill the screen
                    height: 200, // Set a fixed height for the images
                    fit: BoxFit
                        .cover, // Cover the available space without distorting the aspect ratio
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _downloadYt(String socialUrl, String type) async {
    final url =
        Uri.parse('https://yt-download-iiyr.onrender.com/$type?url=$socialUrl');

    try {
      final response = await http.get(url);
      var urlValue = url;
      print('Elevated button is clicked. ==>> $urlValue');
      if (response.statusCode == 200) {
        // Request successful, handle response here
        print('Thumbnail URL: ${response.body}');
      } else {
        // Request failed, handle error here
        print('Failed to fetch thumbnail: ${response.statusCode}');
      }
    } catch (e) {
      // Exception occurred, handle error here
      print('Error fetching thumbnail: $e');
    }
  }
}
