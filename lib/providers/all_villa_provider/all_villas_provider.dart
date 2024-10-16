import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VillasProvider with ChangeNotifier {
  final CollectionReference _villasCollection =
  FirebaseFirestore.instance.collection('all_villas');
  final CollectionReference _topVillasCollection =
  FirebaseFirestore.instance.collection('top_villas');

  List<Map<String, dynamic>> villas = [];
  Set<String> topVillaIds = {};

  VillasProvider() {
    fetchVillas();
    fetchTopVillas();
  }

  Future<void> fetchVillas() async {
    try {
      QuerySnapshot snapshot = await _villasCollection.get();
      villas = snapshot.docs.map((doc) {
        // Explicitly convert the document data to Map<String, dynamic>
        final Map<String, dynamic> villaData = Map<String, dynamic>.from(doc.data() as Map);
        return {'id': doc.id, ...villaData};
      }).toList();
      notifyListeners();
    } catch (e) {
      print('Error fetching villas: $e');
    }
  }

  Future<void> fetchTopVillas() async {
    try {
      QuerySnapshot snapshot = await _topVillasCollection.get();
      topVillaIds =
          snapshot.docs.map((doc) => doc.id).toSet(); // Store IDs of top villas
      notifyListeners();
    } catch (e) {
      print('Error fetching top villas: $e');
    }
  }

  Future<void> toggleTopVilla(String villaId, Map<String, dynamic> villaData, bool isSelected) async {
    try {
      final topVillasCollection = FirebaseFirestore.instance.collection('top_villas');

      // Fetch current top_villas to check the count
      final QuerySnapshot snapshot = await topVillasCollection.get();
      final int topVillasCount = snapshot.size;

      if (isSelected) {
        // If selecting, ensure the limit of 5 villas
        if (topVillasCount < 5) {
          await topVillasCollection.doc(villaId).set(villaData);
          Fluttertoast.showToast(msg: 'Villa added to Top Villas');
        } else {
          Fluttertoast.showToast(msg: 'Maximum 5 villas can be added to Top Villas');
        }
      } else {
        // If deselecting, remove the villa from top_villas
        await topVillasCollection.doc(villaId).delete();
        Fluttertoast.showToast(msg: 'Villa removed from Top Villas');
      }

      // Update the toggle state and refresh the list
      fetchVillas(); // Refresh the villas list to update the UI after changes
    } catch (e) {
      print('Error updating top villa status: $e');
      Fluttertoast.showToast(msg: 'Error updating top villa status');
    }
  }

  Future<void> deleteVilla(String id) async {
    try {
      await _villasCollection.doc(id).delete();
      await FirebaseFirestore.instance
          .collection('villa_details')
          .doc(id)
          .delete();
      villas.removeWhere((villa) => villa['id'] == id);
      // Also remove from top_villas if it exists there
      await _topVillasCollection.doc(id).delete();
      topVillaIds.remove(id);
      notifyListeners();
    } catch (e) {
      print('Error deleting villa: $e');
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }
}
