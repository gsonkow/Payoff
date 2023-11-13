//
//  SidebarView.swift
//  Payoff
//
//  Created by Kevin Perez on 11/10/23.
//

import Foundation
import SwiftUI

struct SidebarView: View {
    var body: some View {
        NavigationView {
            List {
                Text("DASHBOARD")
                    .font(.system(size: 10))
                    .fontWeight(.bold)

                NavigationLink(destination: EditableTextList()) {
                        Label("Story Beats", systemImage: "folder.fill")
                    }
                
                Spacer()
                
                Text("PROFILE")
                    .font(.system(size: 10))
                    .fontWeight(.bold)
                Group {
                    NavigationLink(destination: ContentView()) {
                        Label("My Account", systemImage: "person")
                    }
                    NavigationLink(destination: ContentView()) {
                        Label("Settings", systemImage: "gear")
                    }
                }
                
                Spacer()
                
                Divider()
                NavigationLink(destination: ContentView()) {
                    Label("Sign Out", systemImage: "arrow.backward")
                }
            }
        }
    }
}


struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView()
    }
}
