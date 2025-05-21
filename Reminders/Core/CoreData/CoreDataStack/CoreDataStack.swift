import CoreData
import Observation

@Observable
class CoreDataStack {
    static let shared = CoreDataStack()
    
    let container: NSPersistentContainer
    var reminderLists: [ReminderListEntity] = []
    var reminders: [ReminderEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "Reminder")
        container.loadPersistentStores { desc, err in
            if let err = err {
                print("Could not load persistent store: \(err.localizedDescription)")
            }
        }
        
        getData()
    }
    
    func addList(color: String, icon: String, title: String) {
        add(item: ReminderListEntity.self) { newItem in
            newItem.createdAt = Date()
            newItem.reminderColor = color
            newItem.reminderIcon = icon
            newItem.reminderTitle = title
        }
        
        reminderLists = fetchData(entityType: ReminderListEntity.self)
    }
    
    func deleteList(item: ReminderListEntity) {
        delete(item: item)
        reminderLists = fetchData(entityType: ReminderListEntity.self)
    }
    
    func addReminder(title: String, notes: String, remindAt: Date, to list: ReminderListEntity) {
        add(item: ReminderEntity.self) { newReminder in
            newReminder.title = title
            newReminder.notes = notes
            newReminder.createdAt = Date()
            newReminder.isCompleted = false
            newReminder.remindAt = remindAt
            newReminder.list = list
        }
        
        reminders = fetchData(entityType: ReminderEntity.self)
    }
    
    func deleteReminder(item: ReminderEntity) {
        delete(item: item)
        reminders = fetchData(entityType: ReminderEntity.self)
    }
    
    func editReminder(
        reminder: ReminderEntity,
        newTitle: String,
        newNotes: String,
        newIsCompleted: Bool
    ) {
        reminder.title = newTitle
        reminder.notes = newNotes
        reminder.isCompleted = newIsCompleted
        
        save()
        
        reminders = fetchData(entityType: ReminderEntity.self)
    }
    
    private func getData() {
        reminderLists = fetchData(entityType: ReminderListEntity.self)
        reminders = fetchData(entityType: ReminderEntity.self)
    }
    
    private func fetchData<T: NSManagedObject>(entityType: T.Type) -> [T] {
        let request = NSFetchRequest<T>(entityName: String(describing: T.self))
        
        do {
            return try container.viewContext.fetch(request)
        } catch {
            print("Failed to load reminder lists: \(error.localizedDescription)")
            return []
        }
    }
    
    private func add<T: NSManagedObject>(item: T.Type, configure: (T) -> Void) {
        let newEntity = T(context: container.viewContext)
        configure(newEntity)
        save()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch  {
            print("Failed to save data: \(error.localizedDescription)")
        }
    }
    
    private func delete(item: NSManagedObject) {
        container.viewContext.delete(item)
        save()
    }
}

