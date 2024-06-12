//
//  MainAdminView.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 05/06/24.
//

import SwiftUI

struct MainAdminView: View {
    var body: some View {
        TabView {
           AdminHomeView()
               .tabItem {
                    Label("Home", systemImage: "house")
                    
                }
            
            DoctorApprovalList()
                 .tabItem {
                     Label("ApprovalList", systemImage: "person.fill.checkmark")
                 }
             
            
            DoctorCategoryListView()
                .tabItem {
                    Label("Doctors", systemImage: "list.clipboard.fill")
                    
                }
            
          
            
           AdminProfile()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
            
            
            
        }
    }
}

#Preview {
    MainAdminView()
}
