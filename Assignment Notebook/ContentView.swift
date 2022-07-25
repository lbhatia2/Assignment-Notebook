//
//  ContentView.swift
//  Assignment Notebook
//
//  Created by Lina Bhatia on 7/25/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var assignmentList = assignmentList()
    @State private var showingAddItemView = false
    
    var body: some View {
        NavigationView{
            List{
                ForEach(AssignmentList.item){item in
                    HStack {
                        VStack{
                            Text(item.course)
                                .font(.headline)
                            Text(item.description)
                        }
                        Spacer()
                        Text(item.dueDate, style: .date)
                    }
                }

                .onMove{indices , newOffset in
                    assignmentList.items.move(fromOffsets: indices, toOffset: newOffset)
                }
                .onDelete{indexSet in
                    assignmentList.items.remove(atOffsets: indexSet )
                }
                
            }
            .sheet(isPresented: $showingAddItemView, content: {
                AddItemView(assignmentList : assignmentList)
            })
            .navigationBarTitle("Assignment Notebook", displayMode: .inline)
            .navigationBarItems(leading: EditButton(),
                                trailing:Button(action: {
                showingAddItemView = true}){
                    Image(systemName: "plus")
                })
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct AssignmentItems: Identifiable, Codable{
    var id = UUID()
    var course = String()
    var description = String()
    var dueDate = Date()
}
