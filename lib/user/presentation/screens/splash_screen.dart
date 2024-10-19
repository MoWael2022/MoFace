import 'package:flutter/material.dart';
import 'package:moface/core/service_locator.dart';
import 'package:moface/user/domin/entites/posts/comments/add_comment_data_enter.dart';
import 'package:moface/user/domin/entites/posts/post_data_enter.dart';
import 'package:moface/user/domin/entites/posts/react/react_data_enter.dart';
import 'package:moface/user/domin/entites/user_data_for_login.dart';
import 'package:moface/user/domin/entites/user_data_for_register.dart';
import 'package:moface/user/domin/entites/posts/user_view_posts.dart';
import 'package:moface/user/domin/usecase/base_user_usecase.dart';
import 'package:moface/user/domin/usecase/refresh_token_usecase.dart';
import 'package:moface/user/domin/usecase/register_usecase.dart';
import 'package:moface/user/domin/usecase/update_post_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/router.dart';
import '../../domin/usecase/add_post_usecase.dart';
import '../../domin/usecase/comments_usecase.dart';
import '../../domin/usecase/ensure_token_validation_usecase.dart';
import '../../domin/usecase/login_usecase.dart';
import '../../domin/usecase/logout_usecase.dart';
import '../../domin/usecase/reacts_manager_usercase.dart';
import '../../domin/usecase/view_all_user_post_usecase.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  getRegisterData() async {
    final data = instance<RegisterUseCase>();
    final result = await data.call(const UserDataForRegister(
        userName: "mohamedwaelabdo",
        email: "mohamedwaelabdok@gmail.com",
        password: "Mohamed@12345678",
        confirmPassword: "Mohamed@12345678"));
    result.fold((l) => print(l.messageError), (r) => print(r.name));
  }

  getLoginData() async {
    final data = instance<LoginUseCase>();
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    final result = await data.call(const UserDataForLogin(
      email: "rakha@gmail.com",
      password: "Rakha@123",
    ));

    result.fold((l) => print(l.messageError), (r) {
      print(r.name);
      sharedpref.setString("token", r.token);
    });
  }

  refreshToken() async {
    final data = instance<RefreshTokenUseCase>();
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    final result = await data.call(const NoParameter());
    result.fold((l) => print(l), (r) {
      sharedpref.setString("token", r.token);
      print(r.token);
    });
  }

  checkUserToken() async {
    final data = instance<EnsureTokenValidationUseCase>();
    final sharedpref = await SharedPreferences.getInstance();
    String token = sharedpref.getString('token') ?? "no";
    final result = await data.call(token);
    result.fold((l) => print(l), (r) => print(r));
  }

  logout() async {
    final data = instance<LogoutUseCase>();
    final sharedpref = await SharedPreferences.getInstance();
    String token = sharedpref.getString('token') ?? "no";
    final result = await data.call(token);
    result.fold((l) => print(l), (r) => print(r));
  }

  addPost() async {
    final data = instance<AddPostUseCase>();
    final sharedpref = await SharedPreferences.getInstance();
    String token = sharedpref.getString('token') ?? "no";
    final result = await data.call(PostDataEnter(
      token: token,
      userId: "8c9a844e-f445-4de2-9ebb-a9a1324132e7",
      text: "hallo new world",

    ));
    result.fold((l) => print(l), (r) => print(r));
  }

  updatePost() async {
    final data = instance<UpdatePostUseCase>();
    final sharedpref = await SharedPreferences.getInstance();
    String token = sharedpref.getString('token') ?? "no";
    final result = await data.call(PostDataEnterForUpdate(
      token: token,
      postId: 1,
      userId: "8c9a844e-f445-4de2-9ebb-a9a1324132e7",
      text: "hallo new world",
      image: '',
    ));
    result.fold((l) => print(l), (r) => print(r));
  }

  viewUserPost() async {
    final data = instance<ViewAllUserPostUseCase>();
    final sharedpref = await SharedPreferences.getInstance();
    String token = sharedpref.getString('token') ?? "no";
    final result = await data.call(UserPostDataEnter(
      token: token,
      userId: "8c9a844e-f445-4de2-9ebb-a9a1324132e7",
    ));
    result.fold((l) => print(l), (r) => print(r));
  }

  addComment() async {
    final data = instance<AddCommentUseCase>();
    final sharedpref = await SharedPreferences.getInstance();
    String token = sharedpref.getString('token') ?? "no";
    final result = await data.call(AddCommentDataEnter(
      comment: "cool bro",
      postId: 1,
      userId: "8c9a844e-f445-4de2-9ebb-a9a1324132e7",
      token: token,
      commentId: 1,
    ));
    result.fold((l) => print(l), (r) => print(r));
  }

  updateComment() async {
    final data = instance<UpdateCommentUseCase>();
    final sharedpref = await SharedPreferences.getInstance();
    String token = sharedpref.getString('token') ?? "no";
    final result = await data.call(AddCommentDataEnter(
      comment: "cool bro",
      postId: 1,
      userId: "8c9a844e-f445-4de2-9ebb-a9a1324132e7",
      token: token,
      commentId: 2,
    ));
    result.fold((l) => print(l), (r) => print(r));
  }

  deleteComment() async {
    final data = instance<DeleteCommentUseCase>();
    final sharedpref = await SharedPreferences.getInstance();
    String token = sharedpref.getString('token') ?? "no";
    final result = await data.call(AddCommentDataEnter(
      comment: null,
      postId: 1,
      userId: "8c9a844e-f445-4de2-9ebb-a9a1324132e7",
      token: token,
      commentId: 2,
    ));
    result.fold((l) => print(l), (r) => print(r));
  }

  addReact() async {
    final data = instance<AddReactUseCase>();
    final sharedpref = await SharedPreferences.getInstance();
    String token = sharedpref.getString('token') ?? "no";
    final result = await data.call(ReactDataEnter(
        userId: "8c9a844e-f445-4de2-9ebb-a9a1324132e7",
        postId: 2,
        token: token));
    result.fold((l) => print(l), (r) => print(r));
  }

  deleteReact() async {
    final data = instance<DeleteReactUseCase>();
    final sharedpref = await SharedPreferences.getInstance();
    String token = sharedpref.getString('token') ?? "no";
    final result = await data.call(ReactDataEnter(
        userId: "8c9a844e-f445-4de2-9ebb-a9a1324132e7",
        postId: 2,
        token: token));
    result.fold((l) => print(l), (r) => print(r));
  }

  getPost() async {
    // final data = instance<GetPostDataUseCase>();
    // final sharedpref = await SharedPreferences.getInstance();
    // String token = sharedpref.getString('token') ?? "no";
    // final result = await data.call(GetPostDataEnter(token: token, id: 1));
    // result.fold((l) => print(l), (r) => print(r));
  }


  @override
  void initState() {
    //getLoginData();
    //refreshToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Routers.main);
              },
              child: const Text("home page"),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                getRegisterData();
              },
              child: const Text("register"),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                getLoginData();
              },
              child: const Text("login"),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                refreshToken();
              },
              child: const Text("refresh Token"),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                checkUserToken();
              },
              child: const Text("check Token"),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                logout();
              },
              child: const Text("logout"),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                bool? isSignIn = prefs.getBool("isSignIn");
                if (isSignIn == null || !isSignIn) {
                  Navigator.of(context).pushNamed(Routers.login);
                } else {
                  Navigator.of(context).pushNamed(Routers.main);
                }
              },
              child: const Text("login page"),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                addPost();
              },
              child: const Text("add post"),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                updatePost();
              },
              child: const Text("update post"),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                viewUserPost();
              },
              child: const Text("view posts"),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                addComment();
              },
              child: const Text("add comment"),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                updateComment();
              },
              child: const Text("update comment"),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                deleteComment();
              },
              child: const Text("delete comment"),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                addReact();
              },
              child: const Text("Add react "),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                deleteReact();
              },
              child: const Text("delete react"),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                getPost();
              },
              child: const Text("get Posts"),
            ),
          ),
        ],
      ),
    );
  }
}
