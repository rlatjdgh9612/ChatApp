//
//  MessageField.swift
//  ChatApp
//
//  Created by SeongHoKim on 2022/01/29.
//
import SwiftUI

// MessageField : 메세지 입력과 관련된 모든 구조체를 관리함
struct MessageField: View {
    // 메세지 관리자 변수
    @EnvironmentObject var messageManager: MessageManager
    // 사용자가 입력할 메세지 필드
    @State private var message = "" // 맨 처음엔 비어있다
    
    var body: some View {
        HStack {
            // 1) 메세지 입력란 (메세지를 입력해주세요)
            CustomTextField(placeholder: Text("메세지를 입력해주세요"), text: $message)
            Button {
                // 메세지 전송버튼을 눌렀을때 "메세지를 전송했습니다"를 보여준다
                messageManager.sendMessage(text: message)
                message = ""
            } label: {
                // 2) 메세지 전송 아이콘
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.white) // paperplane 아이콘 컬러 : white
                    .padding(10) // 패딩값 : 10
                    .background(Color("Peach")) // 아이콘 background 컬러 : Peach
                    .cornerRadius(50) // 원 반지름값 : 50
            }
        }
        // 3) 메세지 입력란 디자인
        .padding(.horizontal) // 패딩값 : 가로
        .padding(.vertical, 10) // 패딩값 : 세로, 10
        .background(Color("Gray")) // 배경화면 컬러 : Gray
        .cornerRadius(50) // 반지름값 : 50
        .padding()
    }
}

struct MessageField_Previews: PreviewProvider {
    static var previews: some View {
        MessageField()
            // 메세지 관리자
            .environmentObject(MessageManager())
    }
}

// MessageField
struct CustomTextField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool) -> () = {_ in}
    var commit: () -> () = {}
    
    var body: some View {
        ZStack(alignment: .leading) {
            // 만약 text가 비어있다면?
            if text.isEmpty {
                placeholder
                    .opacity(0.5) // text 불투명도 : 0.5
            }
            // 처음엔 비어있는 상태가 된다
            TextField("",text: $text, onEditingChanged: editingChanged, onCommit: commit)
        }
    }
}
