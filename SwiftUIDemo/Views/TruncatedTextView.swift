//
//  TruncatedTextView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/03/05.
//

import SwiftUI

struct TruncatedTextView: View {
    @State private var truncate = false
    
    var originalText: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"
    
    var body: some View {
        VStack {
            TruncatedText(text: originalText)
                .font(.body)
                .foregroundColor(.primary)
                .lineLimit(2)
                .expandAnimation(.easeOut)
                .padding()
            
            Divider()
            
            VStack {
                Text(self.originalText)
                    .lineLimit(self.truncate ? nil : 3)
                
                Button("show all") {
                    self.truncate.toggle()
                }
            }
            .padding()
        }
    }
}

struct TruncatedTextView_Previews: PreviewProvider {
    static var previews: some View {
        TruncatedTextView()
    }
}

// MARK: TruncatedText
class TruncatedTextConfiguration {
    var animation: Animation? = .none
    var foregroundColor: Color = .primary
    var font: Font = .body
    var lineLimit: Int = 3
}

struct TruncatedText: View {
    var text : String
    let configuration = TruncatedTextConfiguration()
    
    @State private var isExpand = false
    @State private var buttonSize: CGSize = .zero
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            Text(text)
                .font(self.configuration.font)
                .foregroundColor(self.configuration.foregroundColor)
                .lineLimit(self.isExpand ? nil : self.configuration.lineLimit)
                .animation(configuration.animation, value: self.isExpand)
                .mask {
                    VStack(spacing: 0){
                        Rectangle()
                        
                        HStack(spacing: 0){
                            Rectangle()
                            
                            if self.isExpand == false {
                                HStack(alignment: .bottom, spacing: 0){
                                    LinearGradient(
                                        gradient: Gradient(stops: [
                                            Gradient.Stop(color: .black, location: 0),
                                            Gradient.Stop(color: .clear, location: 0.8)]),
                                        startPoint: .leading,
                                        endPoint: .trailing)
                                    .frame(width: 32, height: buttonSize.height)
                                    
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .frame(width: buttonSize.width, alignment: .center)
                                }
                                .border(.red)
                            } else {
                                HStack(alignment: .bottom, spacing: 0){
                                    LinearGradient(
                                        gradient: Gradient(stops: [
                                            Gradient.Stop(color: .black, location: 0),
                                            Gradient.Stop(color: .clear, location: 0.8)]),
                                        startPoint: .leading,
                                        endPoint: .trailing)
                                    .frame(width: 32, height: buttonSize.height)
                                    
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .frame(width: buttonSize.width, alignment: .center)
                                }
                            }
                        }
                        .frame(height: self.buttonSize.height)
                    }
                }
            
            if self.isExpand {
                Button(action: { self.isExpand.toggle() }) {
                    Image(systemName: "arrow.up.circle")
                }
            } else {
                Button(action: { self.isExpand.toggle() }) {
                    Image(systemName: "arrow.down.circle")
                }
                .readSize {
                    self.buttonSize = $0
                }
                
            }
        }
    }
}

extension TruncatedText {
    func font(_ font: Font) -> TruncatedText {
        self.configuration.font = font
        return self
    }
    
    func lineLimit(_ lineLimit: Int) -> TruncatedText {
        self.configuration.lineLimit = lineLimit
        return self
    }
    
    func foregroundColor(_ color: Color) -> TruncatedText {
        self.configuration.foregroundColor = color
        return self
    }
    
    func expandAnimation(_ animation: Animation?) -> TruncatedText {
        self.configuration.animation = animation
        return self
    }
}
