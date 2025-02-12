//
//  DataPicker.swift
//  PizzaMoney
//
//  Created by san017 on 07/02/25.
//

import SwiftUI


struct DataPicker: View {
 
    @State private var date = Date()
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        
        let currentDate = Date()
        
        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        let day = calendar.component(.day, from: currentDate)
        
        let hours = calendar.component(.hour, from: currentDate)
        let minutes = calendar.component(.minute, from: currentDate)

        
        /*let startComponents = DateComponents(year:year, month: month, day: day)*/
        let endComponents = DateComponents(year:year, month: month, day: day, hour: hours, minute: minutes, second: 00)
        return calendar.date(from:endComponents)!
        ...
        calendar.date(from:endComponents)!
    }()
    
    
    var body: some View {
        
        HStack(alignment:.center){
            Spacer()
            
            DatePicker(
                selection: $date,
                in: dateRange,
                displayedComponents: [.date, .hourAndMinute]
            ){
                //Text(date.ISO8601Format())
                
            }.foregroundColor(Color("ChartColor"))
                .datePickerStyle(CompactDatePickerStyle())
                .clipped()
                .labelsHidden()

            Spacer()
          }.padding()
        
    }
}

#Preview {
    DataPicker()
}
