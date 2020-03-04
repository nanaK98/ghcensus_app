import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ghcensus_app/models/census_model.dart';

class DatabaseService{
  final String uid;
  DatabaseService({this.uid});
  //collection refference
  final CollectionReference CensusCollection = Firestore.instance.collection('census');

  Future updateUserData(String firstname, String lastname,String email,String address, int age, String region) async{
    return await CensusCollection.document().setData({
      'firstname': firstname,
      'lastname': lastname,
      'email' : email,
      'address' : address,
      'age' : age,
      'region' : region,
    });
  }
  //census list from snapshot
  List<census_model> _censusListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return census_model(
        firstname:doc.data['firstname'] ?? '',
        lastname:doc.data['lastname'] ?? '',
        email:doc.data['email'] ?? '',
        address:doc.data['address'] ?? '',
        age:doc.data['age'] ?? 0,
        region:doc.data['region'] ?? '',

      );
    }).toList();
  }

  //get Census stream
  Stream<List<census_model>> get census{
    return CensusCollection.snapshots()
    .map(_censusListFromSnapshot);
  }
}