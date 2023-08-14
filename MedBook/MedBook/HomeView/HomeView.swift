//
//  ContentView.swift
//  MedBook
//
//  Created by Rhytthm Mahajan on 12/08/23.
//

import SwiftUI

struct HomeView: View {
    //@StateObject var viewModel = ViewModel()
    @StateObject private var session = SessionManager()
    var body: some View {
        
        NavigationView {
            switch session.currentState{
            case .loggedIn:
                
                LoggedInView()
                    .environmentObject(session)
                    .transition(.opacity)
                
            default:
                
                LandingView()
                    .environmentObject(session)
                    .transition(.opacity)
                
            }
        }.accentColor(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


