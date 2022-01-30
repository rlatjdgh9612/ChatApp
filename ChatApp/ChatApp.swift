//
//  ChatAppApp.swift
//  ChatApp
//
//  Created by SeongHoKim on 2022/01/29.
//
import SwiftUI
import Firebase

@main
struct ChatApp: App {
    // FireBase 초기화
    init() {
        FirebaseApp.configure() // 브라우저에서 만든 FireBase앱으로 iOS Application을 구성한다
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
