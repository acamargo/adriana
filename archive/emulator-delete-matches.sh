adb root
#adb shell 'export USER_GROUP=$(stat -c "%U:%G" /data/user/0/com.example.adriana/app_flutter | sed "s/ //g"); echo $USER_GROUP'
#adb shell 'ls -la /data/user/0/com.example.adriana/app_flutter/'
adb shell 'rm /data/user/0/com.example.adriana/app_flutter/*match*'
