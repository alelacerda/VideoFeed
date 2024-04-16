//
//  IconView.swift
//  VideoFeed
//
//  Created by Alessandra Fernandes Lacerda on 16/04/24.
//

import SwiftUI

struct IconView: View {
    var systemIcon: String
    var count: Int

    var body: some View {
        ZStack {
            Image(systemName: systemIcon)
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundStyle(.white)
            Text("\(count)")
                .foregroundStyle(.white)
                .background{
                    Circle()
                        .fill(.black)
                        .frame(width: 200)
                }
                .offset(x:24, y:-16)
        }
    }
}

#Preview {
    IconView(systemIcon: "heart.fill", count: 3)
}
