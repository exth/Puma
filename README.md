<h1 align="center">Puma — iOS Sneaker Store</h1>
 
<p align="center">
  A fully-featured e-commerce app for browsing and shopping PUMA sneakers, built with SwiftUI, Firebase and MVVM.
</p>

## Table of Contents
- [Screenshots](#screenshots)
- [Overview](#overview)
- [Features](#features)
- [Architecture](#architecture)
- [Tech Stack](#tech-stack)
- [Testing](#testing)
- [Design](#design)
- [Requirements](#requirements)
- [Disclaimer](#disclaimer)
- [Author](#author)
  

## Screenshots
<table>
  <tr>
    <td><img src="Screenshots/1.png" width="250"/></td>
    <td><img src="Screenshots/2.png" width="250"/></td>
    <td><img src="Screenshots/3.png" width="250"/></td>
  </tr>
  <tr>
    <td><img src="Screenshots/4.png" width="250"/></td>
    <td><img src="Screenshots/5.png" width="250"/></td>
    <td><img src="Screenshots/6.png" width="250"/></td>
  </tr>
    <tr>
    <td><img src="Screenshots/7.png" width="250"/></td>
    <td><img src="Screenshots/8.png" width="250"/></td>
    <td><img src="Screenshots/9.png" width="250"/></td>
  </tr>
</table>


## Overview
**Puma** is an independent, non-commercial demo e-commerce app inspired by the official PUMA shopping experience. Users can sign up or sign in, browse a live product catalog pulled from Firebase, save favorites, build a cart, and manage their account — all within a custom-built interface.
The app is fully functional on iPhone and works well on iPad, though the iPad layout would need further polish for a full App Store release targeting tablets. The entire backend — authentication, product data, and account management — is powered by **Firebase**.


## Features
### Authentication
- Sign in with Apple or Google
- Custom email/password flow: format validation, live password rules, email verification with auto-detect, and "Forgot Password" reset
- Persistent session, sign out, and two-step account deletion
### Info
- First-login brand story screen covering PUMA's history and founder, Rudolf Dassler
### Catalog
- Live product list from Cloud Firestore, with local caching for instant loads
- Category filters, live search, pull-to-refresh, and a retryable network error state
### Product Details
- Image carousel with size/color selection and real-time availability
- Add to Cart / Buy Now — Buy Now shows a "coming soon" alert and redirects to the official PUMA site, as no real transactions are processed
### Favorites
- Add/remove from product cards, dedicated screen with quick "Add to Cart", empty state
### Cart
- Add items with the selected size and color, animated removal, empty state with a link back to the catalog
### Profile
- Clear local cache, delete account, sign out
- Link to the official PUMA website, in-app Terms of Use page, app version display


## Tech Stack
- **Swift 6** / **SwiftUI**
- **Firebase Authentication** (Email/Password, Apple, Google)
- **Cloud Firestore** — product catalog storage
- **Kingfisher** — async image loading & caching
- **XCTest** — unit testing
- **MVVM + Coordinator**, Swift **Observation framework** (`@Observable`)
- iOS 18.6+
- Xcode 16+


## Testing
Dedicated `XCTest` suite covering:
- `AuthorizationTests`, `CartTests`, `CatalogTests`, `CoreTests`, `ProfileTests`
Firebase-backed services are abstracted behind protocols with mock implementations (`MockAuthService`, `MockProductService`, `MockProductCacheService`), so every ViewModel can be tested in isolation without a live network or Firebase project.


## Disclaimer
This app is an independent, unofficial project built for educational and portfolio purposes only. It is **not affiliated with, endorsed by, or connected to PUMA SE** in any way, and does not process real purchases. To buy real products, visit the [official PUMA website](https://us.puma.com).
<p align="center">Built by **Exthxrn**</p>
