//
//  PathTestView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/10/23.
//

import SwiftUI

struct PathTestView: View {
    var body: some View {
        VStack(spacing: 10) {
            //TrianglePathView()
            Text("Hello, World!")
                .foregroundColor(.black).font(.title).padding(15)
                .background(RectangleView(color: .blue))
            
            Text("Hello, World!")
                .foregroundColor(.black).font(.title).padding(15)
                .background(TriangleView(color: .blue))
            
            Text("Hello, World!")
                .foregroundColor(.black).font(.title).padding(15)
                .clipShape(TriangleShape())
            
            Text("Hello, World!")
                .foregroundColor(.black).font(.title).padding(15)
                .clipShape(ArcShape(startAngle: .degrees(0),
                                    endAngle: .degrees(110),
                                    clockwise: true))
            Text("Hello, World!")
                .foregroundColor(.black).font(.title).padding(15)
                .background(RoundedCornerView())
            
            RoundedCurveRectangleShape(curveOffset: 16)
                .fill(Color.blue)
                .frame(width: 100, height: 100, alignment: .center)
            
            Balloon()
                .fill(Color.blue)
                .frame(width: 100, height: 100, alignment: .center)
        }
    }
}

struct PathTestView_Previews: PreviewProvider {
    static var previews: some View {
        PathTestView()
    }
}

// MRAK: Path view
struct TrianglePathView: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 200, y: 100))
            path.addLine(to: CGPoint(x: 100, y: 300))
            path.addLine(to: CGPoint(x: 300, y: 300))
            path.addLine(to: CGPoint(x: 200, y: 100))
            
            path.closeSubpath()
        }
        .stroke(.blue, lineWidth: 20)
    }
}

struct RectangleView: View {
    var color: Color
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let w = geometry.size.width
                let h = geometry.size.height
                
                path.move(to: CGPoint(x: w, y: 0))
                path.addLine(to: CGPoint(x: w, y: h))
                path.addLine(to: CGPoint(x: 0, y: h))
                path.addLine(to: CGPoint(x: 0, y: 0))
                path.closeSubpath()
            }
            .stroke(self.color, lineWidth: 5)
        }
    }
}

struct TriangleView: View {
    var color: Color
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let w = geometry.size.width
                let h = geometry.size.height

                path.move(to: CGPoint(x: w / 2, y: 0))
                path.addLine(to: CGPoint(x: 0, y: h))
                path.addLine(to: CGPoint(x: w, y: h))
                path.addLine(to: CGPoint(x: w / 2, y: 0))
                path.closeSubpath()
            }
            .stroke(Color.blue, lineWidth: 5)
        }
    }
}

struct RoundedCornerView: View {
    var color: Color = .black
    var tl: CGFloat = 10.0 // top-left radius parameter
    var tr: CGFloat = 10.0 // top-right radius parameter
    var bl: CGFloat = 10.0 // bottom-left radius parameter
    var br: CGFloat = 10.0 // bottom-right radius parameter
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let w = geometry.size.width
                let h = geometry.size.height
                
                // make sure the radius does not exceed the bounds dimensions
                let tr = min(min(self.tr, h/2), w/2)
                let tl = min(min(self.tl, h/2), w/2)
                let bl = min(min(self.bl, h/2), w/2)
                let br = min(min(self.br, h/2), w/2)
                
                path.move(to: CGPoint(x: w / 2.0, y: 0))
                path.addLine(to: CGPoint(x: w - tr, y: 0))
                path.addArc(center: CGPoint(x: w - tr, y: tr),
                            radius: tr,
                            startAngle: Angle(degrees: -90),
                            endAngle: Angle(degrees: 0),
                            clockwise: false)
                
                path.addLine(to: CGPoint(x: w, y: h - br))
                path.addArc(center: CGPoint(x: w - br, y: h - br),
                            radius: br,
                            startAngle: Angle(degrees: 0),
                            endAngle: Angle(degrees: 90),
                            clockwise: false)
                
                path.addLine(to: CGPoint(x: bl, y: h))
                path.addArc(center: CGPoint(x: bl, y: h - bl),
                            radius: bl,
                            startAngle: Angle(degrees: 90),
                            endAngle: Angle(degrees: 180),
                            clockwise: false)
                
                path.addLine(to: CGPoint(x: 0, y: tl))
                path.addArc(center: CGPoint(x: tl, y: tl),
                            radius: tl,
                            startAngle: Angle(degrees: 180),
                            endAngle: Angle(degrees: 270),
                            clockwise: false)
                
                path.closeSubpath()
            }
            .stroke(self.color)
        }
    }
}

// MARK: Shape
struct TriangleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct RoundedCurveRectangleShape: Shape {
    var curveOffset: CGFloat = 10
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            // start point
            path.move(to: CGPoint(x: rect.width, y: 10))
            
            path.addQuadCurve(to: CGPoint(x: rect.width, y: rect.height - 8),
                              control: CGPoint(x: rect.width + 10, y: rect.height / 2))
            path.addArc(center: CGPoint(x: rect.width - 10, y: rect.height - 10),
                        radius: 10,
                        startAngle: Angle(degrees: 0),
                        endAngle: Angle(degrees: 90),
                        clockwise: false)
                    
            path.addQuadCurve(to: CGPoint(x: 8, y: rect.height),
                              control: CGPoint(x: rect.width / 2, y: rect.height + 10))
            path.addArc(center: CGPoint(x: 10, y: rect.height - 10),
                        radius: 10,
                        startAngle: Angle(degrees: 90),
                        endAngle: Angle(degrees: 190),
                        clockwise: false)

            path.addQuadCurve(to: CGPoint(x: 0, y: 8),
                              control: CGPoint(x: -10, y: rect.height / 2))
            path.addArc(center: CGPoint(x: 10, y: 10),
                        radius: 10,
                        startAngle: Angle(degrees: 180),
                        endAngle: Angle(degrees: 270),
                        clockwise: false)

            path.addQuadCurve(to: CGPoint(x: rect.width - 8, y: 0),
                              control: CGPoint(x: rect.width / 2, y: -10))
            path.addArc(center: CGPoint(x: rect.width - 10, y: 10),
                        radius: 10,
                        startAngle: Angle(degrees: -90),
                        endAngle: Angle(degrees: 0),
                        clockwise: false)
        }
    }
}

struct ArcShape: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                    radius: rect.width / 2,
                    startAngle: modifiedStart,
                    endAngle: modifiedEnd,
                    clockwise: !clockwise)
        
        return path
    }
}

struct Balloon: Shape {
    func path(in rect: CGRect) -> Path {
        //var path = Path()
        let balloon = Path { p in
            p.move(to: CGPoint(x: 50, y: 0))
            p.addQuadCurve(to: CGPoint(x: 0, y: 50),
                           control: CGPoint(x: 0, y: 0))
            p.addCurve(to: CGPoint(x: 50, y: 150),
                       control1: CGPoint(x: 0, y: 100),
                       control2: CGPoint(x: 50, y: 100))
            p.addCurve(to: CGPoint(x: 100, y: 50),
                       control1: CGPoint(x: 50, y: 100),
                       control2: CGPoint(x: 100, y: 100))
            p.addQuadCurve(to: CGPoint(x: 50, y: 0),
                           control: CGPoint(x: 100, y: 0))
        }
        let bounds = balloon.boundingRect
        let scaleX = rect.size.width/bounds.size.width
        let scaleY = rect.size.height/bounds.size.height
        return balloon.applying(CGAffineTransform(scaleX: scaleX, y: scaleY))
    }
}
