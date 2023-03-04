//
//  GradientsView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/03/05.
//

import SwiftUI

struct GradientsView: View {
    var body: some View {
        VStack {
            // Title
            Text("LinearGradient")
                .font(.title3)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            ScrollView {   
                self.linearGradient
                
                self.linearGradientStop
                
                self.radialGradient
                
                self.angularGradient
                
            }
            
            Spacer()
        }
    }
}

struct GradientsView_Previews: PreviewProvider {
    static var previews: some View {
        GradientsView()
    }
}

// MARK: LinearGradient
extension GradientsView {
    var linearGradient: some View {
        // Creates a gradient from an array of colors.
        HStack {
            VStack {
                Text("from leading to trailing")
                    .frame(maxWidth: .infinity, alignment: .leading)
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.green]),
                                       startPoint: .leading,
                                       endPoint: .trailing)
                    )
                    .frame(width: 200, height: 100)
                    .border(.red)
            }
        }
        .padding()
    }
    
    var linearGradientStop: some View {
        // The array of color stops.
        HStack {
            VStack {
                Text("Using Gradient.Stop")
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                Gradient.Stop(color: .blue, location: 0.3),
                                Gradient.Stop(color: .black, location: 0.7),
                            ]),
                            startPoint: .top,
                            endPoint: .bottom)
                    )
                    .frame(width: 200, height: 100)
                    .border(.red)
            }
            
            VStack {
                Text("Using Gradient init")
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: .blue, location: 0.45),
                                .init(color: .black, location: 0.55),
                            ]),
                            startPoint: .top,
                            endPoint: .bottom)
                    )
                    .frame(width: 200, height: 100)
                    .border(.red)
            }
        }
        .padding()
    }
}

// MARK: RadialGradient
extension GradientsView {
    var radialGradient: some View {
        VStack {
            Text("Using RadialGradient init")
                .frame(maxWidth: .infinity, alignment: .leading)
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    RadialGradient(gradient: Gradient(colors: [.blue, .yellow]),
                                   center: .center,
                                   startRadius: 20,
                                   endRadius: 100)
                )
                .frame(width: 200, height: 100)
        }
        .padding()
    }
}

// MARK: AngularGradient
extension GradientsView {
    var angularGradient: some View {
        VStack {
            Text("Using AngularGradient init")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        AngularGradient(
                            gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]),
                            center: .center)
                    )
                    .frame(width: 100, height: 100)
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        AngularGradient(
                            gradient: Gradient(colors: [.red, .blue]),
                            center: .center,
                            angle: .degrees(0))
                    )
                    .frame(width: 100, height: 100)
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        AngularGradient(
                            colors: [.red, .blue],
                            center: .center,
                            startAngle: .degrees(90),
                            endAngle: .degrees(180))
                        
                    )
                    .frame(width: 100, height: 100)
            }
        }
        .padding()
    }
}
