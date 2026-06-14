# swiftui-movie-explorer
A scalable iOS app built with Swift 6, SwiftUI and clean MVVM architecture demonstrating networking and modern concurrency practices.

**Clean Architecture 
1. MVVM + UseCase layer
2. Repository Pattern
3. Dependency Injection via AppContainer
4. Hybrid storage (API + SwiftData)


        │      SwiftUI UI      │
        │  (Views + ViewModels)│
        └─────────┬────────────┘
                  │
                  ▼
        ┌──────────────────────┐
        │     AppContainer     │
        │ (Dependency Builder) │
        └─────────┬────────────┘
                  │
      ┌───────────┼──────────────┐
      ▼                          ▼
┌───────────────┐      ┌────────────────────┐
│   UseCases    │      │      SwiftData     │
│ (Business)    │      │ Recently Viewed    │
└───────┬───────┘      └────────────────────┘
        │
        ▼
┌──────────────────────┐
│  Repository Layer    │
└─────────┬────────────┘
          │
          ▼
┌──────────────────────┐
│ DataSources Layer    │
│ (Remote + Local)     │
└─────────┬────────────┘
          │
          ▼
┌──────────────────────┐
│   APIService Layer   │
│   (URLSession)       │
└─────────┬────────────┘
          ▼
      🌐 TMDB API


---

# 📸 App Screenshots

<p align="center">
  <img src="https://github.com/user-attachments/assets/e555c643-d010-4f20-83a2-db6b31af880a" width="320"/>
  <img src="https://github.com/user-attachments/assets/f8912c7b-6ac1-4400-8c39-67ff58c0e858" width="320"/>
  <img src="https://github.com/user-attachments/assets/a4f5a9b8-eb69-4361-9bca-a38af331302e" width="320"/>
</p>

---
