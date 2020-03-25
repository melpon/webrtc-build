# 変更履歴

- UPDATE
    - 下位互換がある変更
- ADD
    - 下位互換がある追加
- CHANGE
    - 下位互換のない変更
- FIX
    - バグ修正

## master

- [FIX] enable_libaom_decoder=false にする
    - @tnoho @melpon
- [FIX] enable_libaom_decoder は deprecated なので enable_libaom=false にする
    - @melpon
- [FIX] ubuntu-18.04_armv8 の rootfs が Ubuntu 16.04 になっていたのを修正
    - @melpon

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