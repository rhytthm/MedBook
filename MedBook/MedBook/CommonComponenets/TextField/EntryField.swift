//
//  EntryField.swift
//  MedBook
//
//  Created by Rhytthm Mahajan on 13/08/23.
//

import SwiftUI

struct EntryField: View {
    var sfSymbolName: String
    var placeholder: String
    var prompt: String? = nil
    @Binding var field: String
    var isSecure = false
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: sfSymbolName)
                    .foregroundColor(.gray)
                    .font(.headline)
                    .frame(width: 20)
                if isSecure {
                    SecureField(placeholder, text: $field)
                } else {
                    TextField(placeholder, text: $field)
                }
            }.autocapitalization(.none)

            if let prompt = prompt {
                Text(prompt)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.caption)
            }
            
        }
    }
}

struct EntryField_Previews: PreviewProvider {
    static var previews: some View {
        EntryField(sfSymbolName: "envelope", placeholder: "Email Address", prompt: "Enter a valid email address", field: .constant(""))
    }
}
