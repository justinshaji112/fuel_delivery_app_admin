import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dart/auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// A class to handle Firebase exceptions in a unified way
class FirebaseExceptionHandler {
  /// Handles any Firebase related exception and returns a user-friendly error message
  static String handleException(dynamic exception) {
    if (exception is FirebaseAuthException) {
      return _handleAuthException(exception);
    } else if (exception is FirebaseException) {
      // This covers Firestore, Storage, and other Firebase services
      return _handleFirebaseException(exception);
    } else if (exception is SocketException) {
      return 'Network error. Please check your internet connection.';
    } else {
      return 'An unexpected error occurred: ${exception.toString()}';
    }
  }

  /// Handle Firebase Auth specific exceptions
  static String _handleAuthException(FirebaseAuthException exception) {
    switch (exception.code) {
      // Sign in / Sign up errors
      case 'user-not-found':
        return 'No user found with this email address.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'invalid-email':
        return 'The email address is invalid.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'email-already-in-use':
        return 'An account already exists with this email address.';
      case 'operation-not-allowed':
        return 'This operation is not allowed.';
      case 'weak-password':
        return 'The password is too weak. Please use a stronger password.';
      
      // Account verification errors
      case 'invalid-verification-code':
        return 'The verification code is invalid.';
      case 'invalid-verification-id':
        return 'The verification ID is invalid.';
        
      // Password reset errors
      case 'expired-action-code':
        return 'The action code has expired.';
      case 'invalid-action-code':
        return 'The action code is invalid.';

        
      // Account linking errors
      case 'credential-already-in-use':
        return 'This credential is already associated with another account.';
      case 'requires-recent-login':
        return 'This operation requires recent authentication. Please log in again.';
        
      default:
        return 'Authentication error: ${exception.message ?? exception.code}';
    }
  }

  /// Handle other Firebase exceptions (Firestore, Storage, etc.)
  static String _handleFirebaseException(FirebaseException exception) {
    // Check the service the exception is from
    if (exception.plugin == 'cloud_firestore') {
      return _handleFirestoreException(exception);
    } else if (exception.plugin == 'firebase_storage') {
      return _handleStorageException(exception);
    } else if (exception.plugin == 'firebase_database') {
      return _handleRealtimeDatabaseException(exception);
    } else {
      return 'Firebase error: ${exception.message ?? exception.code}';
    }
  }

  /// Handle Firestore specific exceptions
  static String _handleFirestoreException(FirebaseException exception) {
    switch (exception.code) {
      case 'permission-denied':
        return 'You don\'t have permission to access this resource.';
      case 'not-found':
        return 'The requested document was not found.';
      case 'already-exists':
        return 'The document already exists.';
      case 'failed-precondition':
        return 'Operation failed due to the current state of the system.';
      case 'aborted':
        return 'The operation was aborted.';
      case 'out-of-range':
        return 'Operation was attempted past the valid range.';
      case 'unavailable':
        return 'The service is currently unavailable. Please try again later.';
      case 'data-loss':
        return 'Unrecoverable data loss or corruption.';
      case 'unauthenticated':
        return 'User is not authenticated. Please sign in and try again.';
      case 'resource-exhausted':
        return 'Resource quota exceeded or rate limit reached.';
      case 'cancelled':
        return 'The operation was cancelled.';
      case 'unknown':
        return 'Unknown error occurred.';
      case 'deadline-exceeded':
        return 'Operation timed out. Please try again.';
      default:
        return 'Firestore error: ${exception.message ?? exception.code}';
    }
  }

  /// Handle Firebase Storage specific exceptions
  static String _handleStorageException(FirebaseException exception) {
    switch (exception.code) {
      case 'storage/object-not-found':
        return 'File does not exist.';
      case 'storage/unauthorized':
        return 'You don\'t have permission to access this file.';
      case 'storage/canceled':
        return 'The operation was cancelled.';
      case 'storage/unknown':
        return 'Unknown error occurred during storage operation.';
      case 'storage/retry-limit-exceeded':
        return 'Maximum time limit exceeded. Try again later.';
      case 'storage/invalid-checksum':
        return 'File upload failed due to checksum mismatch.';
      case 'storage/quota-exceeded':
        return 'Storage quota exceeded.';
      case 'storage/unauthenticated':
        return 'User is not authenticated. Please sign in and try again.';
      default:
        return 'Firebase Storage error: ${exception.message ?? exception.code}';
    }
  }

  /// Handle Realtime Database specific exceptions
  static String _handleRealtimeDatabaseException(FirebaseException exception) {
    switch (exception.code) {
      case 'permission-denied':
        return 'You don\'t have permission to access this database path.';
      case 'disconnected':
        return 'Client is disconnected from the Realtime Database.';
      case 'database/network-error':
        return 'A network error occurred. Please check your connection.';
      default:
        return 'Realtime Database error: ${exception.message ?? exception.code}';
    }
  }




}