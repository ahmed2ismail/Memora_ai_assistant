# 🧠 Memora AI Assistant: The Elite Modular Architecture

Memora is a sophisticated, multi-modal AI companion designed to provide personalized cognitive support, focus optimization, and daily assistance for Students, General users, and individuals with Alzheimer’s.

This project represents the **Gold-State** of Flutter development, featuring a massive structural refactor that implements industry-leading Clean Architecture and UI engineering standards.

---

## 📸 Visual Showcase

| General Intelligence | Focus & Study | Cognitive Support |
| :---: | :---: | :---: |
| ![General Mode](screenshots/general_mode.png) | ![Student Mode](screenshots/student_mode.png) | ![Alzheimer Mode](screenshots/alzheimer_mode.png) |

---

## 🏗️ Architectural Integrity: Deep Domain Nesting

Memora utilizes a high-precision **Feature-First Domain Architecture**. By moving beyond traditional "flat" presentation layers, we have implemented **Deep Domain Nesting** to achieve maximum logic isolation:

- **Modular Logic Core**: Every feature domain (Alzheimer, Student, General) is isolated into its own persistent sub-directory.
- **Granular Cubit Management**: State management is nested at a domain-component level:
  `lib/features/home/presentation/cubit/[domain]/[dashboard|detail]/`
- **Strict Separation of Concerns**: This structure ensures that functional logic for a Student's Pomodoro timer never collides with Alzheimer's medication schedules.

## ⚛️ Atomic Widget Extraction (The 150-Line Rule)

To ensure infinite maintainability and readability, Memora adheres to the **Atomic Widget Extraction Policy**:
- **Zero Monolithic Pages**: All complex private builders (e.g., `_buildFocusGrid`, `_buildTimelineAndAI`) have been extracted into standalone, high-reusable widgets.
- **Lean Orchestration**: Every Page file in the project is now under **150 lines**, focusing purely on BLoC orchestration and high-level layout.
- **Standalone Widget Library**: Over **25+ domain-specific widgets** are organized in `widgets/[domain]/`, providing a clean DSL-like developer experience.

## 🎨 The Liquid UI Engine: Pixel-Perfect Scaling

Solves the "Donepezil" and "Afternoon" clipping issues found in dense dashboards:
- **Liquid Text Policy**: Critical dynamic strings (User Identity, Medicine Names, Time Labels) are wrapped in `FittedBox(fit: BoxFit.scaleDown)` and `Flexible-First` rules. 
- **Systematic Responsiveness**: By eliminating hardcoded heights and absolute pixel offsets, the UI fluidly adapts from small mobile screens to large tablets without manual adjustments.
- **Glassmorphic Aesthetic**: High-performance backdrop filters and gradient-masking provide a premium, state-of-the-art visual feel.

---

## ⚡ Functional Activation & Soul

Memora is fully wired with production-grade logic:
- **Cubit-Driven Actionability**: All buttons, icons (Settings, Search), and cards are linked to real BLoC logic.
- **Real-Time AI Feedback**: Integrated with Gemini AI for context-aware cognitive support.
- **Visual Feedback System**: Uses `BlocConsumer` and `BlocListener` to provide instant `SnackBar` feedback for crucial state changes (e.g., "Alerting emergency contacts...").
- **Navigation Safety**: Built on **GoRouter** with Stateful Shell logic, providing persistent bottom navigation and deep-link safety.

---

## 🛠️ Tech Stack & Engineering Health

| Category | Technology |
| --- | --- |
| **Framework** | Flutter (Dart 3.x) |
| **State Management** | BLoC / Cubit |
| **Navigation** | GoRouter (Stateful Shell) |
| **AI Intelligence** | Google Gemini SDK |
| **Dependency Injection** | Get_it (Injection Container) |
| **Static Analysis** | **No Issues Found! (0 errors, 0 warnings)** |

---

## 🚀 Getting Started

1. **Clone & Install**: `git clone` and `flutter pub get`.
2. **Key Setup**: Insert your `GEMINI_API_KEY` in the `.env` file.
3. **Execution**: `flutter run` starts the journey from the Onboarding flow.

---

*Built with ❤️ for a more mindful future.*
