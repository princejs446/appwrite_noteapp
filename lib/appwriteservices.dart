
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

class AppwriteServices{
  late Client client;

  late Databases databases;

  static const endpoint ="https://cloud.appwrite.io/v1";
  static const projectId ="673bf763002a9099d541";
  static const databaseId ="673bf7e500389c623379";
  static const collectionId ="673bf7f6002331ee6c48";


AppwriteServices(){
  client=Client();
  client.setEndpoint(endpoint);
  client.setProject(projectId);
  databases=Databases(client);
}
 Future<List<Document>> getNotes() async {
    try {
      final result = await databases.listDocuments(
        collectionId: collectionId,
        databaseId: databaseId,
      );
      return result.documents;
    } catch (e) {
      print('Error loading tasks: $e');
      rethrow;
    }
 }

  Future<Document> addNote(String title,String subtitle,String category,String date) async {
    try {
      final documentId = ID.unique(); 

      final result = await databases.createDocument(
        collectionId: collectionId,
        databaseId: databaseId,
        data: {
          'title': title,
          'subtitle':subtitle,
          'category':category,
          'date':date,
        },
        documentId: documentId,
      );
      return result;
    } catch (e) {
      print('Error creating task: $e');
      rethrow;
    }
  }
Future<void>deleteNote(String documentId)async{
  try{
    await databases.deleteDocument(
      collectionId:collectionId,
      documentId:documentId,
      databaseId:databaseId,
    );
  }catch (e){
    print('Error deleting task:$e');
    rethrow;
  }
}
}