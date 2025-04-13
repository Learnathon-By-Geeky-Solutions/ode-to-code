<div align="center">

![EduBridge Logo](https://github.com/user-attachments/assets/c811683b-575e-44d4-a31c-d9661b6c3c60)

  
# 🎓 EduBridge  
**Bridging the Education Gap Through Community Learning**

![Dart](https://img.shields.io/badge/Dart-3.0-blue?logo=dart&logoColor=white)
![Flutter](https://img.shields.io/badge/Flutter-3.10-blue?logo=flutter&logoColor=white)
![GetX](https://img.shields.io/badge/GetX-State_Management-purple?logo=getx&logoColor=white)
![Supabase](https://img.shields.io/badge/Supabase-PostgreSQL-brightgreen?logo=supabase)
![REST API](https://img.shields.io/badge/REST-API-red?logo=api&logoColor=white)
![Android Studio](https://img.shields.io/badge/Android_Studio-Giraffe-green?logo=androidstudio&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)

</div>

<table>
<tr>
<td>


## 📖 About EduBridge

**EduBridge** is a **free, community-driven education platform** built to democratize learning across Bangladesh. Aimed at students in **Grades 8–12** and **IELTS/Spoken English learners**, it empowers users to **learn, share, and grow** — regardless of financial background. Developed using **Flutter (MVVM)** and **Supabase**, the platform promotes peer-to-peer knowledge sharing in localized Bengali content.

## The Problem We Solve

Education in Bangladesh is often:

- ❌ Expensive
- ❌ Tutor-dependent
- ❌ Lacking Bengali content
- ❌ Passive and one-sided

## ✅ Our Solution

**EduBridge empowers students and educators through:**

✅ Free and open access — always  
✅ Uploading and sharing of videos, notes, and MCQs  
✅ Real-time feedback and localized content in Bengali  
✅ Donation-based rewards to recognize and support contributors  
✅ Built using **Flutter** and **Supabase** (PostgreSQL, Auth, Storage)  

## 🌍 Vision: The Bigger Picture

*** "When students teach, they don’t just learn better — they uplift entire communities."

- Over 60% of students in Bangladesh lack access to quality academic support  
- Smartphones are widespread — EduBridge transforms them into learning tools  
- Focused not just on academics but also on soft skills and future readiness  


## 💡Key Features

| Feature                  | Description                                                                 |
|--------------------------|-----------------------------------------------------------------------------|
| Free Access              | No subscriptions, paywalls, or limitations                                  |
| Community-Driven         | Users can contribute as both learners and educators                         |
| Localized Learning       | Bengali-first approach with immediate feedback                              |
| Modern Tech Stack        | Built with Flutter and Supabase (PostgreSQL, Auth, Realtime, Storage)       |
| Forward-Looking Roadmap  | AI tutors, gamification, and job-oriented modules are on the horizon        |



</td>
</tr>
</table>


<table>
<tr>
<td>


<details>
<summary><h2>📋 Table of Contents</h2></summary>

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

</details>

<div align="center">

## 👥 Team Members

| Name            | Role         | GitHub Profile                             |
|-----------------|--------------|--------------------------------------------|
| mishad01        | Team Leader  | [@mishad01](https://github.com/mishad01)   |
| saif-gitreps    | Member       | [@saif-gitreps](https://github.com/saif-gitreps) |
| IsratJahan09    | Member       | [@IsratJahan09](https://github.com/IsratJahan09) |
| ihjohny  | Project Mentor   | [@ihjohny](https://github.com/ihjohny)    |



## 🔧 **Technical Alignment**  
- **Flutter MVVM**: Ensures testable, modular code (Views ↔ ViewModels ↔ Supabase).  
- **Supabase**: Handles auth, user-generated content, and donations securely.  

## 📚 **Learning & Resources**

[![Figma](https://img.shields.io/badge/Figma-UI_Designs-blueviolet?logo=figma&logoColor=white)](https://www.figma.com/proto/e4OYzhQK75LW0kQBk9j5XL/EDU-BRIDGE?node-id=0-1&t=14BMsrBnyiJX5mql-1)  [![Supabase Docs](https://img.shields.io/badge/Supabase-Documentation-3ECF8E?logo=supabase&logoColor=white)](https://supabase.com/docs) [![Flutter MVVM](https://img.shields.io/badge/Flutter-MVVM_Tutorials-blue?logo=flutter&logoColor=white)](https://resocoder.com/flutter-clean-architecture-tdd/)

![image](https://github.com/user-attachments/assets/32e52ca1-84b1-4111-bef3-c3bf9a4b90bb)


</div>

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

  
<div align="center">
  
## 🌐 **API Documentation**  
| Category | Description |
|----------|-------------|
| 🔐 **Auth Endpoints** | Sign Up, Login, OAuth |
| 📦 **Storage** | Upload & access videos, notes, documents |
| 🗄️ **Database** | Full CRUD: Notes, MCQs, Progress tracking |
| 💻 **Dart Examples** | Code snippets with `http` and `supabase_flutter` |


## 💻 **Development Guidelines**  

| 🔧 Topic | ✅ Best Practices |
|---------|------------------|
| 📐 **Architecture** | MVVM: `/lib/view`, `/lib/viewmodel`, `/lib/model` |
| 🧠 **State Management** | GetX (minimal, reactive) |
| 🛡️ **Security & Clean Code** | Follow Supabase + Flutter safety standards |


## 🧪 **Testing Strategy**

| 🧪 Test Type | 🔍 Description |
|-------------|----------------|
| 🧠 **Unit Tests** | Validates ViewModel logic & services |
| 🧩 **Widget Tests** | UI components and layouts |
| 🧪 **Supabase Mock Tests** | Use mocks for secure backend logic testing |




</td>
</tr>
</table>
