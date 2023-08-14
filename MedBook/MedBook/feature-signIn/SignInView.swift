//
//  SignInView.swift
//  MedBook
//
//  Created by Rhytthm Mahajan on 13/08/23.
//

import SwiftUI

struct SignInView: View {
    @State var email : String = ""
    @State var password : String = ""
    
    @EnvironmentObject var session: SessionManager
    
    @State var error : String = ""
    
    var body: some View {
        ZStack {
            VStack {
                Image("shape")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 400)
                Spacer()
            }
            
            VStack{
  
                VStack {
                    Text("Welcome, \n log in to continue")
                        .foregroundColor(.black)
                        .font(CustomFont.headerSemiBold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                    .padding(.top, 40)
                    
                    HStack{
                        EntryField(sfSymbolName: "envelope", placeholder: "Email Address", field: $email)
                    }.padding()
                        .background(Color.init(hex: "#0A0A0A").opacity(email == "" ? 0 : 0.08))
                        .cornerRadius(15)
                        .padding(.horizontal)
                    
                    HStack{
                        EntryField(sfSymbolName: "lock", placeholder: "Password", field: $password, isSecure: true)
                    }.padding()
                        .background(Color.init(hex: "#0A0A0A").opacity(email == "" ? 0 : 0.08))
                        .cornerRadius(15)
                        .padding(.horizontal)
                    
                    Text(error)
                        .foregroundColor(.red)
                        .font(CustomFont.textRegular)
                    
                }.padding(.top, 80)
                
                Spacer()
                
                CustomButton(text: "Login")
                    .onTapGesture {
                        withAnimation {
                            if session.validateCredentials(email: email, password: password) == ""{
                                session.signIn()
                            }else if session.validateCredentials(email: email, password: password) == "Incorrect email"{
                                error = "Incorrect email"
                            }else if session.validateCredentials(email: email, password: password) == "Incorrect password"{
                                error = "Incorrect password"
                            }else{
                                error = "No Credentials Found"
                            }
                           
                        }
                    }
                    .padding(.bottom, 50)
                    .disabled(!(email != "" && password != ""))
                    .opacity((email != "" && password != "") ? 1 : 0.4)
                
            }
            
        }.frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .ignoresSafeArea()
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
