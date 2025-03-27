import 'dart:io';
import 'package:circlechat_app/data/models/chat_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:circlechat_app/core/errors.dart';
import 'package:circlechat_app/core/locator.dart';
import 'package:circlechat_app/services/logging_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  FirebaseService()
      : _logger = getIt<LoggingService>(),
        super();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _database = FirebaseDatabase.instance.ref();

  final FirebaseStorage _storage = FirebaseStorage.instance;
  final LoggingService _logger;

  // Authentication
  Future<UserCredential> signInWithPhoneNumber(
      String smsCode, String verificationId) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      return await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw AppException(e.message ?? 'Sign-in failed.');
    } catch (e) {
      throw AppException('An unexpected error occurred during sign-in.');
    }
  }

  Future<bool> userDocumentExists(String userId) async {
    try {
      final userDoc = await _firestore.collection('users').doc(userId).get();
      return userDoc.exists;
    } catch (e, stackTrace) {
      _logger.error(
        'Error checking user document existence: $e',
        error: e,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  Future<void> addUserDocument(
      {required String userId,
      required String name,
      required String about,
      String? profileImageUrl,
      String? phoneNumber}) async {
    await _firestore.collection('users').doc(userId).set({
      'name': name,
      'about': about,
      'profileImageUrl': profileImageUrl,
      'phoneNumber': phoneNumber,
      'joinedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateUserDocument(
      {required String userId,
      required Map<String, dynamic> updateData}) async {
    await _firestore.collection('users').doc(userId).update(updateData);
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw AppException(e.message ?? 'Sign-out failed.');
    } catch (e) {
      throw AppException('An unexpected error occurred during sign-out.');
    }
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<void> sendVerificationCode(
    String phoneNumber,
    Function(UserCredential) verificationCompleted,
    Function(AppException) verificationFailed,
    Function(String, int?) codeSent,
    Function(String) codeAutoRetrievalTimeout,
  ) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          UserCredential userCredential =
              await _auth.signInWithCredential(credential);
          verificationCompleted(userCredential);
        },
        verificationFailed: (FirebaseAuthException e) {
          verificationFailed(AppException(e.message ?? 'Verification failed.'));
        },
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } on FirebaseAuthException catch (e) {
      verificationFailed(AppException(e.message ?? 'Verification failed.'));
    } catch (e) {
      verificationFailed(
          AppException('An unexpected error occurred during verification.'));
    }
  }

  // Users
  Future<void> createUserDocument(
      String uid, Map<String, dynamic> userData) async {
    await _firestore.collection('users').doc(uid).set(userData);
  }

  Future<DocumentSnapshot> getUserDocument(String uid) async {
    return await _firestore.collection('users').doc(uid).get();
  }

  Future<void> updateDocument(
      String collection, String docId, Map<String, dynamic> data) async {
    await _firestore.collection(collection).doc(docId).update(data);
  }

  Stream<QuerySnapshot> getCollectionStream(String collection) {
    return _firestore.collection(collection).snapshots();
  }

  Future<void> addDocument(String collection, Map<String, dynamic> data) async {
    await _firestore.collection(collection).add(data);
  }

  Stream<DocumentSnapshot> getDocumentStream(
      String collection, String documentId) {
    return _firestore.collection(collection).doc(documentId).snapshots();
  }

  Stream<DocumentSnapshot> getUserDocumentStream(String userId) {
    return _firestore.collection('users').doc(userId).snapshots();
  }

  // Presence
  Future<void> setUserPresence(
    String userId,
    bool isOnline,
    DateTime lastSeen,
  ) async {
    try {
      await _database.child('presence/$userId').set({
        'isOnline': isOnline,
        'lastSeen': lastSeen.millisecondsSinceEpoch,
      });
    } catch (e) {
      rethrow;
    }
  }

  Stream<DatabaseEvent> getUserPresenceStream(String userId) {
    return _database.child('presence/$userId').onValue;
  }

  // Chats
  Future<List<MessageModel>> getMessages(String chatId) async {
    final snapshot = await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .get();
    return snapshot.docs
        .map((doc) => MessageModel.fromJson(doc.data()))
        .toList();
  }

  Stream<List<MessageModel>> getMessagesStream(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => MessageModel.fromJson(doc.data()))
            .toList());
  }

  Future<void> sendMessage(String chatId, MessageModel message) async {
    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add(message.toJson());

    // Update last message in chat document
    await _firestore.collection('chats').doc(chatId).update({
      'lastMessageText': message.text,
      'lastMessageTimestamp': message.timestamp,
      'lastMessageSenderId': message.senderId,
    });
  }

  Stream<List<ChatModel>> getChatsStream(String userId) {
    return _firestore
        .collection('chats')
        .where('participants', arrayContains: userId)
        .orderBy('lastMessageTimestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChatModel.fromJson(doc.data(), id: doc.id))
            .toList());
  }

  // Storage
  Future<String> uploadFile({
    required File file,
    required String storagePath,
  }) async {
    try {
      UploadTask uploadTask = _storage.ref(storagePath).putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      _logger.error('Error uploading file: $e');
      rethrow;
    }
  }
}
