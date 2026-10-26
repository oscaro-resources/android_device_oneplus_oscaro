# Clone Device repos
git clone https://github.com/oscaro-resources/android_device_oneplus_sm6375-common device/oneplus/sm6375-common
git clone https://github.com/oscaro-resources/android_kernel_oneplus_sm6375.git -b 17.0 kernel/oneplus/sm6375 --depth=1

# Clone sign keys repo
git clone https://github.com/Lunaris-AOSP/vendor_lunaris-priv_keys.git vendor/lunaris-priv/keys

echo ""
if [ -c /dev/tty ]; then
    read -p "Building for oscaro?: (y/n) [default: n]: " choice < /dev/tty
else
    read -p "Building for oscaro?: (y/n) [default: n]: " choice
fi

case "$choice" in
    [yY]*|1)
        echo "Removing existing Dolby,hardware/oplus and vendor/oplus/camera, vendor/oneplus/*..."
        rm -rf hardware/oplus vendor/oplus/camera packages/apps/LunarisDolby vendor/oneplus
        echo "Cloning oscaro repos for hardware/dolby, hardware/oplus, vendor/oplus/camera, vendor/oneplus/*..."
        git clone https://github.com/oscaro-resources/hardware_oplus.git -b 16.2 hardware/oplus
	git clone https://github.com/oscaro-resources/hardware_dolby.git -b lunaris-dolby hardware/dolby
        git clone https://gitlab.com/NoCache-69/proprietary_vendor_oplus_camera.git -b lineage-23.1 vendor/oplus/camera
	git clone https://github.com/oscaro-resources/proprietary_vendor_oneplus_sm6375-common vendor/oneplus/sm6375-common
	git clone https://github.com/oscaro-resources/proprietary_vendor_oneplus_oscaro.git -b 16.2 vendor/oneplus/oscaro
        ;;
    *)
        echo "Skipping oscaro hardware/dolby, hardware/oplus, vendor/oplus/camera, vendor/oneplus/* repos."
        ;;
esac
