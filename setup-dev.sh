sudo haxelib selfupdate
haxelib setup haxe
haxelib install openfl
haxelib install openfl-tools	
haxelib install openfl-native
haxelib install lime
haxelib install lime-tools
haxelib install hxcpp
haxelib install format
haxelib install svg
haxelib install swf
haxelib install xfl
haxelib install nme
haxelib install actuate
haxelib run openfl setup
haxelib run lime setup


# fix for openfl-native

#haxelib git openfl https://github.com/openfl/openfl
#haxelib git lime-tools https://github.com/openfl/lime-tools
#haxelib git hxlibc https://github.com/openfl/hxlibc
#haxelib git lime https://github.com/openfl/lime
#haxelib git lime-build https://github.com/openfl/lime-build
#haxelib install munit
#haxelib install format
#haxelib install svg
#git clone https://github.com/openfl/openfl-validation ~/openfl-validation
#haxelib dev openfl-native $(pwd)

#git clone https://github.com/openfl/openfl-native
#haxelib dev openfl-native openfl-native
#haxelib git lime-build https://github.com/openfl/lime-build
#haxelib run openfl rebuild mac