# Clone Device repos
git clone https://github.com/oscaro-resources/android_device_oneplus_sm6375-common device/oneplus/sm6375-common
git clone https://github.com/oscaro-resources/proprietary_vendor_oneplus_sm6375-common vendor/oneplus/sm6375-common
git clone https://github.com/oscaro-resources/proprietary_vendor_oneplus_oscaro.git -b 16.2 vendor/oneplus/oscaro
git clone https://github.com/oscaro-resources/android_kernel_oneplus_sm6375.git -b 16.2 kernel/oneplus/sm6375 --depth=1
git clone https://github.com/oscaro-resources/hardware_dolby.git -b lunaris-dolby hardware/dolby
git clone https://github.com/AxionAOSP/android_packages_apps_ViPER4AndroidFX.git -b v4a packages/apps/ViPER4AndroidFX

# Clone sign keys repo
git clone https://github.com/Lunaris-AOSP/vendor_lunaris-priv_keys.git vendor/lunaris-priv/keys

echo ""
echo "Select option for oscaro tree:"
echo "1) oscaro"
echo "2) dodge"
if [ -c /dev/tty ]; then
    read -p "Enter choice (oscaro/dodge) [default: dodge]: " choice < /dev/tty
else
    read -p "Enter choice (oscaro/dodge) [default: dodge]: " choice
fi

case "$choice" in
    [oO]*|1)
        echo "Removing existing hardware/oplus and vendor/oplus/camera..."
        rm -rf hardware/oplus vendor/oplus/camera
        echo "Cloning oscaro repos for hardware/oplus & vendor/oplus/camera..."
        git clone https://github.com/oscaro-resources/hardware_oplus.git -b 16.2 hardware/oplus
        git clone https://gitlab.com/NoCache-69/proprietary_vendor_oplus_camera.git -b lineage-23.1 vendor/oplus/camera
        ;;
    *)
        echo "Skipping oscaro hardware/oplus & vendor/oplus/camera repos."
        ;;
esac
