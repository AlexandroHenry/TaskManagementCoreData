//
//  DynamicFilteredView.swift
//  TaskManagementCoreData
//
//  Created by Seungchul Ha on 2022/12/19.
//

import SwiftUI
import CoreData

struct DynamicFilteredView<Content: View, T>: View where T: NSManagedObject {
    
    // MARK: Core Data Request
    @FetchRequest var request: FetchedResults<T>
    let content: (T) -> Content
    
    // MARK: Building Custom ForEach which will give Coredata object to build View
    init(dateToFilter: Date, @ViewBuilder content: @escaping (T) -> Content) {
        
        // MARK: Predicate to Filter current date Tasks
        let calendar = Calendar.current
        
        let today = calendar.startOfDay(for: dateToFilter)
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: dateToFilter)!
        
        // Filter Key
        let filterKey = "taskDate"
        
        // This will fetch task between today and tomorrow which is 24 HRS
        let predicate = NSPredicate(format: "\(filterKey) >= %@ AND \(filterKey) < %@", argumentArray: [today, tomorrow])
        
        // Initializing Request With NSPredicate
        // Adding Sort
        _request = FetchRequest(entity: T.entity(), sortDescriptors: [.init(keyPath: \Task.taskDate, ascending: false)], predicate: predicate)
        self.content = content
    }
    
    var body: some View {
        
        Group {
            if request.isEmpty {
                Text("No tasks found!!!")
                    .font(.system(size: 16))
                    .fontWeight(.light)
                    .offset(y: 100)
            } else {
                
                ForEach(request, id: \.objectID) { object in
                    self.content(object)
                }
            }
        }
    }
}
