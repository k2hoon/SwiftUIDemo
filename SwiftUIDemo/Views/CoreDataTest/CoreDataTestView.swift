//
//  CoreDataTestView.swift
//  SwiftUIDemo
//
//  Created by k2hoon on 2023/01/13.
//

import SwiftUI
import CoreData

struct CoreDataTestView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default
    )
    private var items: FetchedResults<Item>
    
    enum Filter: String, Identifiable, CaseIterable {
        var id: Self {
            return self
        }
        case all = "All"
        case favorite = "Favorite"
    }
    
    @State var filter = Filter.all
    
    var filterdList: [Item] {
        switch self.filter {
        case .all: return items.map { $0 }
        case .favorite:
            return items.filter { item -> Bool in
                item.favorite == true
            }
        }
    }
    
    var body: some View {
        VStack {
            Picker("", selection: $filter) {
                ForEach(Filter.allCases) { filter in
                    Text("\(filter.rawValue)")
                }
            }
            .pickerStyle(.segmented)
            
            NavigationView {
                List {
                    ForEach(self.filterdList) { item in
                        NavigationLink {
                            Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                        } label: {
                            VStack(alignment: .leading, spacing: 8) {
                                Image(systemName: item.favorite ? "star.fill" : "star")
                                
                                HStack {
                                    Text(item.name!)
                                    Text(item.timestamp!, formatter: itemFormatter)
                                }
                            }
                            
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        Button(action: addItem) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
                Text("Select an item")
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.name = String(format: "Item %d", self.items.count)
            newItem.favorite = (self.items.count) % 2 == 0 ? true : false

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct CoreDataTestView_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataTestView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
