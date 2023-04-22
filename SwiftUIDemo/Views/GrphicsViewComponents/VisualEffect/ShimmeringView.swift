//
//  ShimmeringVIew.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/09/15.
//

import SwiftUI

struct ShimmeringView: View {
    private struct Constants {
        static let duration: Double = 2
        static let minOpacity: Double = 0.25
        static let maxOpacity: Double = 1.0
        static let cornerRadius: CGFloat = 2.0
    }
    
    @State private var opacity: Double = Constants.minOpacity
    
    var body: some View {
        VStack {
            Text("Hello world")
                .redacted(reason: .placeholder)
                .shimmering()
            
            Text("Hello world")
                .shimmering()
            
            Text("Hello world")
                .redacted(reason: .placeholder)
                .shimmering(gradient: false)
            
            Text("Hello world")
                .shimmering(gradient: false, redacted: true)
        }
    }
}

struct ShimmeringView_Previews: PreviewProvider {
    static var previews: some View {
        //ShimmeringView()
        Group {
            Text("SwiftUI Shimmer")
            if #available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *) {
                Text("SwiftUI Shimmer").preferredColorScheme(.light)
                Text("SwiftUI Shimmer").preferredColorScheme(.dark)
                VStack(alignment: .leading) {
                    Text("Loading...").font(.title)
                    Text(String(repeating: "Shimmer", count: 12))
                        .redacted(reason: .placeholder)
                }.frame(maxWidth: 200)
            }
        }
        .padding()
        .shimmering()
        .previewLayout(.sizeThatFits)
    }
}

// MARK: -

public struct ShimmeringConfiguration {
    public let gradient: Gradient
    public let startLocation: (start: UnitPoint, end: UnitPoint)
    public let endLocation: (start: UnitPoint, end: UnitPoint)
    public let duration: TimeInterval
    public let opacity: Double
    public static let `default` = ShimmeringConfiguration(gradient: Gradient(stops: [.init(color: .black, location: 0),
                                                                                     .init(color: .white, location: 0.3),
                                                                                     .init(color: .white, location: 0.7),
                                                                                     .init(color: .black, location: 1)]),
                                                          startLocation: (start: UnitPoint(x: -1, y: 0.5), end: .leading),
                                                          endLocation: (start: .trailing, end: UnitPoint(x: 2, y: 0.5)),
                                                          duration: 2,
                                                          opacity: 0.6)
}

struct ShimmeringEffect<Content: View>: View {
    @State private var startPoint: UnitPoint
    @State private var endPoint: UnitPoint
    private let content: () -> Content
    private let configuration: ShimmeringConfiguration
    
    init(configuration: ShimmeringConfiguration, @ViewBuilder content: @escaping () -> Content) {
        self.configuration = configuration
        self.content = content
        _startPoint = .init(wrappedValue: configuration.startLocation.start)
        _endPoint = .init(wrappedValue: configuration.startLocation.end)
    }
    
    var body: some View {
        ZStack {
            content()
            LinearGradient(gradient: configuration.gradient, startPoint: startPoint, endPoint: endPoint)
                .opacity(configuration.opacity)
                .blendMode(.screen)
                .onAppear(perform: {
                    withAnimation(Animation.linear(duration: configuration.duration).repeatForever(autoreverses: false)) {
                        startPoint = configuration.endLocation.start
                        endPoint = configuration.endLocation.end
                    }
                })
        }
        .ignoresSafeArea()
    }
}

public struct ShimmerModifier: ViewModifier {
    let configuration: ShimmeringConfiguration
    public func body(content: Content) -> some View {
        ShimmeringEffect(configuration: configuration) {
            content
        }
    }
}

public extension View {
    func shimmer(configuration: ShimmeringConfiguration = .default) -> some View {
        modifier(ShimmerModifier(configuration: configuration))
    }
}

struct Shimmer: ViewModifier {
    
