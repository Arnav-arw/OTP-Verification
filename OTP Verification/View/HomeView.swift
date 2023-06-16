//
//  HomeView.swift
//  OTP Verification
//
//  Created by Arnav Singhal on 16/06/23.
//

import SwiftUI

struct HomeView: View {
    
    @AppStorage("log_status") var log_status = false
    
    var body: some View {
        VStack {
            Text("Hey")
            Button {
                log_status = false
            } label: {
                Text("Log out")
            }
        }
        .navigationTitle("Home")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
