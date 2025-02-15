//
//  SwiftUIView.swift
//  ChatApp
//
//  Created by GNIAL App on 9/2/25.
//

import SwiftUI

struct RingLoaderView: View {
    
    @State private var rotationAngle: Double = 0
    
    var body: some View {
        ZStack {
            Rectangle ()
                .opacity(0.3)
                .ignoresSafeArea()
            
           Loader()
        }
    }
}

#Preview {
    RingLoaderView()
}
