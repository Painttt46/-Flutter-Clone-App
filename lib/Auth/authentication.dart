import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class FirebaseAuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Getter for current user

  User? get currentUser => _auth.currentUser;

  // Stream for auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user; // Return the signed-in user
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuth exceptions
      handleFirebaseAuthError(e);
      return null;
    } catch (e) {
      // Handle other exceptions
      print("An unexpected error occurred: $e");
      return null;
    }
  }

  void handleFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case "weak-password":
        print("The password is too weak.");
        break;
      case "email-already-in-use":
        print("The email address is already in use by another user.");
        break;
      case "invalid-email":
        print("The email address is invalid.");
        break;
      case "user-not-found":
        print("The user account does not exist.");
        break;
      case "wrong-password":
        print("The password is incorrect.");
        break;
      default:
        print("An unknown error occurred: ${e.code}");
    }
  }

  Future Update_User(
    String ID_book,String Name
  ) async {
    try {
      DateTime data = new DateTime.now();
      await _firestore
          .collection('user')
          .doc(_auth.currentUser!.uid)
          .collection('status_user')
          .doc('Status_check')
          .set(
        {
          'time': '${data.day}:${data.hour}:${data.minute}',
          'Name':Name,
          'ID_book': ID_book,
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Future Update_Book(String collec, String book_id, bool status) async {
    try {
      await _firestore.collection(collec).doc(book_id).update({
        'status': status,
      });
    } catch (e) {
      print(e);
    }
  }

  Future Update_user1(bool status) async {
    try {
      await _firestore.collection('user').doc(_auth.currentUser!.uid).update({
        'have_book': status,
      });
    } catch (e) {
      print(e);
    }
  }

  Future Update_User_board(
    String ID_boardgame,String Name
  ) async {
    try {
      DateTime data = new DateTime.now();
      await _firestore
          .collection('user')
          .doc(_auth.currentUser!.uid)
          .collection('status_user')
          .doc('Status_boardgame')
          .set(
        {
          'time': '${data.day}:${data.hour}:${data.minute}',
          'Name':Name,
          'ID_boardgame': ID_boardgame,
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Future Update_Board(String collec, String book_id, bool status) async {
    try {
      await _firestore.collection(collec).doc(book_id).update({
        'status': status,
      });
    } catch (e) {
      print(e);
    }
  }

  Future Update_user_board1(bool status) async {
    try {
      await _firestore.collection('user').doc(_auth.currentUser!.uid).update({
        'have_boardgame': status,
      });
    } catch (e) {
      print(e);
    }
  }

  Future Update_user_room(
    String ID_room,String Name
  ) async {
    try {
      DateTime data = new DateTime.now();
      await _firestore
          .collection('user')
          .doc(_auth.currentUser!.uid)
          .collection('status_user')
          .doc('Status_room')
          .set(
        {
          'time': '${data.day}:${data.hour}:${data.minute}',
          'ID_room': ID_room,
          'Name' : Name,
        },
      );
    } catch (e) {
      print(e);
    }
  }
  Future Update_user_room2(
    bool have_room,
  ) async {
    try {
      DateTime data = new DateTime.now();
      await _firestore
          .collection('user')
          .doc(_auth.currentUser!.uid)
          .update(
        {
          'have_room': have_room,
        },
      );
    } catch (e) {
      print(e);
    }
  }
  Future Update_user_room3(
    String Troom,bool Troom1 , String ID_room, 
  ) async {
    try {
      DateTime data = new DateTime.now();
      await _firestore
          .collection('room')
          .doc(ID_room)
          .update(
        {
          '$Troom': Troom1,
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Future<bool> AddNote(String title, String subtitle) async {
    try {
      var uuid = Uuid().v4();
      await _firestore
          .collection('feedback')
          .doc(uuid)
          .set({
        'title': title,
        'subtitle': subtitle,
      });
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  
Future Vote(
    bool vote,
  ) async {
    try {
      await _firestore
          .collection('user')
          .doc(_auth.currentUser!.uid)
          .update(
        {
          'have_vote_movie': vote,
        },
      );
    } catch (e) {
      print(e);
    }
  }
  Future Vote1(
    String ID_movie,
  ) async {
    try {
      await _firestore
          .collection('movieselect')
          .doc(ID_movie)
          .update(
        {
          'vote': FieldValue.increment(1) ,
        },
      );
    } catch (e) {
      print(e);
    }
  }

   String userid(){
    return _auth.currentUser!.uid ;
  }
}
