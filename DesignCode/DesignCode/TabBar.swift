//
//  TabBar.swift
//  DesignCode
//
//  Created by Ethan Rackleff on 11/13/20.
//  Copyright © 2020 Ethan Rackleff. All rights reserved.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            Home().tabItem {
                Image(systemName: "play.circle.fill")
                Text("Home")
            }
            ContentView(showProfile: .constant(false)).tabItem {
                Image(systemName: "rectangle.stack.fill")
                Text("News")
            }
        }

    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TabBar().previewDevice("iPhone 12 Pro")
        }
    }
}
