//
//  ProfileView.swift
//  deeplink_swiftui_tutorial
//
//  Created by minkyuLee on 2022/07/29.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        Rectangle().foregroundColor(Color.blue)
            .frame(width:100, height: 100)
            .cornerRadius(15)
            .overlay(
            Text("프로필")
                .font(.system(size: 23))
                .fontWeight(.black)
                .foregroundColor(.white))
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
