//
//  ShimmerListView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2021/09/15.
//

import SwiftUI

struct ShimmerListView: View {
    @StateObject var viewModel = ShimmerListViewModel()
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.gray
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor : UIColor.white]
        UISegmentedControl.appearance().setTitleTextAttributes(attributes, for: .selected)
    }
    
    var body: some View {
        ZStack {
            VStack {
                Picker(selection: $viewModel.userInfoResult, label: EmptyView()) {
                    ForEach(ShimmerListViewModel.UserInfoResult.allCases, id: \.rawValue) { result in
                        Text(result.description).tag(result)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .background(Color.gray100)
                
                AsyncContentsList(
                    loadingState: viewModel.loadingState,
                    content: ShimmerListContentsView.init(items:),
                    empty: {
                        ShimmerListEmptyView(message: "There are no news items",
                                             image: "exclamationmark.bubble")
                    },
                    error: {
                        ShimmerListEmptyView(message: $0.localizedDescription,
                                             image: "exclamationmark.triangle")
                        .foregroundColor(.red)
                    })
            }
            .onAppear {
                viewModel.reload()
            }
        }
    }
}

struct ShimmerListView_Previews: PreviewProvider {
    static var previews: some View {
        ShimmerListView()
    }
}
