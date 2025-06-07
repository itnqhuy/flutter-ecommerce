# 🛍️ Tech Gear - Flutter eCommerce App

Ứng dụng eCommerce bán đồ công nghệ được xây dựng bằng **Flutter** với khả năng tùy chỉnh **theme sáng/tối** và quản lý trạng thái bằng **GetX**.

## 👥 Thành viên nhóm

- `52200084` - Nguyễn Quốc Huy  
- `52200080` - Nguyễn Nhật Huy

## 🚀 Tính năng nổi bật

- 🌗 Hỗ trợ theme sáng/tối tùy chỉnh
- ⚡ Quản lý trạng thái bằng GetX
- 🔒 Đăng nhập/Đăng ký/Xác thực OTP
- 🛒 Danh sách sản phẩm, chi tiết sản phẩm, giỏ hàng, thanh toán
- 🧑‍💼 Giao diện quản trị (Admin) quản lý sản phẩm và đơn hàng

---

## 📱 USER SIDE (Mobile App)

### ⏳ Splash Screen (Màn hình khởi động)

![Splash Screen](https://github.com/user-attachments/assets/8ec8a7dc-023b-4bf4-bd2f-faffecd90136)

### 🔐 Đăng nhập / Đăng ký / Xác thực

![Login](https://github.com/user-attachments/assets/37a6b4d6-80f5-4fa4-82cf-b7caf3600002)
![Register](https://github.com/user-attachments/assets/9de46392-0e72-4a4d-8969-57dee84b9282)
![Verify](https://github.com/user-attachments/assets/89a23a6c-0249-48f4-ad1c-5536aa970b8d)
![Forgot Password](https://github.com/user-attachments/assets/bdbd330a-cf22-402d-b54a-9e97dc36a4ec)

### 🏠 Trang chủ & Cửa hàng

![Home](https://github.com/user-attachments/assets/4bee0c30-2acb-4a86-86c0-e3febfd07cda)
![Shop](https://github.com/user-attachments/assets/088eecff-57c7-4612-813d-01ec6ff55ba9)

### ⚙️ Cài đặt & Hồ sơ người dùng

![Settings](https://github.com/user-attachments/assets/5437ed88-ad59-44ae-b1fa-f1383a7d4b19)
![Profile](https://github.com/user-attachments/assets/8bb16404-405f-4bd4-8691-dc7260eabff5)

### 🔍 Chi tiết sản phẩm

![Product Detail 1](https://github.com/user-attachments/assets/a1e1d9cc-3b4f-4d46-a74b-05ba4e9783d1)
![Product Detail 2](https://github.com/user-attachments/assets/f371e8f9-2bd5-444b-a522-b92a71a78c70)

### 🛒 Giỏ hàng & Thanh toán

![Cart](https://github.com/user-attachments/assets/150bbc8a-90e0-4647-860c-e5d7311ce917)
![Checkout](https://github.com/user-attachments/assets/15ba2313-a042-4387-8206-b1df5307f72f)
![Order Summary](https://github.com/user-attachments/assets/a75dff8e-28f5-4220-ae97-613dd8d1f85d)

---

## 🖥️ ADMIN SIDE (Web App)

> 💡 Giao diện web, nên kiểm tra responsive & căn chỉnh CSS

![Admin Dashboard](https://github.com/user-attachments/assets/9a95bff7-979e-4c86-9b7b-c2ec05e33f26)
![Admin Orders](https://github.com/user-attachments/assets/286ab789-af2a-4ec2-b5c9-c3645adf36a2)
![Admin Products](https://github.com/user-attachments/assets/c0bc4c48-8bb0-4851-a524-a52225dc4754)

---

## 🛠️ Công nghệ sử dụng

- Flutter
- Dart
- GetX (state management, routing)
- Firebase Auth (xác thực người dùng)
- Cloud Firestore / Firebase Realtime Database
- Responsive UI (Mobile + Web)

---

## 📦 Cài đặt

```bash
git clone https://github.com/your-username/tech_gear_flutter.git
cd tech_gear_flutter
flutter pub get
flutter run
```
## 📌 Ghi chú

- Ứng dụng cần kết nối Firebase → cấu hình file `google-services.json` cho Android và `GoogleService-Info.plist` cho iOS.
- Đảm bảo đã bật Authentication, Firestore và Storage trong Firebase Console.
- Nếu chạy trên web, bạn cần cấu hình Firebase web app và thêm đoạn khởi tạo Firebase trong `index.html` hoặc main web entrypoint.

---

## 📷 Demo

(Thêm link video nếu có: YouTube hoặc GIF minh họa UI/UX trải nghiệm)

---

## 💡 Đóng góp

Mọi đóng góp đều được hoan nghênh!  
Hãy tạo **Pull Request** hoặc **Issue** nếu bạn có ý tưởng mới hoặc phát hiện lỗi.  
Cùng nhau cải thiện ứng dụng này! 🚀

---

## 📄 Giấy phép

Dự án này sử dụng giấy phép **MIT License**.  
Xem chi tiết tại tệp [LICENSE](LICENSE).
