//
//  ContentView.swift
//  DesignCode
//
//  Created by Ethan Rackleff on 11/12/20.
//  Copyright © 2020 Ethan Rackleff. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var show = false
    @State var viewState = CGSize.zero//storing value of type cgsize with an x and y position with defaults of zero. When we drag cg size goes to zero
    @State var showCard = false
    @State var bottomState = CGSize.zero
    @State var showFull = false
    @Binding var showProfile: Bool
    
    var body: some View {
        ZStack {
            
            HStack {
                TitleView(showProfile: $showProfile)
                    .blur(radius: show ? 20 : 0)
                    .opacity(showCard ? 0.4 : 1)
                    .offset(y: showCard ? -200 : 0)
                    .animation(
                        Animation
                            .default
                            .delay(0.1)
    //                    .speed(2)//speed up by 2 times
    //                    .repeatForever(autoreverses: true)
                    
                )
                

            }
            
            BackCardView()
                .frame(width: showCard ? 300 : 340, height: 220)
                .background(show ? Color("card3") : Color("card4"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -400 : -40)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -180 : 0)
                .scaleEffect(showCard ? 1: 0.9)
                .rotationEffect(.degrees(show ? 0 : 10))
                .rotationEffect(.degrees( showCard ? -10 : 0))
                .rotation3DEffect(Angle(degrees: showCard ? 0 : 10), axis: (x: 10.0, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.5))
            
            BackCardView()
                .frame(width: 340, height: 220)
                .background(show ? Color("card4") : Color("card3"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -200 : -20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -140 : 0)
                .scaleEffect(showCard ? 1: 0.95)
                .rotationEffect(Angle.degrees(show ? 0 : 5))//if true angle = 0, if false angle = 5
                .rotationEffect(.degrees( showCard ? -5 : 0))
                .rotation3DEffect(Angle(degrees: showCard ? 0 : 5), axis: (x: 10.0, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.3))//makes red card come out nicely
            
            CardView()
                .frame(width: showCard ? 375 : 340.0, height: 220.0)
                .background(Color.black)
//                .cornerRadius(20)
                .clipShape(RoundedRectangle(cornerRadius: showCard ? 30 : 20, style: .continuous))
                .shadow(radius: 20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -100 : 0)
                .blendMode(.hardLight)//blends colors
                .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 9))
                .onTapGesture{//when user taps switches true or false
                    self.showCard.toggle()

            }
            .gesture(
                DragGesture()
                    .onChanged { value in //feeds value that gets put in viewState
                    self.viewState = value.translation//value.translation is CG size
                    self.show = true//when I drag show animation will become true
                }
                .onEnded {value in
                    self.viewState = .zero
                    self.show = false
                }
            )
            
//            Text("\(bottomState.height)").offset(y: -300)
            
            BottomCardView()
            .offset(x: 0, y: showCard ? 360 : 1000)
                .offset(y: bottomState.height)
            .blur(radius: show ? 20 : 0)
                .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
            .gesture(
                DragGesture().onChanged {value in
                    self.bottomState = value.translation
                    if self.showFull {
                          self.bottomState.height += -300
                    }
                    if self.bottomState.height < -300 {
                        self.bottomState.height = -300
                    }
                }
                .onEnded { value in
                    if self.bottomState.height > 50 {
                        self.showCard = false
                    }
                    
                    if (self.bottomState.height < -100 && !self.showFull) || (self.bottomState.height < -250 && self.showFull){
                        self.bottomState.height = -300
                        self.showFull = true
                    }
                    else {
                        self.bottomState = .zero
                        self.showFull = false
                    }
   
                }
            )
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(showProfile: .constant(false))
    }
}

struct CardView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Nate Tung")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Text("Daddy")
                        .foregroundColor(Color("accent"))
                }
                Spacer()
                Image("Logo1")
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            Spacer()
            Image("Card1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 110, alignment: .top)
        }
    }
}

struct BackCardView: View {
    var body: some View {
        VStack {
            Spacer()
        }
    }
}

struct TitleView: View {
     @Binding var showProfile: Bool
    var body: some View {
        VStack {
            HStack {
                Text("Graf")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                Spacer()
                AvatarView(showProfile: $showProfile)//inserts showProfile into binding variable at bottom
                
                
            }
            .padding()
            Image("Background1")
            Spacer()
        }
    }
}

struct BottomCardView: View {
    var body: some View {
        VStack(spacing: 20) {
            Rectangle() //Grey handle
                .frame(width: 40, height: 5)
                .cornerRadius(3)
                .opacity(0.31)
            Text("Hello!")
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .lineSpacing(4)
            Spacer()
        }
        .padding(.top, 8)
        .padding(.horizontal, 20)
            .frame(maxWidth: .infinity) //pushes white card to left and right side of phone
            .background(Color.white)
            .cornerRadius(30)
            .shadow(radius: 20)
            
    }
}


struct AvatarView2: View {
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
