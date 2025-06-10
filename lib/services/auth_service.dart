import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user/token_dto.dart';
import '../models/user/user_info_dto.dart';
import '../models/user/user_login_dto.dart';
import '../models/user/user_register_dto.dart';
import '../models/note/note_create_dto.dart';
import '../models/note/note_info_dto.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;

  AuthService._internal();

  final String _baseUrl = 'http://localhost:5097/api';
  String? _token;
  UserInfoDto? _currentUser;

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        if (_token != null) 'Authorization': 'Bearer $_token',
      };

  UserInfoDto? get currentUser => _currentUser;

  void _setToken(String token) {
    _token = token;
  }

  void clearToken() {
    _token = null;
    _currentUser = null;
  }

  // ---------------- Auth ----------------

  Future<void> register(UserRegisterDto dto) async {
    final url = Uri.parse('$_baseUrl/Auth/register');
    final res = await http.post(
      url,
      headers: _headers,
      body: jsonEncode(dto.toJson()),
    );
    if (res.statusCode >= 400) {
      throw Exception('Error al registrar usuario: ${res.body}');
    }
  }

  Future<TokenDto> login(UserLoginDto dto) async {
    final url = Uri.parse('$_baseUrl/Auth/login');
    final res = await http.post(
      url,
      headers: _headers,
      body: jsonEncode(dto.toJson()),
    );
    if (res.statusCode != 200) {
      throw Exception('Login inválido');
    }
    final token = TokenDto.fromJson(jsonDecode(res.body));
    _setToken(token.token);
    return token;
  }

  // ---------------- User ----------------

  Future<UserInfoDto> getProfile({bool forceRefresh = false}) async {
    if (!forceRefresh && _currentUser != null) {
      return _currentUser!;
    }
    print('Headers: $_headers');
    print('Token: $_token');
    final url = Uri.parse('$_baseUrl/Users');
    final res = await http.get(url, headers: _headers);

    print('Response: ${res.statusCode} - ${res.body}');
    if (res.statusCode != 200) {
      throw Exception('No se pudo obtener el perfil');
    }

    _currentUser = UserInfoDto.fromJson(jsonDecode(res.body));
    print('Usuario actual: ${_currentUser!.email}');
    return _currentUser!;
  }

  // ---------------- Notes ----------------

  Future<List<NoteInfoDto>> getBooks() async {
    final url = Uri.parse('$_baseUrl/Notes');
    final res = await http.get(url, headers: _headers);
    if (res.statusCode != 200) {
      throw Exception('Error al obtener libros');
    }
    final List jsonList = jsonDecode(res.body);
    return jsonList.map((e) => NoteInfoDto.fromJson(e)).toList();
  }

  Future<NoteInfoDto> getBook(int id) async {
    final url = Uri.parse('$_baseUrl/Books/$id');
    final res = await http.get(url, headers: _headers);
    if (res.statusCode != 200) {
      throw Exception('Libro no encontrado');
    }
    return NoteInfoDto.fromJson(jsonDecode(res.body));
  }

  Future<NoteInfoDto> createBook(NoteCreateDto dto) async {
    final url = Uri.parse('$_baseUrl/Books');
    final res = await http.post(
      url,
      headers: _headers,
      body: jsonEncode(dto.toJson()),
    );
    if (res.statusCode != 201) {
      throw Exception('Error al crear notas');
    }
    return NoteInfoDto.fromJson(jsonDecode(res.body));
  }

  Future<void> updateNote(int id, NoteCreateDto dto) async {
    final url = Uri.parse('$_baseUrl/Notes/$id');
    final res = await http.put(
      url,
      headers: _headers,
      body: jsonEncode(dto.toJson()),
    );
    if (res.statusCode != 204) {
      throw Exception('Error al actualizar apuntes');
    }
  }

  Future<void> deleteBook(int id) async {
    final url = Uri.parse('$_baseUrl/Notes/$id');
    final res = await http.delete(url, headers: _headers);
    if (res.statusCode != 204) {
      throw Exception('Error al eliminar apuntes'); 
    }
  }
}
