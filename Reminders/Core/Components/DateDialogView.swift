import SwiftUI

struct DateDialogView: View {
    @State private var isDatePickerShown = true
    @State private var isTimePickerShown = false
    @State private var date = Date()
    @State private var time = Date()
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            // buttons
            HStack {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                }
                
                Spacer()
                
                Text("Date & Time")
                    .font(.system(size: 17, weight: .semibold))
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Apply")
                        .bold()
                }
            }
            .padding()
            
            // body
            ScrollView(showsIndicators: false) {
                VStack {
                    // date picker
                    HStack(spacing: 12) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Colors.red)
                            .frame(width: 32, height: 32)
                            .overlay {
                                Image(systemName: "calendar")
                                    .foregroundStyle(Color.white)
                            }
                        
                        VStack(alignment: .leading) {
                            Text("Date")
                                .font(.system(size: 17))
                            
                            Text(date, style: .date)
                                .foregroundStyle(Color.blue)
                                .font(.system(size: 13))
                        }
                        
                        Spacer()
                        
                        Toggle("Date", isOn: $isDatePickerShown)
                            .labelsHidden()
                    }
                    .padding(.horizontal)
                    
                    Divider()
                        .padding(.leading, 62)
                    
                    if isDatePickerShown {
                        DatePicker(
                            "Start Date",
                            selection: $date,
                            displayedComponents: [.date]
                        )
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                    }
                    
                    // time picker
                    HStack(spacing: 12) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.blue)
                            .frame(width: 32, height: 32)
                            .overlay {
                                Image(systemName: "gauge.with.needle")
                                    .foregroundStyle(Color.white)
                            }
                        
                        VStack(alignment: .leading) {
                            Text("Time")
                                .font(.system(size: 17))
                            
                            if isTimePickerShown {
                                Text(time, style: .time)
                                    .foregroundStyle(Color.blue)
                                    .font(.system(size: 13))
                            }
                        }
                        
                        Spacer()
                        
                        Toggle("Time", isOn: $isTimePickerShown)
                            .labelsHidden()
                    }
                    .padding(.horizontal)
                    
                    Divider()
                        .padding(.leading, 62)
                    
                    if isTimePickerShown {
                        DatePicker(
                            "Start Date",
                            selection: $time,
                            displayedComponents: [.hourAndMinute]
                        )
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                    }
                }
            }
        }
    }
}

#Preview {
    DateDialogView()
}
