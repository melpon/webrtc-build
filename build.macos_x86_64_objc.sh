#!/bin/bash

cd `dirname $0`
source VERSION
SCRIPT_DIR="`pwd`"

PACKAGE_NAME=macos
SOURCE_DIR="`pwd`/_source/$PACKAGE_NAME"
BUILD_DIR="`pwd`/_build/$PACKAGE_NAME"
PACKAGE_DIR="`pwd`/_package/$PACKAGE_NAME"

set -ex

# ======= ここまでは全ての build.*.sh で共通（PACKAGE_NAME だけ変える）

TARGET_ARCHS="x64"
TARGET_BUILD_CONFIGS="debug release"

./scripts/get_depot_tools.sh $SOURCE_DIR
export PATH="$SOURCE_DIR/depot_tools:$PATH"

./scripts/prepare_webrtc.sh $SOURCE_DIR $WEBRTC_COMMIT

pushd $SOURCE_DIR/webrtc/src
  patch -p2 < $SCRIPT_DIR/patches/4k.patch
  patch -p2 < $SCRIPT_DIR/patches/macos_h264_encoder.patch
  patch -p2 < $SCRIPT_DIR/patches/macos_av1.patch
  patch -p2 < $SCRIPT_DIR/patches/macos_screen_capture.patch
  patch -p1 < $SCRIPT_DIR/patches/macos_simulcast.patch
popd

for build_config in $TARGET_BUILD_CONFIGS; do
  mkdir -p $BUILD_DIR/$build_config
done

# mac用のビルド設定をコピー
cp ./build_macos_libs.sh $SOURCE_DIR/webrtc/src/tools_webrtc/ios/build_macos_libs.sh
cp ./build_macos_libs.py $SOURCE_DIR/webrtc/src/tools_webrtc/ios/build_macos_libs.py

pushd $SOURCE_DIR/webrtc/src
  for build_config in $TARGET_BUILD_CONFIGS; do

    if [ $build_config = "release" ]; then
      _enable_dsyms="false"
    else
      _enable_dsyms="true"
    fi

    ./tools_webrtc/ios/build_macos_libs.sh -o $BUILD_DIR/webrtc/$build_config --build_config $build_config --arch $TARGET_ARCHS --bitcode --extra-gn-args " \
      rtc_libvpx_build_vp9=true \
      rtc_include_tests=false \
      rtc_build_examples=false \
      rtc_use_h264=false \
      use_rtti=true \
      libcxx_abi_unstable=false \
      enable_dsyms=$_enable_dsyms \
    "
    _branch="M`echo $WEBRTC_VERSION | cut -d'.' -f1`"
    _commit="`echo $WEBRTC_VERSION | cut -d'.' -f3`"
    _revision=$WEBRTC_COMMIT
    _maint="`echo $WEBRTC_BUILD_VERSION | cut -d'.' -f4`"

    cat <<EOF > $BUILD_DIR/webrtc/$build_config/WebRTC.framework/build_info.json
{
    "webrtc_version": "$_branch",
    "webrtc_commit": "$_commit",
    "webrtc_maint": "$_maint",
    "webrtc_revision": "$_revision"
}
EOF
  done
popd

pushd $SOURCE_DIR/webrtc/src

  for build_config in $TARGET_BUILD_CONFIGS; do
    _libs=""
    _dirs=""

    if [ $build_config = "release" ]; then
      _is_debug="false"
    else
      _is_debug="true"
    fi

    for arch in $TARGET_ARCHS; do
      gn gen $BUILD_DIR/webrtc/$build_config/${arch}_libs --args="
        target_os=\"mac\"
        target_cpu=\"$arch\"
        is_component_build=false
        mac_deployment_target=\"10.10\"
        rtc_libvpx_build_vp9=true

        is_debug=$_is_debug
        rtc_include_tests=false
        rtc_build_examples=false
        rtc_use_h264=false
        use_rtti=true
        libcxx_abi_unstable=false
      "
      ninja -C $BUILD_DIR/webrtc/$build_config/${arch}_libs
      ninja -C $BUILD_DIR/webrtc/$build_config/${arch}_libs \
        builtin_audio_decoder_factory \
        default_task_queue_factory \
        native_api \
        default_codec_factory_objc \
        peerconnection \
        videocapture_objc \
        mac_framework_objc

      pushd $BUILD_DIR/webrtc/$build_config/${arch}_libs/obj
        /usr/bin/ar -rc $BUILD_DIR/webrtc/$build_config/${arch}_libs/libwebrtc.a `find . -name '*.o'`
        _libs="$_libs $BUILD_DIR/webrtc/$build_config/${arch}_libs/libwebrtc.a"
      popd
      _dirs="$_dirs $BUILD_DIR/webrtc/$build_config/${arch}_libs"
    done
    lipo $_libs -create -output $BUILD_DIR/webrtc/$build_config/libwebrtc.a
  done
  python2 tools_webrtc/libs/generate_licenses.py --target :webrtc $BUILD_DIR/webrtc/ $_dirs
popd

./scripts/package_webrtc_macos.sh $SCRIPT_DIR/static $SOURCE_DIR $BUILD_DIR $PACKAGE_DIR $SCRIPT_DIR/VERSION