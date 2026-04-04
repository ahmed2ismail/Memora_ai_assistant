# 🧠 Memora AI Assistant: Elite Modular Architecture

Memora is a sophisticated, multi-modal AI companion designed to provide personalized cognitive support, focus optimization, and daily assistance for Students, General users, and individuals with Alzheimer’s.

This project represents the **Gold-State** of Flutter development, featuring a deep modular refactor, zero-defect static analysis, and a high-performance "Liquid UI" engine.

## 📸 Visual Showcase

| General Intelligence | Focus & Study | Cognitive Support |
| :---: | :---: | :---: |
| ![General Mode](screenshots/general_mode.png) | ![Student Mode](screenshots/student_mode.png) | ![Alzheimer Mode](screenshots/alzheimer_mode.png) |

---

## 🏗️ Architectural Excellence

Memora is built on a **Domain-Driven Clean Architecture** backbone, significantly enhanced by a custom **Deep Nesting Strategy** for maximum scalability:

### 1. Deep Domain Nesting 📂
Unlike flat architectures, Memora organizes logic at a granular level. Every feature is isolated into domain-specific sub-folders:
- `lib/features/home/presentation/cubit/[domain]/[page]/`
- (e.g., `alzheimer/dashboard/`, `student/detail/`)
This ensures zero cross-domain pollution and allows each module to evolve independently.

### 2. Atomic Widget System (The 150-Line Rule) ⚛️
To ensure industry-leading maintainability, we have implemented a strict **Atomic Widget Extraction** policy:
- **Zero Monolithic Pages**: Every complex private builder has been refactored into a standalone widget file in `widgets/[domain]/`.
- **Maintainable Codebase**: No single Page file exceeds **150 lines**, making the UI purely orchestrational and incredibly lean.
- **Over 25+ isolated components** work together to create the dashboard experience.

---

## 🎨 The Liquid UI Engine

Memora features a "Liquid" design system that solves the common "clipping" issues found in complex mobile dashboards:

- **Liquid Text Policy**: All critical dynamic text (e.g., Medicine names like "Donepezil", Time labels like "Afternoon", and User Identity) are wrapped in `FittedBox(fit: BoxFit.scaleDown)`. This ensures they scale fluidly on narrow devices instead of breaking or overflowing.
- **Flexible-First Layouts**: By eliminating hardcoded heights and using `MainAxisSize.min` with `Flexible`/`Expanded` containers, the UI breathes naturally on everything from an SE-sized phone to a large tablet.
- **Glassmorphism Metrics**: High-end glass-card components with backdrop filters provide a premium, modern aesthetic.

---

## ⚡ Functional Activation & AI

Memora is not just a UI shell—it is a fully functional AI-integrated system:

- **Gemini AI Integration**: Powered by Google's Gemini models, the assistant provides real-time cognitive insights and contextual suggestions.
- **Reactive State Management**: Uses **flutter_bloc** (Cubit) with `BlocConsumer` and `BlocListener` patterns to provide instant visual feedback (SnackBars) for all user actions (e.g., "Help Now", "Scan Person").
- **State-Aware Navigation**: Built on **GoRouter** with a persistent Navigation Shell, allowing for seamless transitions between multi-modal states.

---

## 🛠️ Tech Stack

| Category | Technology |
| --- | --- |
| **Framework** | Flutter (Dart 3.x) |
| **State Management** | BLoC / Cubit |
| **Generative AI** | Google Gemini SDK |
| **Navigation** | GoRouter (Stateful Shell) |
| **Dependency Injection** | Get_it (Injection Container) |
| **Network** | Dio |
| **Functional Logic** | Dartz (Either Pattern) |
| **Theming** | Custom AppStyles Typography Engine |

---

## 📋 Health Report: Gold State

- **Static Analysis**: `flutter analyze` returns **0 errors, 0 warnings**.
- **Performance**: 60 FPS fluid animations with `const` constructor optimizations throughout.
- **Stability**: Enterprise-grade error mapping for all API and AI interactions.

---

## 🚀 How to Get Started

1.  **Clone & Install:**
    ```bash
    git clone https://github.com/ahned2ismail/Memora_ai_assistant
    flutter pub get
    ```

2.  **Environment Setup:**
    Create a `.env` file with your `GEMINI_API_KEY`.

3.  **Run:**
    ```bash
    flutter run
    ```

---

*Built with ❤️ for a more mindful future.*
