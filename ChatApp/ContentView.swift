//
//  ContentView.swift
//  ChatApp
//
//  Created by SeongHoKim on 2022/01/29.
//
import SwiftUI

// Content : ChatApp 전체 View를 관리함
struct ContentView: View {
    // MessageManager
    @StateObject var messagesManager = MessageManager()
    // iPhone 전체 View
    var body: some View {
        VStack {
            VStack {
                TitleRow()
                
                ScrollViewReader { proxy in 
                    ScrollView {
                        ForEach(messagesManager.messages, id: \.id) { message in
                            MessageBubble(message: message)
                        }
                    }
                    // ScrollView (메세지 View)
                    .padding(.top, 10) // 간격 : 10
                    .background(.white) // 메세지 background 색깔 : white
                    .cornerRadius(30, corners: [.topLeft, .topRight]) // 메세지 background 모서리 반지름값 : 30, 위쪽방향의 왼쪽, 위쪽방향의 오른쪽
                    .onChange(of: messagesManager.lastmessageid) { id in
                        // 메세지 스크롤 애니메이션
                        withAnimation {
                            // 아래에서 위로 올라옴
                            proxy.scrollTo(id, anchor: .bottom)
                            }
                        }
                    }
                }
                // 제목 타이틀 background 색깔 : Peach
                .background(Color("Peach"))
            
                MessageField()
                .environmentObject(messagesManager)
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
