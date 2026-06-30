#####

chạy ec2 => lấy ip ec2 => thay vào code cũng như là action github
ssh -i "D:\dien-toan-dam-may\ecommerce-key.pem" ubuntu@<IP>


docker ps => kiểm tra các container
docker compose ps => docker nó sẽ quản lý phần service của hệ thống gồm fe , be , database
docker images => GitHub Actions đã build image và đẩy lên GitHub Container Registry, EC2 pull image về để chạy
curl -I localhost:5000/swagger/index.html => kiểm tra swagger trên terminal


https://developer.paypal.com/dashboard/accounts
ip-ec2/swagger/index.html

EC2_HOST	Public IPv4 của EC2
EC2_PORT	Port SSH (thường là 22)
EC2_USERNAME	User SSH vào EC2 => ubuntu
EC2_SSH_KEY	Nội dung file .pem private key
# 🚀 Cloud Deployment Project - CI/CD with GitHub Actions, Docker & AWS EC2

## 📌 Tổng quan

Hệ thống được triển khai theo mô hình **CI/CD (Continuous Integration / Continuous Deployment)** trên nền tảng điện toán đám mây.

Quy trình tự động hóa giúp lập trình viên chỉ cần cập nhật mã nguồn lên GitHub, toàn bộ quá trình:

* Build ứng dụng
* Đóng gói Docker Image
* Lưu trữ Image trên GitHub Container Registry
* Deploy lên Amazon EC2
* Kiểm tra trạng thái hệ thống

được thực hiện tự động thông qua **GitHub Actions**.

---

# 🏗️ Kiến trúc hệ thống

```
Developer
    │
    │ Push code
    ▼
GitHub Repository
    │
    │ Trigger GitHub Actions
    ▼
Build Docker Image
    │
    ▼
GitHub Container Registry (GHCR)
    │
    ▼
SSH Deploy tới Amazon EC2
    │
    ▼
Docker Compose
    │
    ├── Backend (.NET API)
    │
    ├── Frontend (React)
    │
    └── Database (SQL Server)
    │
    ▼
Application Running
```

---

# ☁️ Công nghệ sử dụng

| Thành phần         | Công nghệ                        |
| ------------------ | -------------------------------- |
| Cloud Provider     | Amazon Web Services              |
| Compute Service    | Amazon EC2                       |
| CI/CD              | GitHub Actions                   |
| Container          | Docker                           |
| Container Registry | GitHub Container Registry (GHCR) |
| Backend            | ASP.NET Core                     |
| Frontend           | ReactJS                          |
| Database           | Microsoft SQL Server             |
| Deployment         | Docker Compose                   |

---

# 🔄 Quy trình CI/CD

## 1. Developer Push Code

Lập trình viên cập nhật source code:

```bash
git add .
git commit -m "Update application"
git push origin main
```

Khi có commit mới trên branch `main`, GitHub Actions tự động được kích hoạt.

---

# ⚙️ Workflow GitHub Actions

Workflow gồm 2 Job chính:

## Job 1: Build

```
Push Code
    │
    ▼
Checkout Source Code
    │
    ▼
Build Backend Docker Image
    │
    ▼
Build Frontend Docker Image
    │
    ▼
Push Images lên GHCR
```

### Các bước thực hiện:

### Checkout code

Lấy source code mới nhất từ GitHub:

```yaml
actions/checkout
```

---

### Build Backend Image

Backend được đóng gói thành Docker Image:

```
backend:latest
```

---

### Build Frontend Image

Frontend React được build:

```
frontend:latest
```

---

### Push lên GHCR

Docker Image được lưu trữ trên:

```
GitHub Container Registry
```

Giúp máy chủ EC2 có thể tải về phiên bản mới nhất.

---

# 🚀 Job 2: Deploy

Sau khi build thành công, hệ thống tự động deploy lên EC2.

Quy trình:

```
SSH vào EC2
      │
      ▼
Pull code mới
      │
      ▼
Tạo file .env
      │
      ▼
Dừng container cũ
      │
      ▼
Pull Docker Image mới
      │
      ▼
Khởi tạo Database
      │
      ▼
Start Docker Compose
      │
      ▼
Health Check
```

---

