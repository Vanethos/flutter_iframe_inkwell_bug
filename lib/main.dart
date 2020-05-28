import 'dart:html';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () => print("Yey"),
              child: Container(
                width: 200,
                height: 100,
                color: Colors.red,
              ),
            ),
            Expanded(
              child: WebsiteRendererWidget(
                viewId: "viewId",
                url: 'https://flutter.dev',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WebsiteRendererWidget extends StatefulWidget {
  final String url;
  final String viewId;

  const WebsiteRendererWidget({
    Key key,
    this.url,
    this.viewId,
  }) : super(key: key);

  @override
  _WebsiteRendererWidgetState createState() => _WebsiteRendererWidgetState();
}

class _WebsiteRendererWidgetState extends State<WebsiteRendererWidget> {
  @override
  Widget build(BuildContext context) {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(widget.viewId,
        (int createdViewId) {
      final elem = IFrameElement()
        ..src = widget.url
        ..id = widget.viewId
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.border = 'none';

      return elem;
    });

    return HtmlElementView(viewType: widget.viewId);
  }
}
