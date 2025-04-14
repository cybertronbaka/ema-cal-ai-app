# Ema Cal AI
**Tech Stack:** ![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white) ![Firebase](https://img.shields.io/badge/firebase-a08021?style=for-the-badge&logo=firebase&logoColor=ffcd34) ![Google Gemini](https://img.shields.io/badge/google%20gemini-8E75B2?style=for-the-badge&logo=google%20gemini&logoColor=white) ![SQLite](https://img.shields.io/badge/sqlite-%2307405e.svg?style=for-the-badge&logo=sqlite&logoColor=white) 

**Ema Cal AI** is an intelligent calorie counter designed to help you track your daily food intake and achieve your health goals. Inspired by the rich culinary traditions of Bhutan, our AI provides estimates for common Bhutanese dishes and ingredients, alongside a comprehensive database of global foods. 

**Features:**

* **AI-Powered Calorie Tracking:** Get quick and easy calorie estimates.
* **Comprehensive Food Database:** Access a vast library of global food items.
* **User-Friendly Interface:** Simple and intuitive design for effortless tracking.

**Note:** This app provides general nutritional information and should not be used as a substitute for professional medical advice. Always consult with a healthcare provider before making significant dietary changes.


**Compatible with:** 
![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white) ![iOS](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white)

**Compatible with (but not responsive):**
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black) ![macOS](https://img.shields.io/badge/mac%20os-000000?style=for-the-badge&logo=macos&logoColor=F0F0F0) ![Windows 11](https://img.shields.io/badge/Windows%2011-%230079d5.svg?style=for-the-badge&logo=Windows%2011&logoColor=white)


## Project Structure: Rules and Ideas

This document outlines the rules and ideas behind the project's directory structure, aiming for a clean, maintainable, and scalable codebase.

**Directory Breakdown and Rules:**

* **lib/:**
    * This is the heart of the application, containing all Dart source code.
    * **app/:**
        * Contains application-level configuration and setup.
        * Should only include core application logic (e.g., routing, theming).
    * **controllers/:**
        * Manages the application's state and acts as a bridge between the UI and repositories/states.
        * Should handle UI-specific logic and state management.
    * **enums/:**
        * Contains enums that are used across the whole application.
    * **models/:**
        * Defines data models, UI-specific models, and DTOs.
        * Serves as a central location for all model definitions.
    * **pages/:**
        * Contains UI pages, with each page in its own directory (`<page_name>/`).
        * **<page_name>/:**
            * **<page_name>.dart:** The main page file (library).
            * **widgets/:** Page-specific UI components. Global members must be private (`_`).
            * **utils/:** Page-specific utility functions. Global members must be private (`_`).
            * **enums/:** Page-specific enums. Global members must be private (`_`).
            * **models/:** Page-specific models. Global members must be private (`_`).
        * This structure helps with encapsulation and avoids namespace conflicts.
    * **repos/:**
        * Defines interfaces to data sources (APIs, databases, etc.).
        * Each repository in its own directory (`<repository_name>/`).
        * Repositories should be data-source agnostic.
    * **states/:**
        * Defines application states.
        * Should not contain state management logic.
        * UI-agnostic state methods can be included.
    * **utils/:**
        * Contains general utility functions and helper classes.
        * Should be UI and business logic agnostic.
    * **widgets/:**
        * Contains reusable UI components.
        * **views/:** Reusable UI views that can interact with controllers and states.
        * `*.dart`: Atomic UI components (e.g., buttons, inputs). Should be UI-agnostic.
    * **main.dart:**
        * The application's entry point.

* **test/:**
    * Contains unit and widget tests.
    * **mocks/:** Mock implementations for testing dependencies.
    * **pages/:** Golden/Widget testing for pages.
    * **utils/:** Testing utilities.


### Plans

1. Backup to google_drive so that no data is lost. (No images will be uploaded) ![Google Drive](https://img.shields.io/badge/Google%20Drive-4285F4?style=for-the-badge&logo=googledrive&logoColor=white)
2. Upload to firebase if you want to contribute data to devs. (Images uploaded with manually updated values, instead of using gemini's will be uploaded);
3. Upload to 