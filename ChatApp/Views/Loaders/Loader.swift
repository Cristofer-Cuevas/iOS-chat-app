//
//  Loader.swift
//  ChatApp
//
//  Created by GNIAL App on 13/2/25.
//

import SwiftUI

struct Loader: View {
    @State private var rotationAngle: Double = 0
    var body: some View {
        VStack {
            Image("loaderOval")
                .rotationEffect(.degrees(rotationAngle))
                .onAppear {
                    withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                        rotationAngle = 360
                    }
                }
        }
    }
}

#Preview {
    Loader()
}
