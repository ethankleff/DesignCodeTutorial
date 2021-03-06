//
//  HomeView.swift
//  DesignCode
//
//  Created by Ethan Rackleff on 11/13/20.
//  Copyright © 2020 Ethan Rackleff. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @Binding var showProfile: Bool
    @State var showUpdate = false
    
//main view
    var body: some View {
        VStack {
            HStack {
                //titles and button
                Text("Reading")
                    .font(.system(size: 28, weight: .bold))
                
                Spacer()
                
                AvatarView(showProfile: $showProfile)//inserts showProfile into binding variable at bottom
                
                Button(action: { self.showUpdate.toggle() }) {
                    
                    Image(systemName: "bell")
                        .renderingMode(.original)
                        .font(.system(size: 16, weight: .medium))
                        .frame(width: 36, height: 36)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                }
                .sheet(isPresented: $showUpdate) {
                    UpdateList()
                }
            }
            //scrolling and dimensions for cards
            .padding(.horizontal)
            .padding(.leading, 14)
            .padding(.top, 30)
            
            ScrollView(.horizontal, showsIndicators: false){//allows for scroll horizontal. Gets rid of horizontal scroll bar
                HStack(spacing:20) {//puts content in horizontal
                    ForEach(sectionData) { item in
                        GeometryReader { geometry in
                            SectionView(section: item)
                                .rotation3DEffect(Angle(degrees:
                                    Double(geometry.frame(in: .global).minX - 30) / -20
                                ), axis: (x: 0, y: 10, z: 0))
                        }
                        .frame(width: 275, height: 275)
                    }
                }
            .padding(30)//allows to shows drop shadow
                .padding(.bottom, 30)// shows bottom drop shadow more
            }
            
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(false))
    }
}
//creates cards
struct SectionView: View {
    var section: Section
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(section.title)
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(Color.white)
                Spacer()
                Image(section.logo)
            }
            
            Text(section.text.uppercased())
                .frame(maxWidth: .infinity, alignment: .leading)
            section.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210)
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: 275, height: 275)
        .background(section.color)
        .cornerRadius(30)
        .shadow(color: section.color.opacity(0.3), radius: 20, x: 0, y: 20)
    }
}
//sets up what is in data per card
struct Section: Identifiable {//for each card
    var id = UUID()
    var title: String
    var text: String
    var logo: String
    var image: Image
    var color: Color
}
//line below is for data input
let sectionData = [Section(title: "Hi Nate", text: "Dadddy", logo: "Logo1", image: Image("Card1"), color: Color("card1")),
    
    Section(title: "Hi Ethan", text: "SLDC", logo: "Logo1", image: Image("Card2"), color: Color("card2")),
    
    Section(title: "Hi Daniel", text: "SSDC", logo: "Logo1", image: Image("Card3"), color: Color("card3")),
    
]
