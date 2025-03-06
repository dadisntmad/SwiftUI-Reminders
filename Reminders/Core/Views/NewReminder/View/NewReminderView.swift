import SwiftUI

struct NewReminderView: View {
    @State private var title = ""
    @State private var notes = ""
    
    private var isEmpty: Bool {
        return title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        ZStack {
            Colors.background.ignoresSafeArea()
            
            VStack {
                // action buttons
                HStack {
                    Button {
                        
                    } label: {
                        Text("Cancel")
                    }
                    
                    Spacer()
                    
                    Text("New Reminder")
                        .font(.system(size: 17, weight: .semibold))
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Text("Add")
                    }
                    .disabled(isEmpty)
                }
                .padding()
                
                ScrollView(showsIndicators: false) {
                    // form
                    VStack(spacing: 16) {
                        
                        TextField("Title", text: $title, axis: .vertical)
                            .padding(.horizontal)
                            .padding(.top)
                        
                        Divider()
                            .padding(.leading)
                        
                        ZStack(alignment: .topLeading) {
                            TextEditor(text: $notes)
                                .frame(minHeight: 100)
                                .padding(.horizontal)
                            
                            if notes.isEmpty {
                                Text("Notes")
                                    .foregroundColor(.gray50)
                                    .padding(.horizontal)
                                    .padding(.top, 8)
                            }
                        }
                        
                        Spacer()
                    }
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.bottom, 15)
                    
                    // list
                    HStack(spacing: 6) {
                        Text("List")
                            .font(.system(size: 17))
                        
                        Spacer()
                        
                        HStack {
                            Circle()
                                .fill(.orange)
                                .frame(width: 8, height: 8)
                            
                            Text("Reminder")
                                .font(.system(size: 17))
                                .foregroundStyle(Color.gray70)
                            
                            Image("caret")
                        }
                    }
                    .padding()
                    .frame(height: 54)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    NewReminderView()
}
