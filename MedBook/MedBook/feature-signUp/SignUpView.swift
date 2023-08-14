//
//  SignUpView.swift
//  MedBook
//
//  Created by Rhytthm Mahajan on 12/08/23.
//

import SwiftUI

struct SignUpView: View {
    
    @State var email : String = ""
    @State var isEmailValid : Bool = false
    @State var password : String = ""
    
    @State var hasEightChars: Bool = false
    @State var containUpperChar: Bool = false
    @State var containSpecialChar: Bool = false
    
    var countriesList: Countries = Countries.allCountries
    @State private var selectedCountry = ""
    
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
                Spacer()
                
                Text("Welcome \n sign up to continue")
                    .foregroundColor(.black)
                    .font(CustomFont.headerSemiBold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.top, 40)
                
                HStack{
                    
                    VStack {
                        EntryField(sfSymbolName: "envelope", placeholder: "Email Address", field: $email)
                        
                        HStack(spacing: 10) {
                            
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(isEmailValid ? .green : .black, lineWidth: 2)
                                .frame(width: 20, height: 20)
                                .overlay {
                                    if isEmailValid{
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.green)
                                            .font(CustomFont.buttonBold)
                                            .offset(x: 3, y: -5)
                                    }
                                }
                            
                            Text("Email Valid")
                                .foregroundColor(.black)
                                .font(CustomFont.textMedium)
                            
                            Spacer()
                            
                        }
                    }

                    
                }.padding()
                    .background(Color.init(hex: "#0A0A0A").opacity(email == "" ? 0 : 0.08))
                    .cornerRadius(15)
                    .padding(.horizontal)
                
                HStack{
                    
                    VStack(spacing: 20) {
                        EntryField(sfSymbolName: "lock", placeholder: "Password", field: $password, isSecure: true)
                        
                        HStack(spacing: 10) {
                            
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(hasEightChars ? .green : .black, lineWidth: 2)
                                .frame(width: 20, height: 20)
                                .overlay {
                                    if hasEightChars{
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.green)
                                            .font(CustomFont.buttonBold)
                                            .offset(x: 3, y: -5)
                                    }
                                }
                            
                            Text("At Least 8 characters")
                                .foregroundColor(.black)
                                .font(CustomFont.textMedium)
                            
                            Spacer()
                            
                        }
                        
                        HStack(spacing: 10) {
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(containUpperChar ? .green : .black, lineWidth: 2)
                                .frame(width: 20, height: 20)
                                .overlay {
                                    if containUpperChar{
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.green)
                                            .font(CustomFont.buttonBold)
                                            .offset(x: 3, y: -5)
                                    }
                                }
                            
                            Text("Must Contain an uppercase letter")
                                .foregroundColor(.black)
                                .font(CustomFont.textMedium)
                            
                            Spacer()
                            
                        }
                        
                        HStack(spacing: 10) {
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(containSpecialChar ? .green : .black, lineWidth: 2)
                                .frame(width: 20, height: 20)
                                .overlay {
                                    if containSpecialChar{
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.green)
                                            .font(CustomFont.buttonBold)
                                            .offset(x: 3, y: -5)
                                    }
                                }
                            
                            Text("Contains special character")
                                .foregroundColor(.black)
                                .font(CustomFont.textMedium)
                            
                            Spacer()
                            
                        }
                    }
                    
                }.padding()
                    .background(Color.init(hex: "#0A0A0A").opacity(password == "" ? 0 : 0.08))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    
                
                Picker(selection: $selectedCountry, label: Text("Please choose a country")) {
                    ForEach(returnCountryList(countriesList), id: \.self){ element in
                        Text(element.country)
                    }
                }.pickerStyle(WheelPickerStyle())
                    .frame(height: 140)
                
                Spacer()
                
                CustomButton(text: "Let's Go")
                    .onTapGesture {
                        session.setupCredentials(email: email, password: password)
                        session.signIn()
                    }
                    .padding(.bottom, 30)
                    .disabled(!(isEmailValid && hasEightChars && containUpperChar && containSpecialChar))
                    .opacity((isEmailValid && hasEightChars && containUpperChar && containSpecialChar) ? 1 : 0.4)

                Spacer()
                
                
            }.onChange(of: password) { newValue in
                // 8 chars
                if newValue.count < 8{
                    hasEightChars = false
                }else{
                    hasEightChars = true
                }
                
                // UpperCase
                if isUpperCaseValid(newValue){
                    containUpperChar = true
                }else{
                    containUpperChar = false
                }
                
                //Special Char
                if isSpecialCharacterCaseValid(newValue){
                    containSpecialChar = true
                }else{
                    containSpecialChar = false
                }
                
            }
            .onChange(of: email) { newValue in
                if isEmailCaseValid(newValue){
                    isEmailValid = true
                }else{
                    isEmailValid = false
                }
            }
            
        }.frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .ignoresSafeArea()
    }
    
    func isUpperCaseValid(_ password : String) -> Bool{
        let oneUpperCasePredicate = NSPredicate(format: "SELF MATCHES %@", ".*[A-Z]+.*")
        return oneUpperCasePredicate.evaluate(with: password)
    }
    
    func isSpecialCharacterCaseValid(_ password : String) -> Bool{
        let oneSpecialCharacterPredicate = NSPredicate(format: "SELF MATCHES %@", ".*[!&^%$#@()/]+.*")
        return oneSpecialCharacterPredicate.evaluate(with: password)
    }
    
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[0-9])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    func isEmailCaseValid(_ mail : String) -> Bool{
        let emailTest = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return emailTest.evaluate(with: mail)
    }
    
    func returnCountryList(_ countries: Countries) -> [Country] {
        var countriesList: [Country] = []
        for (_, key_value) in countries.data.enumerated() {
            countriesList.append(key_value.value)
        }
        return countriesList
    }
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
