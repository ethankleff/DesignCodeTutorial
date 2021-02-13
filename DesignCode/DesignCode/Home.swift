//
//  Home.swift
//  DesignCode
//
//  Created by Ethan Rackleff on 11/13/20.
//  Copyright © 2020 Ethan Rackleff. All rights reserved.
//

import SwiftUI

struct Home: View {
    @State var showProfile = false
    @State var viewState = CGSize.zero
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            
            HomeView(showProfile: $showProfile)
                .padding(.top, 44)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)//makes a drop shadow
                .offset(y: showProfile ? -450 : 0)
                .rotation3DEffect(Angle(degrees: showProfile ? Double( viewState.height / 10) - 10 : 0), axis: (x: 10.0, y: 0, z: 0))
                .scaleEffect(showProfile ? 0.9 : 1)
                .edgesIgnoringSafeArea(.all)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            
            MenuView()
                .background(Color.black.opacity(0.001))
                .offset(y: showProfile ? 0 : screen.height)
                .offset(y: viewState.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .onTapGesture {
                    self.showProfile.toggle()
                }
            .gesture(//drag gesture modifier basic
                DragGesture().onChanged { value in
                    self.viewState = value.translation
                }
                .onEnded { value in
                    if self.viewState.height > 50 {
                        self.showProfile = false
                    }
                    self.viewState = .zero
                }
            
            )
                
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct AvatarView: View {
    @Binding var showProfile: Bool//brings showprofile in from another struct
    
    var body: some View {
        Button(action: {self.showProfile.toggle()}) {
            Image("Avatar")
                .renderingMode(.original)//gets rid of default button tint
                .resizable()
                .frame(width: 36, height: 36)
                .clipShape(Circle())
        }
    }
}

let screen = UIScreen.main.bounds//allows for dynamic dimensions of screen not hard coded

