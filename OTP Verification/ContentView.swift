//
//  ContentView.swift
//  OTP Verification
//
//  Created by Arnav Singhal on 15/06/23.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("log_status") var log_status = false
    
    var body: some View {
        NavigationView {
            if log_status {
               HomeView()
            } else {
                LoginScreen()
            }
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