# 🖥️ Triển khai trên Amazon EC2

EC2 đóng vai trò là máy chủ chạy ứng dụng.

Sau deploy, kiểm tra container:

```bash
docker compose ps
```

Kết quả:

```
backend
frontend
database
nginx
```

Kiểm tra Docker Image:

```bash
docker images
```

---

# 🐳 Docker Architecture

Ứng dụng chạy bằng Docker Compose:

```
Docker Compose

├── ecommerce-backend
│       └── ASP.NET Core API
│
├── ecommerce-frontend
│       └── React Application
│
├── ecommerce-db
│       └── SQL Server
│
└── nginx
        └── Reverse Proxy
```

---

# 🔍 Kiểm tra hệ thống sau Deploy

## Backend API

Kiểm tra API:

```bash
curl localhost:5000/api/product
```

Kết quả:

```json
[
 {
   "productID":1,
   "name":"Nike Air Max 270"
 }
]
```

---

## Frontend

Truy cập:

```
http://EC2_PUBLIC_IP
```

---

## Swagger API Documentation

Truy cập:

```
http://EC2_PUBLIC_IP/swagger
```

Swagger giúp kiểm tra và gọi thử các API.

---

# 📊 Deployment Result

Sau khi hoàn tất:

```
✅ Deployment Completed Successfully

🌐 Website:
http://EC2_PUBLIC_IP

📚 API Documentation:
http://EC2_PUBLIC_IP/swagger

Backend:
✅ Running

Frontend:
✅ Running

Database:
✅ Running
```

---

# 🎓 Giải thích liên quan đến Cloud Computing

## Amazon EC2

Amazon EC2 là dịch vụ **Infrastructure as a Service (IaaS)**.

EC2 cung cấp:

* Máy chủ ảo
* CPU
* RAM
* Network
* Storage

để chạy ứng dụng trên Cloud.

---

## GitHub Actions

GitHub Actions là dịch vụ CI/CD trên nền tảng Cloud.

Nó tự động:

* Build ứng dụng
* Test
* Deploy

giúp giảm thao tác thủ công.

---

## GitHub Container Registry

GHCR dùng để lưu trữ Docker Image.

Thay vì copy source code lên server, EC2 chỉ cần:

```bash
docker pull image
```

để lấy phiên bản mới nhất.

---

## Docker

Docker giúp đóng gói ứng dụng cùng môi trường chạy.

Lợi ích:

* Triển khai nhất quán
* Dễ mở rộng
* Tránh lỗi môi trường

---

# 🎤 Kịch bản thuyết trình

## Câu hỏi: Tại sao sử dụng GitHub Actions?

Trả lời:

> GitHub Actions giúp tự động hóa quá trình triển khai. Thay vì mỗi lần thay đổi code phải SSH vào EC2, build ứng dụng và chạy lại container thủ công, chỉ cần push code lên GitHub thì toàn bộ quá trình deploy sẽ được thực hiện tự động.

---

## Câu hỏi: Điện toán đám mây được áp dụng ở đâu?

Trả lời:

> Amazon EC2 cung cấp hạ tầng Cloud để chạy ứng dụng. GitHub Actions cung cấp CI/CD trên Cloud. GitHub Container Registry lưu trữ Docker Image trên Cloud. Docker giúp triển khai ứng dụng nhất quán trên môi trường EC2.

---

# ⚠️ Lưu ý về Database

Trong workflow hiện tại, database được tạo mới sau mỗi lần deploy:

```
DROP DATABASE
CREATE DATABASE
Insert sample data
```

Ưu điểm:

* Dữ liệu demo luôn sạch
* Dễ kiểm tra hệ thống

Nhược điểm:

* Mất dữ liệu cũ

Trong môi trường thực tế nên sử dụng:

* Database Migration
* Backup
* Không xóa dữ liệu khi deploy

---

# ✅ Kết luận

Dự án áp dụng đầy đủ các thành phần của Cloud Computing:

* AWS EC2
* Docker Container
* GitHub Actions CI/CD
* GitHub Container Registry
* Automated Deployment

Quy trình giúp hệ thống được triển khai nhanh, ổn định và phù hợp với mô hình DevOps hiện đại.
