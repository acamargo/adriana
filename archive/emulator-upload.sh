adb root
for i in *.json; do echo $i; adb push "$i" /data/user/0/com.example.adriana/app_flutter/; done;
adb shell "chown u0_a84.u0_a84 /data/user/0/com.example.adriana/app_flutter/*.json"
