import 'package:flutter/material.dart';
import 'package:furiagg/abas/abasComunidades.dart';
import 'package:furiagg/abas/abasConversas.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("FuriaGG"),
        bottom: TabBar(
          indicatorWeight: 4,
          labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          controller: _tabController,
          indicatorColor: const Color.fromARGB(255, 114, 114, 114),
          tabs: <Widget>[Tab(text: "Mensagens"), Tab(text: "Comunidades")],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[Abasconversas(), Abascomunidades()],
      ),
    );
  }
}
