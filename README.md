# EduBridge:🎓

<div align="center">

![EduBridge Logo](https://github.com/user-attachments/assets/c811683b-575e-44d4-a31c-d9661b6c3c60)

  
  <h2>Bridging the Education Gap Through Community Learning</h2>
</div>

---

## 📌 **Project Status**  
![Dart](https://img.shields.io/badge/Dart-3.0-blue?logo=dart&logoColor=white)
![Flutter](https://img.shields.io/badge/Flutter-3.10-blue?logo=flutter&logoColor=white)
![GetX](https://img.shields.io/badge/GetX-State_Management-purple?logo=getx&logoColor=white)
![Supabase](https://img.shields.io/badge/Supabase-PostgreSQL-brightgreen?logo=supabase)
![REST API](https://img.shields.io/badge/REST-API-red?logo=api&logoColor=white)
![Android Studio](https://img.shields.io/badge/Android_Studio-Giraffe-green?logo=androidstudio&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)


## **📖 About EduBridge**  
EduBridge is a **free, community-powered education app** designed to bridge the learning gap for students across Bangladesh. Built on the belief that education should be accessible to all regardless of financial constraints, the platform empowers students (Grades 8–12, IELTS/Spoken English learners) to **learn, share, and grow together**.  

---   

---

## 📋 **Table of Contents**  
1. 👥 [Team Members](#-team-members)  
2. 🚀 [Project Overview](#-project-overview)  
3. 🎯 [Key Goals](#-key-goals)  
4. 🌟 [Why This Matters](#-why-this-matters)  
5. 🔧 [Technical Alignment](#-technical-alignment)  
6. 🏗️ [Project Structure: MVVM Architecture with Repository Pattern](#-project-structure-mvvm-architecture-with-repository-pattern)  
7. 🗃️ [Database Design](#-database-design)  
8. 🌐 [API Documentation](#-api-documentation)  
9. 💻 [Development Guidelines](#-development-guidelines)  
10. 🧪 [Testing](#-testing)  
11. 📚 [Resources](#-resources)  
12. 🤝 [Contributing](#-contributing)  


---

## 👥 **Team Members**  
- **mishad01** (Team Leader)  
- **saif-gitreps**  
- **IsratJahan09**  

### 🎓 **Project Mentor**  
- **ihjohny**  

---

## 🚀 **Project Overview**  
**EduBridge** is a free, community-powered education app designed to democratize learning for Bangladeshi students (Grades 8-12, IELTS/Spoken English learners). Built with **Flutter (MVVM)** and **Supabase**, it enables peer-to-peer knowledge sharing through localized Bengali content, interactive MCQs, and a donation-based reward system.  

Unlike paid platforms, EduBridge turns students into both learners and teachers, creating a self-sustaining ecosystem where smartphones become tools for accessible education.  
---

---

## 🎯 Key Goals

- **Eliminate Financial Barriers**  
  → 100% free, high-quality resources tailored to the Bangladeshi curriculum.

- **Foster Collaborative Learning**  
  → Students can upload & share videos, notes, MCQs — like an educational Stack Overflow.

- **Localize Content**  
  → Bengali-medium lessons with instant feedback to fill the gaps left by global platforms.

- **Leverage Technology for Scale**  
  → Use **Supabase** (Auth, PostgreSQL, Storage) for an affordable backend.  
  → Apply **MVVM** architecture for clean, scalable Flutter code.

- **Build a Sustainable Model**  
  → Donations reward contributors — peer support over paywalls.

- **Future-Proof Education**  
  → Pilot AI-driven tutoring and vocational training to fight unemployment.

## 🌟 **Why This Matters**  
- 📌 **Impact**: 60% of Bangladeshi students lack access to quality tutors. EduBridge bridges this gap.  
- 📌 **Innovation**: First community-driven app combining peer learning + donations in Bangladesh.  
- 📌 **Scalability**: Designed to expand into AI/gamification with Supabase’s flexibility.  

---  

## 🔧 **Technical Alignment**  
- **Flutter MVVM**: Ensures testable, modular code (Views ↔ ViewModels ↔ Supabase).  
- **Supabase**: Handles auth, user-generated content, and donations securely.  

## 🏗️ **Project Structure: MVVM Architecture with Repository Pattern**  
```
EduBridge/
│── data/  
│   ├── models/  
│   │   ├── banner_model.dart  
│   │   ├── category_model.dart  
│   │   ├── chapter_model.dart  
│   │   ├── class_model.dart  
│   │   ├── content_model.dart  
│   │   ├── mentor_model.dart  
│   │   ├── popular_course_content_model.dart  
│   │   ├── popular_course_model.dart  
│   │   ├── subject_model.dart  
│   │   ├── user_model.dart  
│   │   ├── user_profile.dart  
│   ├── repositories/  
│   │   ├── auth_repository.dart  
│   │   ├── banner_repository.dart  
│   │   ├── category_repository.dart  
│   │   ├── chapters_repository.dart  
│   │   ├── classes_repository.dart  
│   │   ├── content_repository.dart  
│   │   ├── mentor_repository.dart  
│   │   ├── popular_course_content_repository.dart  
│   │   ├── popular_courses_repository.dart  
│   │   ├── subjects_repository.dart  
│   │   ├── user_profile_repository.dart  
│   │   ├── user_repository.dart  
│── services/  
│   ├── auth_service.dart  
│   ├── firebase_auth_services.dart  
│   ├── firestore_paths.dart  
│── resources/  
│   ├── app_colors.dart  
│   ├── assets_path.dart  
│   ├── export.dart  
│   ├── image_picker_service.dart  
│   ├── urls.dart  
│── utils/  
│   ├── centered_app_logo.dart  
│   ├── custom_button.dart  
│   ├── custom_header_text.dart  
│   ├── custom_scaffold.dart  
│   ├── custom_spacing.dart  
│   ├── custom_text.dart  
│   ├── custom_text_button.dart  
│   ├── custom_text_field.dart  
│   ├── validators.dart  
│── view/  
│   ├── admin_content_post/  
│   ├── auth/  
│   ├── home/  
│   ├── intro/  
│   ├── on_boarding/  
│   ├── user/  
│   ├── view_model/  
│   ├── admin_app.dart  
│   ├── admin_main.dart  
│   ├── controller.dart  
│   ├── user_app.dart  
│   ├── user_main.dart  
```
## 📌 Directory Breakdown

- **`data/`** → Contains all the models and repositories for data management.  
- **`services/`** → Manages Firebase authentication and Firestore paths.  
- **`resources/`** → Stores theme colors, asset paths, and other static configurations.  
- **`utils/`** → Houses reusable UI components and helper functions.  
- **`view/`** → Organizes the user interface, including screens for authentication, onboarding, and content posting.  

---
## 🗃️ **Database Design**  

![Supabase Schema](https://github.com/user-attachments/assets/7062c197-3366-409a-8f14-eaf8de769ea8)

---

## 🌐 **API Documentation**  
📌 **Auth Endpoints** → (Sign up, Login, OAuth)  
📌 **Storage** → (Video uploads, document sharing)  
📌 **Database** → (CRUD for notes, MCQs, progress tracking)  
📌 **Example Requests** → (Dart code snippets)  

---

## 💻 **Development Guidelines**  
📌 **MVVM structure** (`/lib/view`, `/lib/viewmodel`, `/lib/model`)  
📌 **State management** (GetX)  
📌 **Supabase best practices**  

## 🧪 **Testing**  
📌 **Unit tests** (ViewModel logic)  
📌 **Widget tests** (UI components)  
📌 **Supabase mock testing**  

---

## 📚 **Resources**  
📌 **Figma designs**  
📌 **Supabase docs**  
📌 **Flutter MVVM tutorials**  

---

## 🤝 **Contributing**  
📌 **Git workflow** (feature branches)  
📌 **Issue templates**  
📌 **Code review process**  

---

🔹 **Built with ❤️ by the EduBridge Team** 🔹


I want to see copy option for the project structure
