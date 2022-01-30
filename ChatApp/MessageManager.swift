//
//  MessageManager.swift
//  ChatApp
//
//  Created by SeongHoKim on 2022/01/30.
//
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

// MessageManager : 메세지와 관련된 모든것을 관리하고 FireStore에서 실시간으로 데이터를 읽고 데이터베이스를 사용하고 관리함
class MessageManager: ObservableObject {
    // Message 상태
    @Published private(set) var messages: [Message] = [] // 처음부터 메세지의 상태를 빈상태로 초기화
    @Published private(set) var lastmessageid = "" // 마지막 메세지 id 상태
    // DB 데이터베이스
    let db = Firestore.firestore() // firestore의 db인스턴스 생성
    
    // 초기화
    init() {
        getMessages() // // MessageManager 클래스를 초기화할때 getMessages 함수를 호출한다
    }
    
    // 메세지 받는함수
    func getMessages() {
        // 1) 메세지를 받았을때
        // DB 데이터베이스를 호출해서,Firestore에 생성한 messages 컬렉션의 메세지를 호출한다
        db.collection("messages").addSnapshotListener { QuerySnapshot, error in
            // Firebase document 문서
            // 만약 document를 가져오는데 성공하면 코드를 수행하고
            guard let documents = QuerySnapshot?.documents else {
                // 만약에 실패하면 콘솔에 document 문서 가져오기 실패한 이유(error)를 출력하고 반환한다
                print("Error fetching documents: \(String(describing: error))")
                return
            }
            // 2) messages에 documents 초기화
            self.messages = documents.compactMap { document -> Message? in
                do {
                    // Firestore 문서의 데이터를 가져와서 메세지 파일에서 만든 메세지모델로 변환하도록 시도하고
                    return try document.data(as: Message.self)
                } catch {
                    // 만약에 변환에 실패하면 디코딩 실패이유를 출력하고 nil을 반환한다
                    print("Error decoding document into Message : \(error)")
                    return nil
                }
            }
            // 3) message 정렬
            self.messages.sort {$0.timestamp < $1.timestamp} // 가장 오래된날짜부터 최신날짜까지 타임스탬프별로 메세지를 정렬
            
            // 4) last message id
            if let id =  self.messages.last?.id {
                self.lastmessageid = id
            }
        }
    }
    
    // 메세지 보내는함수
    func sendMessage(text: String) {
        do {
            // 새로운 메세지 (UUID : 임시ID)
            let newMessage = Message(id: "\(UUID())", text: text, received: false, timestamp: Date())
            try db.collection("messages").document().setData(from: newMessage) // 메세지 컬렉션에 messages라는 문서에 저장하고,setdata에 새로운 메세지를 Firestore 데이터로 변환한다
        } catch {
            // 만약 오류가 발생한다면?
            print("Error adding message to Firestore \(error)") // 콘솔창에 실제 오류원인을 출력한다
        }
    }
}
