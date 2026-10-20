# Hướng dẫn Build APK và Cài đặt ứng dụng VIEN trên Android

Tài liệu này hướng dẫn chi tiết từ bước chuẩn bị môi trường, lệnh build APK (Release, Debug, Split-per-ABI) cho đến các cách cài đặt ứng dụng **VIEN** trên thiết bị Android thực tế.

---

## 📑 Mục lục

1. [Chuẩn bị môi trường (Prerequisites)](#1-chuẩn-bị-môi-trường-prerequisites)
2. [Cập nhật Icon ứng dụng](#2-cập-nhật-icon-ứng-dụng)
3. [Lệnh Build File APK](#3-lệnh-build-file-apk)
4. [Vị trí file APK sau khi build](#4-vị-trí-file-apk-sau-khi-build)
5. [Hướng dẫn cài đặt APK lên điện thoại Android](#5-hướng-dẫn-cài-đặt-apk-lên-điện-thoại-android)
   - [Cách 1: Cài đặt nhanh qua cáp USB bằng lệnh ADB (Khuyên dùng cho Dev)](#cách-1-cài-đặt-nhanh-qua-cáp-usb-bằng-lệnh-adb-khuyên-dùng-cho-dev)
   - [Cách 2: Chép file APK trực tiếp vào điện thoại](#cách-2-chép-file-apk-trực-tiếp-vào-điện-thoại)
6. [Cấu hình Ký ứng dụng (Signing Keystore - Tùy chọn Release Production)](#6-cấu-hình-ký-ứng-dụng-signing-keystore---tùy-chọn-release-production)
7. [Các lỗi thường gặp & Cách khắc phục (Troubleshooting)](#7-các-lỗi-thường-gặp--cách-khắc-phục-troubleshooting)

---

## 1. Chuẩn bị môi trường (Prerequisites)

Để build được file APK cho Android, máy tính của bạn cần có:

### 1.1. Java Development Kit (JDK 17)
- Flutter và Gradle hiện tại yêu cầu **JDK 17**.
- Bạn có thể tải [OpenJDK 17](https://adoptium.net/temurin/releases/?version=17) hoặc cài qua winget:
  ```powershell
  winget install EclipseAdoptium.Temurin.17.JDK
  ```
- Kiểm tra bằng lệnh:
  ```bash
  java -version
  ```

### 1.2. Android SDK & Android Studio
1. Tải và cài đặt **[Android Studio](https://developer.android.com/studio)**.
2. Mở Android Studio > **More Actions** > **SDK Manager**:
   - Tab **SDK Platforms**: Tích chọn ít nhất **Android 14 (API 34)** hoặc phiên bản mới nhất.
   - Tab **SDK Tools**: Tích chọn:
     - **Android SDK Build-Tools**
     - **Android SDK Command-line Tools (latest)**
     - **Android SDK Platform-Tools**
3. Cấu hình biến môi trường (Environment Variables) trên Windows:
   - Biến `ANDROID_HOME`: trỏ tới thư mục SDK, thường là `C:\Users\<Tên_User>\AppData\Local\Android\Sdk`.
   - Thêm vào biến `Path`:
     - `%ANDROID_HOME%\platform-tools`
     - `%ANDROID_HOME%\cmdline-tools\latest\bin`
4. Cấp phép bản quyền Android SDK (Licenses):
   ```bash
   flutter doctor --android-licenses
   ```
   *(Bấm `y` để đồng ý với tất cả điều khoản)*.

### 1.3. Kiểm tra bằng Flutter Doctor
Chạy lệnh:
```bash
flutter doctor
```
Đảm bảo mục **Flutter** và **Android toolchain** đều hiển thị dấu tích xanh `[√]`.

---

## 2. Cập nhật Icon ứng dụng

Project đã được cấu hình sẵn bộ icon chất lượng cao tại thư mục `assets/icon/`:
- `assets/icon/app_icon.png` (Master Icon 1024x1024)
- `assets/icon/app_icon_foreground.png` (Adaptive Icon Foreground)

Nếu bạn thay đổi ảnh icon hoặc muốn cập nhật lại toàn bộ các thư mục mipmap/drawable của Android, chạy lệnh:
```bash
dart run flutter_launcher_icons
```

---

## 3. Lệnh Build File APK

Mở Terminal tại thư mục gốc của project `vien`:

### 3.1. Build APK Release hoàn chỉnh (Universal Fat APK)
Đây là cách phổ biến nhất để gửi file cho người khác cài đặt. File APK này tích hợp mã nhị phân cho mọi kiến trúc chip (arm64-v8a, armeabi-v7a, x86_64), chạy được trên hầu hết mọi điện thoại Android:

```bash
flutter build apk --release
```

### 3.2. Build APK tối ưu dung lượng (Split per ABI - Khuyên dùng)
Lệnh này sẽ tách riêng từng file APK cho từng dòng chip, giúp giảm kích thước file APK xuống đáng kể (giảm khoảng 40-60% dung lượng):

```bash
flutter build apk --release --split-per-abi
```

Sau khi build xong, hệ thống sẽ tạo ra 3 file:
- `app-arm64-v8a-release.apk`: Dành cho hầu hết điện thoại Android hiện nay (64-bit). **Hãy dùng file này để cài trên máy của bạn**.
- `app-armeabi-v7a-release.apk`: Dành cho các thiết bị Android đời cũ (32-bit).
- `app-x86_64-release.apk`: Dành cho máy ảo hoặc thiết bị chạy chip Intel/AMD.

### 3.3. Build APK Debug (Dành cho kiểm thử nhanh)
Nếu cần file debug để xem log trực tiếp:
```bash
flutter build apk --debug
```

---

## 4. Vị trí file APK sau khi build

File APK xuất xưởng sẽ nằm tại:
```
build\app\outputs\flutter-apk\
```

- Đối với lệnh `flutter build apk --release`:
  - `app-release.apk`
- Đối với lệnh `flutter build apk --release --split-per-abi`:
  - `app-arm64-v8a-release.apk`
  - `app-armeabi-v7a-release.apk`
  - `app-x86_64-release.apk`

---

## 5. Hướng dẫn cài đặt APK lên điện thoại Android

### Cách 1: Cài đặt nhanh qua cáp USB bằng lệnh ADB (Khuyên dùng cho Dev)

1. **Bật chế độ Nhà phát triển trên điện thoại Android:**
   - Vào **Cài đặt (Settings)** > **Thông tin điện thoại (About phone)** > **Thông tin phần mềm (Software info)**.
   - Nhấn liên tục 7 lần vào dòng **Số bản dựng (Build number)** cho đến khi có thông báo "Bạn đã là nhà phát triển".
2. **Bật Gỡ lỗi USB (USB Debugging):**
   - Vào **Cài đặt** > **Tùy chọn nhà phát triển (Developer options)**.
   - Bật công tắc **Gỡ lỗi USB (USB Debugging)**.
3. **Cắm cáp USB nối điện thoại vào máy tính:**
   - Trên màn hình điện thoại, chọn **"Luôn cho phép từ máy tính này"** khi popup hiện ra.
4. **Cài đặt qua dòng lệnh:**
   Mở terminal và gõ:
   ```bash
   # Kiểm tra thiết bị đã kết nối:
   adb devices

   # Cài đặt file APK:
   adb install -r build/app/outputs/flutter-apk/app-release.apk
   ```
   *(Nếu dùng split-per-abi, thay bằng `app-arm64-v8a-release.apk`)*.

---

### Cách 2: Chép file APK trực tiếp vào điện thoại

1. **Gửi file APK sang điện thoại:**
   - Cắm cáp USB và chép file APK vào thư mục `Download` của máy.
   - Hoặc gửi file qua Google Drive, Zalo (chọn gửi file), Telegram, OneDrive.
2. **Cho phép cài đặt ứng dụng từ nguồn không xác định:**
   - Khi bấm mở file `.apk`, Android sẽ hiện cảnh báo bảo mật.
   - Bấm **Cài đặt (Settings)** trên thông báo và bật công tắc **"Cho phép từ nguồn này" (Allow from this source)** cho ứng dụng đang mở (ví dụ: Trình duyệt Chrome, Zalo, hoặc Quản lý tệp).
3. **Tiến hành cài đặt:**
   - Chọn **Cài đặt (Install)**.
   - Nếu Google Play Protect hiện cảnh báo *"Ứng dụng bị chặn bởi Play Protect"*, bấm vào **"Chi tiết hơn" (More details)** > chọn **"Vẫn cài đặt" (Install anyway)**.
4. **Mở ứng dụng:**
   - Biểu tượng ứng dụng **VIEN** sẽ xuất hiện trên màn hình chính với đầy đủ logo và tính năng offline.

---

## 6. Cấu hình Ký ứng dụng (Signing Keystore - Tùy chọn Release Production)

Mặc định, cấu hình `android/app/build.gradle.kts` của project đã thiết lập:
```kotlin
buildTypes {
    release {
        signingConfig = signingConfigs.getByName("debug")
    }
}
```
Điều này cho phép bạn build và cài đặt ngay bản release để test mà không cần tạo keystore thủ công.

Nếu bạn muốn ký ứng dụng bằng Keystore riêng của mình để phát hành chính thức:

1. Tạo file keystore:
   ```bash
   keytool -genkey -v -keystore D:/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
   ```
2. Tạo file `android/key.properties`:
   ```properties
   storePassword=<mat_khau_keystore>
   keyPassword=<mat_khau_key>
   keyAlias=upload
   storeFile=D:/upload-keystore.jks
   ```
3. Cập nhật `build.gradle.kts` theo hướng dẫn chính thức của Flutter.

---

## 7. Các lỗi thường gặp & Cách khắc phục (Troubleshooting)

| Lỗi | Nguyên nhân | Cách xử lý |
|---|---|---|
| **Unable to locate Android SDK** | Máy tính chưa cài Android Studio/SDK hoặc chưa set biến `ANDROID_HOME` | Cài đặt Android Studio, tải Command-line Tools và cấu hình biến môi trường theo [Mục 1.2](#12-android-sdk--android-studio). |
| **Android license status unknown** | Chưa chấp nhận bản quyền Android | Chạy lệnh `flutter doctor --android-licenses` và bấm `y`. |
| **App not installed / Ứng dụng chưa được cài đặt** | Thiết bị đã cài một bản cài đặt trước đó có chữ ký (signature) khác, hoặc bộ nhớ đầy | Gỡ bỏ bản ứng dụng VIEN cũ trên điện thoại rồi tiến hành cài lại file mới. |
| **Blocked by Play Protect** | Ứng dụng do bạn tự build chưa đăng ký trên Google Play Store | Bấm vào `More details` (Chi tiết hơn) -> chọn `Install anyway` (Vẫn cài đặt). |
| **INSTALL_FAILED_NO_MATCHING_ABIS** | File APK không khớp với kiến trúc CPU của điện thoại (khi dùng `--split-per-abi`) | Dùng bản `app-arm64-v8a-release.apk` hoặc build lại bản universal: `flutter build apk --release`. |
| **Database Drift Seed Error** | Thiếu file seed dữ liệu hoặc schema thay đổi | Chạy `dart run build_runner build --delete-conflicting-outputs` trước khi build APK. |
