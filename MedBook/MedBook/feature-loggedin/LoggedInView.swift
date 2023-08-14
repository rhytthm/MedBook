//
//  LoggedInView.swift
//  MedBook
//
//  Created by Rhytthm Mahajan on 14/08/23.
//

import SwiftUI

struct LoggedInView: View {
    
    @EnvironmentObject var session: SessionManager
    
    var body: some View {
        VStack {
            Text("Which Topics interests \n you today ?")
                .font(CustomFont.headerMedium)
                .foregroundColor(.black)
            
            Spacer()
            
            Button {
                withAnimation {
                    session.signOut()
                }
            } label: {
                Text("Log Out")
                    .foregroundColor(.red)
                    .font(CustomFont.buttonBold)
            }

        }
       
    }
}

struct LoggedInView_Previews: PreviewProvider {
    static var previews: some View {
        LoggedInView()
    }
}
