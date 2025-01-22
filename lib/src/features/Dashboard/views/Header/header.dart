// body: SafeArea(
// child: Column(
// children: [
// Container(
// padding: EdgeInsets.only(right: 25, left: 25, top: 25),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Text(
// "Home",
// style:
// TextStyle(fontSize: 22, fontWeight: FontWeight.bold ,color: Colors.purple),
// ),
// ElevatedButton.icon(
// onPressed: () => handlerLogout(),
// label: Text("Log"),
// icon: Icon(
// Icons.logout,
// color: Colors.white,
// ),
// style: ElevatedButton.styleFrom(
// backgroundColor: Colors.red,
// foregroundColor: Colors.white),
// )
// ],
// ),
// ),
// Container(
// padding: EdgeInsets.only(right: 25, left: 25, top: 12),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Text(
// "Welcome To , $userRole ",
// style:
// TextStyle(fontSize: 20, fontWeight: FontWeight.bold ,color: Colors.purple),
// ),
// ],
// ),
// ),
// ],
// ),
// ),

// @override
// void initState() {
// _initializeUserData();
// }

//handler Log out
// handlerLogout() async {
// var pref = await SharedPreferences.getInstance();
// pref.setBool(KEYS.isLogin, false);
// pref.remove(KEYS.Name);
// pref.remove(KEYS.Role);
// Navigator.pushNamed(context, ROUTES.login);
// }


// Future<void> getUserData() async {
// var prefs = await SharedPreferences.getInstance();
// setState(() {
// userRole = prefs.getString(KEYS.Role) ?? "No User";
// });
// print(prefs.getBool(KEYS.isLogin));
// print("User Role: $userRole");
// }

// //initialize User Data
// void _initializeUserData() async {
// await getUserData();
// }