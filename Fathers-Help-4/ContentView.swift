//
//  ContentView.swift
//  Fathers-Help-4
//
//  Created by Andrei Gorbunov on 10.03.2024.
//

import SwiftUI

struct ButtonStyleView: ButtonStyle {
    @State private var activeAnimation = false
    let duration = 0.22
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.blue)
            .padding()
            .background {
                Circle()
                    .opacity(activeAnimation ? 0.1 : 0)
            }
            .scaleEffect(activeAnimation ? 0.86 : 1)
            .animation(.easeOut(duration: duration), value: activeAnimation)
            .onChange(of: configuration.isPressed) { _, newValue in
                guard newValue else { return }
                
                withAnimation(
                    .easeOut(duration: duration)
                ) {
                    activeAnimation = true
                } completion: {
                    activeAnimation = false
                }
            }
    }
}

struct ContentView: View {
    @State private var activeAnimation = false
    
    var body: some View {
        Button {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.0)) {
                activeAnimation = true
            } completion: {
                activeAnimation = false
            }
        } label: {
            GeometryReader { proxy in
                let width = proxy.size.width / 2
                let systemName = "play.fill"
                
                HStack(alignment: .center, spacing: 0) {
                    Image(systemName: systemName)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: activeAnimation ? width : .zero)
                        .opacity(activeAnimation ? 1 : .zero)
                    
                    Image(systemName: systemName)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: width)
                    
                    Image(systemName: systemName)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: activeAnimation ? 0.5 : width)
                        .opacity(activeAnimation ? .zero : 1)
                }
                .frame(maxHeight: .infinity, alignment: .center)
            }
        }
        .frame(maxWidth: 100)
        .buttonStyle(ButtonStyleView())
    }
}

#Preview {
    ContentView()
}
