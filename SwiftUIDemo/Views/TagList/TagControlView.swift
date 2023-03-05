//
//  TagControlView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/03/06.
//

import SwiftUI

struct TagControlView: View {
    @State var text = ""
    @State var tags: [Tag] = []
    @State var showAlert = false
    
    var body: some View {
        VStack {
            Text("Tag item test")
                .font(.title3)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // tag view
            TagView(maxLimit: 150, tags: $tags)
                .frame(height: 280)
                .padding(.top, 20)
            
            // input field
            TextField("input", text: $text)
                .font(.title3)
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(Color.blue.opacity(1.0), lineWidth: 1)
                )
                .padding(.vertical, 20)
            
            // add button
            Button(action: {
                addTag(tags: tags, text: text, fontSize: 16, maxLimit: 150) { alert, tag in
                    if alert {
                        showAlert.toggle()
                    } else {
                        tags.append(tag)
                        text = ""
                    }
                }
            }) {
                Text("Add item")
                    .foregroundColor(.black)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 45)
                    .background(.blue)
                    .cornerRadius(10)
            }
            .disabled(text == "")
            .opacity(text == "" ? 0.6 : 1)
        }
        .padding(15)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"),
                  message: Text("Tag limit exceeded try to delete some tags..."),
                  dismissButton: .destructive(Text("OK")))
        }
    }

}

struct TagControlView_Previews: PreviewProvider {
    static var previews: some View {
        TagControlView()
    }
}

extension TagControlView {
    
    struct TagView: View {
        var maxLimit: Int
        @Binding var tags: [Tag]
        
        var fontSize: CGFloat = 16
        
        @Namespace var animation
        
        var body: some View {
            VStack(alignment: .leading, spacing: 15) {
                Text("Add tags")
                    .font(.callout)
                    .foregroundColor(.black)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(getRows(), id: \.self) { rows in
                            HStack(spacing: 6) {
                                ForEach(rows) { row in
                                    RowView(tag: row)
                                }
                            }
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width - 80, alignment: .leading)
                    .padding(.vertical)
                    .padding(.bottom, 20)
                }
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(.blue, lineWidth: 1)
                )
                .animation(.easeOut, value: tags)
                .overlay(alignment: .bottomTrailing) {
                    Text("\(getSize(tags: tags))/\(maxLimit)")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(12)
                }
            }
        }
        
        @ViewBuilder func RowView(tag: Tag) -> some View {
            Text(tag.text)
                .foregroundColor(.black)
                .lineLimit(1)
                .font(.system(size: 16))
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .strokeBorder(.blue, lineWidth: 1)
                )
                .contentShape(Capsule())
                .contextMenu {
                    Button("Delete") {
                        tags.remove(at: getIndex(tag: tag))
                    }
                }
                .matchedGeometryEffect(id: tag.id, in: animation)
        }
        
        func getIndex(tag: Tag) -> Int {
            let index = tags.firstIndex { currentTag in
                return tag.id == currentTag.id
            } ?? 0
            
            return index
        }
        
        func getRows() -> [[Tag]] {
            var rows: [[Tag]] = []
            var currentRow: [Tag] = []
            
            var totalWidth: CGFloat = 0
            let screenWidth: CGFloat = UIScreen.main.bounds.width - 90
            
            tags.forEach { tag in
                totalWidth += (tag.size + 40)
                
                if totalWidth > screenWidth {
                    totalWidth = (!currentRow.isEmpty || rows.isEmpty ? (tag.size + 40) : 0)
                    
                    rows.append(currentRow)
                    currentRow.removeAll()
                    currentRow.append(tag)
                } else {
                    currentRow.append(tag)
                }
            }
            
            if !currentRow.isEmpty {
                rows.append(currentRow)
                currentRow.removeAll()
            }
            
            return rows
        }
    }
}

struct Tag: Identifiable, Hashable {
    var id = UUID().uuidString
    var text: String
    var size: CGFloat = 0
}

func addTag(tags: [Tag], text: String, fontSize: CGFloat, maxLimit: Int, completion: @escaping (Bool, Tag) -> ()) {
    let font = UIFont.systemFont(ofSize: fontSize)
    let attributes = [NSAttributedString.Key.font: font]
    let size = (text as NSString).size(withAttributes: attributes)
    
    let tag = Tag(text: text, size: size.width)
    
    if (getSize(tags: tags) + text.count) < maxLimit {
        completion(false, tag)
    } else {
        completion(true, tag)
    }
}


func getSize(tags: [Tag]) -> Int {
    var count = 0
    
    tags.forEach { tag in
        count += tag.text.count
    }
    
    return count
}
