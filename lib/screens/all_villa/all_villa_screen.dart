import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/all_villa_provider/all_villas_provider.dart';

class AllVillaScreen extends StatefulWidget {
  const AllVillaScreen({super.key});

  @override
  State<AllVillaScreen> createState() => _AllVillaScreenState();
}

class _AllVillaScreenState extends State<AllVillaScreen> {

  @override
  void initState() {
    // _loadTopVillas();
    super.initState();
  }

  _loadTopVillas() async {
    Future.delayed(Duration(seconds: 2), () => Provider.of<VillasProvider>(context).fetchTopVillas());
  }

  @override
  Widget build(BuildContext context) {
    final villasProvider = Provider.of<VillasProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('All Villas'),
      ),
      body: villasProvider.villas.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: villasProvider.villas.length,
        itemBuilder: (context, index) {
          final villa = villasProvider.villas[index];
          final isTopVilla = villasProvider.topVillaIds.contains(villa['id']);

          return ListTile(
            leading: villa['img_url'] != null
                ? Image.network(
              villa['img_url'],
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            )
                : Icon(Icons.image, size: 60),
            title: Text(villa['name']),
            subtitle: Text('Location: ${villa['location']} - Price: \$${villa['price']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    // Navigate to the edit page with villa ID
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => EditVillaPage(villaId: villa['id']),
                    //   ),
                    // );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    final confirm = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Delete Villa'),
                        content: Text('Are you sure you want to delete this villa?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: Text('Delete', style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true) {
                      villasProvider.deleteVilla(villa['id']);
                    }
                  },
                ),
                Switch(
                  value: isTopVilla,
                  onChanged: (value) {
                    villasProvider.toggleTopVilla(villa['id'], villa, value);
                  },
                  activeColor: Colors.green,
                  inactiveThumbColor: Colors.grey,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
