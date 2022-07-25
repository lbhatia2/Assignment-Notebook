//
//  AddAssignmentView.swift
//  Assignment Notebook
//
//  Created by Lina Bhatia on 7/25/22.
//

import SwiftUI

struct AddAssignmentView: View {
    @ObservedObject var assignmentList : AssignmentList
    @State private var course = ""
    @State private var description = ""
    @State private var dueDate = Date()
    @Environment(\.presentationMode) var presentationMode
    static let courses = ["essay", "computer science", "math"]
    var body: some View {
        NavigationView{
            Form{
                Picker("Course", selection: $course){
                    ForEach(Self.courses, id: \.self) {course in Text(course)
                        
                    }
                }
                TextField("Description", text: $description)
                DatePicker("Due Date", selection: $dueDate, displayedComponents: .date )
                
            }
            .navigationBarTitle("New to-do note", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save"){
                if course.count > 0 && description.count > 0{
                    let item = AssignmentItems(id: UUID(), course: course, description:description, dueDate: dueDate)
                    assignmentList.items.append(item)
                    presentationMode.wrappedValue.dismiss()
                    
                }
            })
            
        }
        
    }
}

struct AddAssignmentView_Previews: PreviewProvider {
    static var previews: some View {
        AddAssignmentView(assignmentList: AssignmentList())
    }
}
