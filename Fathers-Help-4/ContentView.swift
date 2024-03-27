//
//  ContentView.swift
//  Fathers-Help-4
//
//  Created by Andrei Gorbunov on 10.03.2024.
//

import SwiftUI

struct ButtonStyleView: ButtonStyle {
    @State var performAnimation = false
    let duration: TimeInterval = 0.22
    let scale: CGFloat = 0.86
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle()
                .foregroundStyle(.gray)
                .opacity(performAnimation ? 0.3 : 0)
                .frame(maxWidth: 100, maxHeight: 100)
            configuration.label
                .padding(12)
        }
        .scaleEffect(performAnimation ? scale : 1)
        .animation(.easeOut(duration: duration), value: configuration.isPressed)
        .onChange(of: configuration.isPressed) { _, newValue in
            guard newValue else { return }
            
            withAnimation(
                .easeOut(duration: duration)
            ) {
                performAnimation = true
            } completion: {
                performAnimation = false
            }
        }
    }
}

struct ImageView: View {
    var body: some View {
        Image(systemName: "play.fill")
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
    }
}

struct ContentView: View {
    @State var performAnimation: Bool = false
    
    var body: some View {
        Button {
            if !performAnimation {
                withAnimation(.spring) {
                    performAnimation = true
                } completion: {
                    performAnimation = false
                }
            }
        } label: {
            GeometryReader { proxy in
                let width = proxy.size.width / 2
                
                HStack(alignment: .center, spacing: 0) {
                    ImageView()
                        .frame(width: performAnimation ? width : .zero)
                        .opacity(performAnimation ? 1 : .zero)
                    
                    ImageView()
                        .frame(width: width)
                    
                    ImageView()
                        .frame(width: performAnimation ? 0.5 : width)
                        .opacity(performAnimation ? .zero : 1)
                }
            }
            .frame(maxWidth: 62, maxHeight: 62)
        }
        .buttonStyle(ButtonStyleView())
    }
}

#Preview {
    ContentView()
}
