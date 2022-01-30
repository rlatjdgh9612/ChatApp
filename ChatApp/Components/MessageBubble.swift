//
//  MessageBubble.swift
//  ChatApp
//
//  Created by SeongHoKim on 2022/01/29.
//

import SwiftUI

// MessageBubble : 메세지 말풍선을 관리함
struct MessageBubble: View {
    var message: Message // 메세지 구조체를 message 변수에 전달
    @State private var showtime = false // 메세지 전송시각
    
    var body: some View {
        // 1) 메세지 문구
        VStack(alignment: message.received ? .leading : .trailing) {
            HStack {
                Text(message.text) // 메세지 문구
                    .padding()
                    .background(message.received ? Color("Gray") : Color("Peach")) // 메세지의 수신상태에 따라 메세지 말풍선 색깔이 회색(상대방 수신) 또는 살구색(자신 수신)으로 표현
                    .cornerRadius(30) // 반지름 : 30
            }
            // HStack에 있는 메세지의 특정너비가 초과하지 않도록 값을 지정
            .frame(maxWidth: 300 ,alignment: message.received ? .leading : .trailing)
            // 탭 제스쳐
            .onTapGesture {
                showtime.toggle() // 토글하면 메세지 전송 시각 View에 현시
            }
            // 메세지 전송 시각
            if showtime {
                // (전송시각) 몇시,몇분,AM/PM
                Text("\(message.timestamp.formatted(.dateTime.hour().minute()))")
                    .font(.caption2) // 시각 메세지 폰트 : caption2
                    .foregroundColor(.gray) // 시각 메세지 컬러 : gray
                    .padding(message.received ? .leading : .trailing, 5) // 메세지 수신상태 시간간격 : 5
            }
        }
        // VStack에 있는 메세지의 특정너비가 초과하지 않도록 값을 지정
        .frame(maxWidth: .infinity, alignment: message.received ? .leading : .trailing)
        .padding(message.received ? .leading : .trailing)
        .padding(.horizontal, 10)
    }
}

struct MessageBubble_Previews: PreviewProvider {
    static var previews: some View {
        // 메세지 인스턴스 할당
        MessageBubble(message: Message(id: "12345", text: "저는 지금 Xcode와 함께 SwiftUI를 공부하면서 iOS를 개발하고 있어요!", received: true, timestamp: Date()))
    }
}
