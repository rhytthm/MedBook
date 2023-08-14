//
//  LandingView.swift
//  MedBook
//
//  Created by Rhytthm Mahajan on 12/08/23.
//

import SwiftUI

struct LandingView: View {
    
    @EnvironmentObject var session: SessionManager
    
    var body: some View {
        ZStack {
            VStack {
                Image("shape")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 400)
                Spacer()
            }
            
            VStack{
                Text("Medbook")
                    .font(CustomFont.headerBold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 20)


                Image("landing")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Spacer()

                HStack(spacing: 30){
                    
                    NavigationLink {
                        SignUpView()
                            .environmentObject(session)
                    } label: {
                        CustomButton(text: "SignUp")
                    }
                    
                    NavigationLink {
                        SignInView()
                            .environmentObject(session)
                    } label: {
                        CustomButton(text: "Login")
                    }
                    
                }.padding(.bottom, 40)

            }.padding()
            
        }.frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .ignoresSafeArea()
        
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
