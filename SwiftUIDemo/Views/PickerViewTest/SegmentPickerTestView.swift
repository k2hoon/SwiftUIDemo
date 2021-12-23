//
//  SegmentPickerTestView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/12/22.
//

import SwiftUI

struct SegmentPickerTestView: View {
    @State private var selection = 0
    
    let items: [SegmentItem] = [.init(title: "A"), .init(title: "B"), .init(title: "C")]
    
    var body: some View {
        ZStack {
            // Views
            TabView(selection: $selection) {
                SegmentContentView1().tag(0)
                SegmentContentView2().tag(1)
                SegmentContentView3().tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                SegmentPickerView(items: self.items, selection: self.$selection)
                    .padding()
            }
        }
    }
    
    struct SegmentContentView1: View {
        var body: some View {
            ZStack {
                Color.green300
                    .ignoresSafeArea()
                Text("SegmentContentView1")
            }
            .onAppear {
                print("SegmentContentView1::onAppear")
            }
            .onDisappear {
                print("SegmentContentView1::onDisappear")
            }
        }
    }
    
    struct SegmentContentView2: View {
        var body: some View {
            ZStack {
                Color.red300
                    .ignoresSafeArea()
                Text("SegmentContentView2")
            }
            .onAppear {
                print("SegmentContentView2::onAppear")
            }
            .onDisappear {
                print("SegmentContentView2::onDisappear")
            }
        }
    }
    
    struct SegmentContentView3: View {
        var body: some View {
            ZStack {
                Color.blue700
                    .ignoresSafeArea()
                Text("SegmentContentView3")
            }
            .onAppear {
                print("SegmentContentView3::onAppear")
            }
            .onDisappear {
                print("SegmentContentView3::onDisappear")
            }
        }
    }
}

struct SegmentPickerTestView_Previews: PreviewProvider {
    static var previews: some View {
        SegmentPickerTestView()
    }
}