    private struct Constants {
        static let minOpacity: Double = 0.25
        static let maxOpacity: Double = 1.0
        static let cornerRadius: CGFloat = 2.0
    }
    
    @State private var opacity: Double = Constants.minOpacity
    @State private var phase: CGFloat = 0
    
    var duration = 2.0 // default 2.0
    var autoreverses = false
    var gradient = true
    var redacted = false
    
    func body(content: Content) -> some View {
        if gradient {
            content
                .modifier(AnimatedMask(phase: phase)
                            .animation(Animation.linear(duration: duration).repeatForever(autoreverses: autoreverses)))
                .onAppear { phase = 0.8 }
        } else {
            if redacted {
                content
                    .foregroundColor(.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: Constants.cornerRadius)
                            .fill(Color.blue)
                    )
                    .opacity(opacity)
                    .transition(.opacity)
                    .onAppear(perform: {
                        let baseAnimation = Animation.easeInOut(duration: duration)
                        let repeated = baseAnimation.repeatForever(autoreverses: true)
                        withAnimation(repeated) {
                            self.opacity = Constants.maxOpacity
                        }
                    })
            } else {
                content
                    .opacity(opacity)
                    .transition(.opacity)
                    .onAppear(perform: {
                        let baseAnimation = Animation.easeInOut(duration: duration)
                        let repeated = baseAnimation.repeatForever(autoreverses: autoreverses)
                        withAnimation(repeated) {
                            self.opacity = Constants.maxOpacity
                        }
                    })
            }
        }
    }
    
    /// An animatable modifier to interpolate between `phase` values.
    struct AnimatedMask: AnimatableModifier {
        var phase: CGFloat = 0
        
        var animatableData: CGFloat {
            get { phase }
            set { phase = newValue }
        }
        
        func body(content: Content) -> some View {
            content
                .mask(GradientMask(phase: phase).scaleEffect(3))
        }
    }
    
    
    /// A slanted, animatable gradient between transparent and opaque to use as mask.
    /// The `phase` parameter shifts the gradient, moving the opaque band.
    struct GradientMask: View {
        let phase: CGFloat
        let centerColor = Color.black
        let edgeColor = Color.black.opacity(0.3)
        
        var body: some View {
            LinearGradient(gradient:
                            Gradient(stops: [
                                .init(color: edgeColor, location: phase),
                                .init(color: centerColor, location: phase + 0.1),
                                .init(color: edgeColor, location: phase + 0.2)
                            ]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
}

extension View {
    /// Add a shimmering animation effect to any view, typically to show that an operation is in progress.
    /// - Parameters:
    ///   - active: Convenience parameter to conditionally enable the effect. Defaults to `true`.
    ///   - duration: The duration of a shimmer cycle in seconds. Default: `2.0`.
    ///   - autoreverses: Whether to autoreverse the animation back and forth. Defaults to `false`.
    /// - Returns: `View`
    @ViewBuilder func shimmering(active: Bool = true, duration: Double = 2.0, autoreverses: Bool = false) -> some View {
        if active {
            modifier(Shimmer(duration: duration, autoreverses: autoreverses))
        } else {
            self
        }
    }
    
    /// Add a shimmering animation effect to any view, typically to show that an operation is in progress.
    /// - Parameters:
    ///   - duration: duration description
    ///   - autoreverses: autoreverses description
    /// - Returns: description
    func shimmering(duration: Double = 2.0, autoreverses: Bool = false) -> some View {
        modifier(Shimmer(duration: duration, autoreverses: autoreverses))
    }
    
    func shimmering(duration: Double = 2.0, autoreverses: Bool = true, gradient: Bool) -> some View {
        modifier(Shimmer(duration: duration, autoreverses: autoreverses, gradient: gradient))
    }
    
    func shimmering(duration: Double = 2.0, autoreverses: Bool = true, gradient: Bool, redacted: Bool) -> some View {
        modifier(Shimmer(duration: duration, autoreverses: autoreverses, gradient: gradient, redacted: redacted))
    }
}
