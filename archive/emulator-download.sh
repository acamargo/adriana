adb root
adb shell 'ls /data/user/0/com.example.adriana/app_flutter/*match*' | tr -d '\r' | xargs -n1 adb pull
