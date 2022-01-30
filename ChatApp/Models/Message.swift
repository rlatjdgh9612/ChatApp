//
//  Message.swift
//  ChatApp
//
//  Created by SeongHoKim on 2022/01/29.
//
import Foundation

// Message : 메세지와 관련된 id, text, 수신상태, 수신시각을 관리함
struct Message : Identifiable, Codable {
    // 메세지 저장 프로퍼티
    var id: String // 메세지 ID
    var text: String // 메세지 text
    var received: Bool // 수신상태 (사용자가 메세지를 보냈을경우의 수신상태 : false / 사용자가 메세지를 수신받았을경우의 수신상태 : true)
    var timestamp: Date // 메세지 수신 시각
}
