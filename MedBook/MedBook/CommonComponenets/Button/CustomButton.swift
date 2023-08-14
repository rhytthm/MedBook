//
//  CustomButton.swift
//  MedBook
//
//  Created by Rhytthm Mahajan on 12/08/23.
//

import SwiftUI


struct CustomButton: View {
    let text: String
   
    
    @Environment(\.isEnabled) var isEnabled
    
    init(text: String) {
        self.text = text
    }
    
    var body: some View{
        HStack {
            Text(text)
                .font(CustomFont.buttonBold)
                .foregroundColor(Color.black)
                .padding(EdgeInsets(top: 10, leading: 35, bottom: 10, trailing: 35))
            
        }
        .background(Color.init(hex: "#FFFFFF"))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.black, lineWidth: 2)
        )
        
    }
}


