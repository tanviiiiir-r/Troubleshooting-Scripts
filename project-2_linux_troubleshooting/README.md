# 🚀 Kali Linux Troubleshooting Guide

An interactive web-based troubleshooting tool for Kali Linux, built using **Flask**, **Bash Scripts**, and **Docker**.

---

## 📌 Features
- Web-based troubleshooting interface
- Predefined **Linux troubleshooting scripts**
- **One-click execution** for common issues
- **Dockerized** for easy deployment

---

## 🛠️ Technologies Used
- **Python (Flask)** - Backend API
- **HTML, CSS, JavaScript** - Frontend UI
- **Bash Scripts** - Troubleshooting utilities
- **Docker** - Containerization

---

## 📚 Project Structure
```
/project-2_linux_troubleshooting
│── scripts/                 # Contains troubleshooting scripts
│   ├── network_fix.sh
│   ├── permissions_fix.sh
│   ├── system_check.sh
│   ├── kali_update_fix.sh
│   ├── metasploit_fix.sh
│── static/                  # CSS and frontend assets
│── templates/               # Frontend HTML templates
│── server.py                # Flask backend API
│── Dockerfile               # Docker configuration
│── README.md                # Project Documentation
```

---

## 🖥️ Screenshots
### 1️⃣ **Homepage UI**
![Homepage](screenshots/homepage.png)

### 2️⃣ **Running a Troubleshooting Script**
![Running Script](screenshots/running_script.png)

### 3️⃣ **Dockerized Application Running**
![Docker Running](screenshots/docker_running.png)

---

## 🖥️ Running the Project Locally

### 1️⃣ **Install Dependencies**
Make sure you have **Python3** and **pip** installed:
```bash
sudo apt update && sudo apt install python3 python3-pip -y
```
Install Flask:
```bash
pip install flask
```

### 2️⃣ **Run the Server**
Start the Flask application:
```bash
python3 server.py
```
Now visit **`http://127.0.0.1:5000`** in your browser.

---

## 🐋 Running with Docker

### 1️⃣ **Install Docker**
If Docker is not installed:
```bash
sudo apt install docker.io -y
```
Start and enable Docker:
```bash
sudo systemctl start docker
sudo systemctl enable docker
```

### 2️⃣ **Build the Docker Image**
```bash
docker build -t kali-troubleshooting .
```

### 3️⃣ **Run the Docker Container**
```bash
docker run -d -p 5000:5000 --name troubleshooting kali-troubleshooting
```

### 4️⃣ **Access the Web App**
Visit:
```
http://127.0.0.1:5000
```

---

## 🛠️ How It Works

1. **Web UI** loads common troubleshooting options.
2. **User clicks** a button (e.g., *Fix Network Issues*).
3. **Flask API** executes the corresponding **Bash script**.
4. **Results** are displayed on the web page.

---

## 📜 Example Troubleshooting Scripts

### **🔹 Network Fix Script (`network_fix.sh`)**
```bash
#!/bin/bash
echo "$(date) - Running network diagnostics"
ping -c 3 google.com && echo "✅ Internet is working" || echo "❌ No internet connection"
```

### **🔹 Permissions Fix Script (`permissions_fix.sh`)**
```bash
#!/bin/bash
echo "$(date) - Running permission fixer"
chmod -R 755 /path/to/fix
chown -R $USER:$USER /path/to/fix
echo "✅ Permissions fixed!"
```

---

## 🛠️ API Endpoints

| Method | Endpoint               | Description                 |
|--------|------------------------|-----------------------------|
| GET    | `/`                    | Home page                   |
| GET    | `/run-script?script=name` | Runs a Bash script (name.sh) |

Example API call:
```bash
curl "http://127.0.0.1:5000/run-script?script=network_fix.sh"
```

