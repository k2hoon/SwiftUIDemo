//
//  GraphicsView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/04/22.
//

import SwiftUI

struct GraphicsView: View {
    var body: some View {
        VStack {
            Text("Graphics")
                .font(.title2)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            ScrollView {
                LazyVStack(spacing: 22) {
                    ForEach(ViewType.allCases, id: \.self) { view in
                        NavigationLink(destination: { view.viewBuilder() }) {
                            Text(view.rawValue)
                                .font(.callout)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .frame(height: 150)
                                .background(.white)
                                .padding(.horizontal, 12)
                                .cornerRadius(8)
                                .shadow(color: .black.opacity(0.25), radius: 6, x: 4, y: 4)
                        }
                    }
                }
            }
        }
    }
}

struct GraphicsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GraphicsView()
        }
    }
}

extension GraphicsView {
    enum ViewType: String, CaseIterable {
        case gradients = "Gradients Test"
        case animatable = "Animatable Test"
        case mask = "Mask Test"
        case maskList = "Mask List Test"
        case material = "Material Test"
        case path = "Path test"
        case blur = "Blur test"
        case shimmer = "Shimmer test"
        
        @ViewBuilder func viewBuilder() -> some View {
            switch self {
            case .gradients: GradientsView()
            case .animatable: AnimatableModifierView()
            case .mask: MaskView()
            case .maskList: MaskListView()
            case .material: MaterialView()
            case .path: PathTestView()
            case .blur: BlurEffectView()
            case .shimmer: ShimmeringView()
            }
        }
    }
}
