//
//  TitleRow.swift
//  ChatApp
//
//  Created by SeongHoKim on 2022/01/29.
//
import SwiftUI

// Title(제목) : 친구의 프로필 사진, 이름, 온라인/오프라인 상태, 전화 아이콘 상태를 관리함
struct TitleRow: View {
    // 이미지 URL
    var imageUrl = URL(string: "https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8")
    // 친구 이름
    var name = "스미스 선생님"
    
    var body: some View {
        // 수평 배열(HStack)
        HStack(spacing: 20) {
            // 1) 친구 프로필 사진
            AsyncImage(url: imageUrl) { image in
                image.resizable() // 이미지 크기조정
                    .aspectRatio(contentMode: .fill) // 화면비율 : fill
                    .frame(width: 50, height: 50) // 프레임 너비 : 50, 높이값 : 50
                    .cornerRadius(50) // 반지름 : 50
            } placeholder: {
                ProgressView()
            }
            
            // 수직 배열(VStack)
            VStack(alignment: .leading) {
                // 2) 친구 프로필 이름
                Text(name) // Sarah Smith
                    .font(.title).bold() // 폰트(글귀) : bold
                // 온라인 상태
                Text("현재 접속중")
                    .font(.caption)
                    .foregroundColor(.gray) // 폰트색깔 : gray
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // 3) 전화 아이콘
            Image(systemName: "phone.fill")
                .foregroundColor(.gray) // 전화아이콘 색깔 : gray
                .padding(10) //
                .background(.white) // 아이콘 화면 : white
                .cornerRadius(50) // 반지름 : 50
        }
        .padding()
    }
}

// 미리보기 View
struct TitleRow_Previews: PreviewProvider {
    static var previews: some View {
        TitleRow()
            .background(Color("Peach"))
    }
}
