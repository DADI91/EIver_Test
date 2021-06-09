//
//  splash_screen.swift
//  The_Movie
//
//  Created by walid dadi on 07/06/2021.
//

//
//  ContentView.swift
//  The_Movie
//
//  Created by walid dadi on 07/06/2021.
//

//
//  ContentView.swift
//  the movie
//
//  Created by walid dadi on 03/06/2021.
//

import SwiftUI

struct splash_screen: View {
    
    @State var show = false
    @State var viewState = CGSize.zero
    @State var isDragging = false
    @Binding var selectedTab : Int
    
    var body: some View {
        
        ZStack{
            
            Color(#colorLiteral(red: 0.003921568627, green: 0.7058823529, blue: 0.8941176471, alpha: 1)).edgesIgnoringSafeArea(.all)
            
            VStack {
                CoreView(show: $show, viewState: $viewState, isDragging: $isDragging)
                    .offset(y: -170)
                
                Presentation(viewState: $viewState, isDragging: $isDragging)
                    .offset(y: 10)
                
                RectangleButton(selectedTab: $selectedTab)
                
                
            }
            
        }
    }
}

struct splash_screen_Previews: PreviewProvider {
    static var previews: some View {
        splash_screen( selectedTab: .constant(0))
    }
}



struct CoreView: View {
    @Binding var show : Bool
    @Binding var viewState : CGSize
    @Binding var isDragging : Bool
    
    var body: some View {
        VStack {
            
            GeometryReader { geometry in
                Text("The Movie")
                    
                    .font(.system(size: geometry.size.width/10 , weight: .bold))
                    .foregroundColor(.white)
                    .offset()
            }
            .frame(maxWidth: 375, maxHeight: 100 )
            .padding(.horizontal, 16)
            .offset(x: viewState.width/20, y: viewState.height/20)
            
            
            Spacer()
            
        }
        .multilineTextAlignment(.center)
        .padding(.top, 150)
        .frame(height: 500)
        .frame(maxWidth: .infinity)
        .background(
            
            ZStack {
                Image(uiImage: #imageLiteral(resourceName: "Blob"))
                    .offset(x: -150, y: -200)
                    .rotationEffect(Angle(degrees: show ? 360+90 : 90))
                    .blendMode(.plusDarker)
                    .animation(Animation.linear(duration: 120).repeatForever(autoreverses: false))
                    .onAppear { self.show = true
                        
                    }
                
                Image(uiImage: #imageLiteral(resourceName: "Blob"))
                    .offset(x: -200, y: -260)
                    .rotationEffect(Angle(degrees: show ? 360+90 : 0), anchor: .leading)
                    .blendMode(.overlay)
                    .animation(Animation.linear(duration: 100).repeatForever(autoreverses: false))
                
            }
        )
        .background(
            Image(uiImage: #imageLiteral(resourceName: "Card3"))
                .offset(x: viewState.width/25, y: viewState.height/25),
            alignment: .bottom)
        
        .background(Color(#colorLiteral(red: 0.4117647059, green: 0.4705882353, blue: 0.9725490196, alpha: 1)))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .scaleEffect(isDragging ? 0.9 : 1)
        .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
        .rotation3DEffect(
            Angle(degrees: 5),
            axis: (x: viewState.width, y: viewState.height, z: 0)
        )
        
        .gesture(
            DragGesture().onChanged { value in
                self.viewState = value.translation
                self.isDragging = true
            }
            .onEnded { value in
                self.viewState = .zero
                self.isDragging = false
            }
        )
    }
}



struct Presentation: View {
    @Binding var viewState : CGSize
    @Binding var isDragging : Bool
    
    var body: some View {
        GeometryReader { geometry in
            Text("The Movie est une application qui met a votre disposition une liste de films avec leur informations.")
                
                .font(.system(size: geometry.size.width/16 , weight: .bold))
                .foregroundColor(.white)
                .offset(x: 6, y: -150)
        }
        .frame(maxWidth: 375, maxHeight: 100 )
        .padding(.horizontal, 16)
        .offset(x: viewState.width/20, y: viewState.height/20)
    }
}

//struct Button_film: View {
//    @Binding var selectedTab : Int
//
//    var body: some View {
//
//        Button(action: {
//
//            self.selectedTab = 1
//
//
//
//        }, label: {
//            Text("Voir les Films ")
//        })
//    }
//
//
//}

struct  RectangleButton: View {
    
    @Binding var selectedTab : Int
    @State var tap = false
    @State var presse = false
    var body: some View {
        Text("Voir les films")
            .font(.system(size: 20, weight: .semibold, design: .rounded))
            .frame(width: 200, height: 60)
            .background(
                ZStack {
                    Color(presse ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1))
                    
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .foregroundColor(Color(presse ? #colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                        .blur(radius: 4)
                        .offset(x: -8, y: -8)
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1)), Color.white]  ), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .padding(2)
                        .blur(radius: 2)
                    
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(color: Color(presse ? #colorLiteral(red: 0.3960784314, green: 0.8784313725, blue: 1, alpha: 1) : #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)), radius: 20, x: 20, y: 20)
            .shadow(color: Color(presse ? #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1) : #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)), radius: 20, x: -20, y: -20)
            .scaleEffect(tap ? 1.2 : 1)
            .gesture(
                LongPressGesture(minimumDuration: 0.5 , maximumDistance: 10).onChanged { value in
                    self.tap = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.tap = false
                        self.selectedTab = 1
                    }
                }
                .onEnded { value in
                    self.presse.toggle()
                    
                }
            )
    }
}

