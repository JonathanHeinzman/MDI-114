//
//  DashboardView.swift
//  ToDo Tracking
//
//  Created by Jonathan Heinzman on 9/14/26.
//

import SwiftUI

struct DashboardView: View {
    @State private var profiles: [Profile] = Profile.sampleProfile
    @State private var path = NavigationPath()
    
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                ScrollView {
                    VStack(spacing: 40){
                        VStack(spacing: 10) {
                            Text("Welcome Back to ToDo App")
                                .font(.subheadline)
                                .textCase(.uppercase)
                                .foregroundColor(.mint)
                                .padding(.top, 40)
                            Text("Select your profile")
                                .font(.caption)
                        }
                        LazyVGrid(columns: columns, spacing: 25) {
                            ForEach($profiles) { $profile in
                                NavigationLink(value: profile) {
                                    // UI For Profile
                                    VStack {
                                        ZStack {
                                            Image(profile.profileImage)
                                                .resizable()
                                                .scaledToFit()
                                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                        }
                                        .frame(width: 120, height: 120)
                                        Text(profile.name)
                                            .font(.system(.headline))
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 25)
                                    .background(
                                        RoundedRectangle(cornerRadius: 25)
                                            .fill(Color.gray)
                                    )
                                    // UI Profile finishes
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Home")
            .navigationDestination(for: Profile.self) { selectedProfile in
                if let index = profiles.firstIndex(where : { $0.id == selectedProfile.id}) {
                    ContentView(profile: $profiles[index])
                }
            }
        }
    }
}
