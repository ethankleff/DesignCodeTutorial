//
//  MenuView.swift
//  DesignCode
//
//  Created by Ethan Rackleff on 11/13/20.
//  Copyright © 2020 Ethan Rackleff. All rights reserved.
//

import SwiftUI



struct MenuView: View {
    var body: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 16){
                Text("Nate - 28% complete")
                    .font(.caption)//words under profile
                
                Color.white//percentage slider
                    .frame(width: 38, height: 6)//white slider
                    .cornerRadius(3)
                    .frame(width: 130, height: 6, alignment: .leading) //grey slider
                    .background(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.08))
                    .cornerRadius(3)
                    .padding()
                    .frame(width: 150, height: 24)//grey background
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(12)
                
                MenuRow(title: "Account", icon: "gear")
                MenuRow(title: "Billing", icon: "creditcard")
                MenuRow(title: "Sign out", icon: "person.crop.circle")
            }
            .frame(maxWidth: .infinity)
            .frame(height: 300)
            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.8705882353, green: 0.8941176471, blue: 0.9450980392, alpha: 1))]), startPoint: .top, endPoint: .bottom))//can input photo as background
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .padding(.horizontal, 30)
            .overlay(//makes itt not clipped by clipshape
                Image("Avatar")
                    .resizable()
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    .frame(width: 60, height: 60)
                .clipShape(Circle())//makes photo a circle
                    .offset(y:-150)
            )
        }
        .padding(.bottom, 30)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

struct MenuRow: View {
    var title: String
    var icon: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .light))
                .imageScale(.large)
                .frame(width: 32, height: 32)
                .foregroundColor(Color(#colorLiteral(red: 0.3522971869, green: 0.6203684211, blue: 0.728043139, alpha: 0.662109375)))
            Text(title)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .frame(width: 120, alignment: .leading)
        }
    }
}
