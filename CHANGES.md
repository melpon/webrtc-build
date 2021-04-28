# 変更履歴

- UPDATE
    - 下位互換がある変更
- ADD
    - 下位互換がある追加
- CHANGE
    - 下位互換のない変更
- FIX
    - バグ修正

VERSION ファイルを上げただけの場合は変更履歴記録は不要。
パッチやビルドの変更のみ記録すること。

## master

- [ADD] iOS にサイマルキャスト対応のパッチを追加
    - @szktty @enm10k

## m89.4389.5.6

- [ADD] Android にサイマルキャスト対応のパッチを追加
    - @szktty @enm10k

## m89.4389.5.5

- [FIX] Android で SEGV することがあるのを修正
    - @melpon

## m89.4389

- [CHANGE] ubuntu-18.04_armv8 向けに `libjpeg_mangle.patch` を追加
    - @tnoho @melpon

## m88.4324.3.1

- [ADD] Apple Silicon 用ビルド (macos_arm64) を追加
    - @hakobera
- [CHANGE] Apple Silicon 対応に伴い、既存の macos を macos_x86_64 に変更する
    - @hakobera

## m88.4324.0.0

- [CHANGE] Linux の x86_64 にも `rtc_use_pipewire=false` を設定
    - @melpon
- [FIX] armv6用パッチの修正
    - @melpon

## m86.4240.1.2 (2020/8/31)

- [ADD] centos-8_x86_64 ビルドを追加
    - @melpon

- [FIX] macOS でサイマルキャストを行うとセグフォが起きていたのを修正
    - @melpon

## m84.4147.11.3 (2020/8/12)

- [FIX] Windows に NOTICE ファイルが入っていなかったのを修正
    - @melpon

## m84.4147.11.2 (2020/8/9)

- [ADD] iOS 用のパッチを追加
    - @melpon

## m84.4147.11.1 (2020/8/5)

- [ADD] iOS 用ビルドを追加
    - @melpon

## m84.4147.7.3 (2020/6/23)

- [FIX] macOS 版の .a 内のファイル名が15文字で切られていたのを修正
    - @melpon

## m84.4147.7.2 (2020/6/16)

- [ADD] raspberry-pi-os_armv8 を追加
    - @melpon

## m84.4147.7.0 (2020/6/15)

- [CHANGE] raspbian-buster を raspberry-pi-os に変更する
    - @melpon

## m83.4103.12.2 (2020/5/26)

- [ADD] AAR パッケージの削除処理を Revert して Android に AAR を追加する
    - @enm10k

## m83.4103.12.1 (2020/5/16)

- [ADD] Android 用ビルドを追加
    - @melpon

## m83.4103.9.0

- [UPDATE] WebRTC のバージョンを 4103@{#9} に上げる
    - @voluntas

## m83.4103.2.0

- [UPDATE] WebRTC のバージョンを 4103@{#2} に上げる
    - @voluntas

## m81.4044.13.2

m81.4044.13.0,1 はリリースミスのためスキップ。

- [UPDATE] ビルド時にライセンスの生成を行う
    - @melpon
- [UPDATE] WebRTC のバージョンを 4044@{#13} にもどす
    - @voluntas

## m81.4044.11.0

- [UPDATE] WebRTC のバージョンを 4044@{#11} に上げる
    - @voluntas

## m81.4044.10.0

- [FIX] enable_libaom_decoder=false にする
    - @tnoho @melpon
- [FIX] enable_libaom_decoder は deprecated なので enable_libaom=false にする
    - @melpon
- [FIX] ubuntu-18.04_armv8 の rootfs が Ubuntu 16.04 になっていたのを修正
    - @melpon
- [UPDATE] WebRTC のバージョンを 4044@{#10} に上げる
    - @voluntas

## m81.4044.9.0

- [UPDATE] WebRTC のバージョンを 4044@{#9} に上げた
    - @voluntas

## m81.4044.7.0

- [UPDATE] WebRTC のバージョンを 4044@{#7} に上げた

## m80.3987.6.0

- [UPDATE] WebRTC のバージョンを 3987@{#6} に上げた

## m80.3987.2.2

- [FIX] Windows 版に 4K パッチが適用されていなかったのを修正

## m80.3987.2.1

- [FIX] Windows 版の VERSIONS ファイルのフォーマットが UTF-8 になっていなかったのを修正

## m80.3987.2.0

- [UPDATE] WebRTC のバージョンを 3987@{#2} に上げた
- [UPDATE] WebRTC バージョンの命名ルールを変更

## m79.5.4

- [ADD] バイナリの `VERSIONS` にいくつかのバージョン情報を追加

## m79.5.3

- [ADD] ubuntu-16.04_x86_64 を追加
- [ADD] ubuntu-16.04_armv7 を追加

## m79.5.2

- [ADD] バイナリにライセンスファイルを追加

## m79.5.1

- [CHANGE] H264 を使わないようにする
