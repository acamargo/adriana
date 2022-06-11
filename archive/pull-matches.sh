DEVICE="0009502a207d4f"
adb -s $DEVICE root
adb -s $DEVICE shell 'ls /data/user/0/com.example.adriana/app_flutter/*.match.*' | tr -d '\r' | sed -e 's/^\///' | xargs -n1 adb -s $DEVICE pull
