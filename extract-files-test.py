#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: 2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

from extract_utils.fixups_blob import (
    blob_fixup,
    blob_fixups_user_type,
)
from extract_utils.fixups_lib import (
    lib_fixups,
    lib_fixups_user_type,
)
from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

namespace_imports = [
    'hardware/oplus',
    'hardware/qcom-caf/common/libqti-perfd-client',
    'hardware/qcom-caf/sm8350',
    'hardware/qcom-caf/wlan',
    'vendor/qcom/opensource/commonsys-intf/display',
    'vendor/qcom/opensource/commonsys/display',
    'vendor/qcom/opensource/dataservices',
    'vendor/qcom/opensource/display',
]


def lib_fixup_vendor_suffix(lib: str, partition: str, *args, **kwargs):
    return f'{lib}-vendor' if partition in ['odm', 'vendor'] else None


lib_fixups: lib_fixups_user_type = {
    **lib_fixups,
    (
        'com.qualcomm.qti.dpm.api@1.0',
        'libmmosal',
        'vendor.qti.hardware.wifidisplaysession@1.0',
        'vendor.qti.imsrtpservice@3.0',
    ): lib_fixup_vendor_suffix,
}


blob_fixups: blob_fixups_user_type = {
    # common blob fixups
    'odm/bin/hw/vendor-oplus-hardware-performance-V1-service': blob_fixup()
        .add_needed('libbase_shim.so')
        .add_needed('libprocessgroup_shim.so'),

    ('odm/lib64/mediadrm/libwvdrmengine.so', 'odm/lib64/libwvhidl.so'): blob_fixup()
        .add_needed('libcrypto_shim.so'),

    'odm/lib64/vendor.oplus.hardware.urcc-V1-ndk_platform.so': blob_fixup()
        .add_needed('libjsoncpp_shim.so'),

    'product/etc/sysconfig/com.android.hotwordenrollment.common.util.xml': blob_fixup()
        .regex_replace('/my_product', '/product'),

    ('vendor/etc/media_blair/video_system_specs.json',
     'vendor/etc/media_holi/video_system_specs.json'): blob_fixup()
        .regex_replace('"max_retry_alloc_output_timeout": 10000,',
                       '"max_retry_alloc_output_timeout": 0,'),

    'system_ext/lib64/libwfdnative.so': blob_fixup()
        .add_needed('libinput_shim.so'),

    (
        'vendor/lib64/libdpps.so',
        'vendor/lib64/libsnapdragoncolor-manager.so',
    ): blob_fixup()
        .replace_needed('libtinyxml2.so', 'libtinyxml2-v34.so'),

    # device blob fixups
    'odm/lib64/libAlgoProcess.so': blob_fixup()
        .replace_needed(
            'android.hardware.graphics.common-V1-ndk_platform.so',
            'android.hardware.graphics.common-V7-ndk.so'
        ),

    (
        'odm/lib/liblvimfs_wrapper.so',
        'odm/lib64/libCOppLceTonemapAPI.so',
        'odm/lib64/libaps_frame_registration.so',
        'odm/lib64/libYTCommon.so'
    ): blob_fixup()
        .replace_needed('libstdc++.so', 'libstdc++_vendor.so'),
}  # fmt: skip


module = ExtractUtilsModule(
    'oscaro',
    'oneplus',
    namespace_imports=namespace_imports,
    blob_fixups=blob_fixups,
    lib_fixups=lib_fixups,
    add_firmware_proprietary_file=True,
)


if __name__ == '__main__':
    utils = ExtractUtils.device(module)
    utils.run()
