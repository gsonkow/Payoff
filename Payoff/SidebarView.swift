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
            }
            .listStyle(SidebarListStyle())
            
            Text("PAYOFF")
        }
    }
    
    struct SidebarView_Previews: PreviewProvider {
        static var previews: some View {
            SidebarView()
        }
    }
}

