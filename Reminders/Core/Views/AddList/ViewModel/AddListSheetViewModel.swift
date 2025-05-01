import SwiftUI
import Observation

@Observable
class AddListSheetViewModel {
    func addList(color: Color, icon: String, title: String) {
        CoreDataStack.shared.addList(
            color: color.description,
            icon: icon,
            title: title
        )
    }
    
    func deleteList(item: ReminderListEntity) {
        CoreDataStack.shared.deleteList(item: item)
    }
}
