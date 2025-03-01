import 'package:edu_bridge_app/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Method to add a new user to the database
  Future<bool> addUser(UserModel userModel) async {
    try {
      // Inserting the user into the "users" table
      await _supabase.from("users").insert(userModel.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  // Method to fetch all users from the database
  Future<List<UserModel>> fetchUsers() async {
    final response = await _supabase.from("users").select();
    return response.map((data) => UserModel.fromMap(data)).toList();
  }

  // Method to fetch a user by their ID
  Future<UserModel?> fetchUserById(String id) async {
    final response =
        await _supabase.from("users").select().eq('id', id).single();
    if (response != null) {
      return UserModel.fromMap(response);
    } else {
      return null;
    }
  }

  // Method to update user information
  Future<bool> updateUser(UserModel userModel) async {
    try {
      await _supabase
          .from("users")
          .update(userModel.toMap())
          .eq('id', userModel.id!);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Method to delete a user by their ID
  Future<bool> deleteUser(String id) async {
    try {
      await _supabase.from("users").delete().eq('id', id);
      return true;
    } catch (e) {
      return false;
    }
  }
}
