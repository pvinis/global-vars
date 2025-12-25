//
//  ContentView.swift
//  globalvars
//
//  Created by Pavlos on 25/12/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "square.stack.3d.up.fill")
                .font(.system(size: 60))
                .foregroundStyle(.tint)

            Text("Global Variables")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("This app adds Shortcuts actions for storing and retrieving global variables.")
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            VStack(alignment: .leading, spacing: 8) {
                Label("Set Boolean Variable", systemImage: "checkmark.circle")
                Label("Get Boolean Variable", systemImage: "checkmark.circle.fill")
                Label("Set String Variable", systemImage: "text.quote")
                Label("Get String Variable", systemImage: "text.quote")
                Label("Get All Global Variables", systemImage: "list.bullet")
            }
            .font(.callout)
            .foregroundStyle(.secondary)
        }
        .padding(32)
    }
}

#Preview {
    ContentView()
}
