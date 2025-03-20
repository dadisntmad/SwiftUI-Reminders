import SwiftUI

struct CustomTextView: UIViewRepresentable {
    @Binding var text: String
    @Binding var selectedDateBox: Int
    @Binding var isDateDialogPresented: Bool
    
    var placeholder = "Title"
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.textColor = .label
        
        // Enable line wrapping
        textView.isScrollEnabled = true
        textView.textContainer.lineFragmentPadding = 0
        
        // Create toolbar
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textView.frame.size.width, height: 84))
        
        // Convert SwiftUI View to UIView
        let hostingController = UIHostingController(rootView: KeyboardToolbarView(selectedDateBox: $selectedDateBox, isDateDialogPresented: $isDateDialogPresented))
        hostingController.view.backgroundColor = .clear
        hostingController.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 84)
        
        // Create a custom UIBarButtonItem with the SwiftUI view inside
        let customView = hostingController.view!
        let customItem = UIBarButtonItem(customView: customView)
        
        toolBar.items = [customItem]
        
        textView.inputAccessoryView = toolBar
        textView.delegate = context.coordinator
        
        // Setup placeholder if needed
        if text.isEmpty {
            textView.text = placeholder
            textView.textColor = UIColor.placeholderText
        } else {
            textView.text = text
            textView.textColor = .label
        }
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        // Avoid updating while user is editing
        if !context.coordinator.isEditing {
            if text.isEmpty {
                uiView.text = placeholder
                uiView.textColor = UIColor.placeholderText
            } else if uiView.text != text {
                uiView.text = text
                uiView.textColor = .label
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: CustomTextView
        var isEditing = false
        
        init(_ parent: CustomTextView) {
            self.parent = parent
        }
        
        @objc func doneButtonTapped() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            isEditing = true
            
            // Clear placeholder when editing begins
            if textView.textColor == UIColor.placeholderText {
                textView.text = ""
                textView.textColor = .label
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            isEditing = false
            
            // Restore placeholder if needed
            if textView.text.isEmpty {
                textView.text = parent.placeholder
                textView.textColor = UIColor.placeholderText
            }
        }
        
        func textViewDidChange(_ textView: UITextView) {
            // Only update binding if we're not showing placeholder
            if textView.textColor != UIColor.placeholderText {
                parent.text = textView.text
            }
        }
    }
}
