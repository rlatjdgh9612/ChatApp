//
//  Extensions.swift
//  ChatApp
//
//  Created by SeongHoKim on 2022/01/29.
//
import Foundation
import SwiftUI

// 모서리에 둥근 모서리를 추가하기 위한 View 확장자 추가
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}

// 코너 모서리 확장에 대한 사용자 지정을 위한 RoundedCorner 확장자 추가
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
