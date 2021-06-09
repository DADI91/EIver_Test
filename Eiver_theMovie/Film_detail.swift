//
//  Film_detail.swift
//  The_Movie
//
//  Created by walid dadi on 08/06/2021.
//

import SwiftUI
import youtube_ios_player_helper_swift


struct Film_detail: View {
    
    @Binding var image : String
    @Binding var titre : String
    @Binding var date_sortie : String
    @Binding var synopsis : String
    @Binding var longText : Bool
    @Binding var id_trailers : String
    @Binding var id_video : String
    
    
    
    var body: some View {
        ZStack {
            
            
            Color(#colorLiteral(red: 0.003921568627, green: 0.7058823529, blue: 0.8941176471, alpha: 1)).edgesIgnoringSafeArea(.all)
            
            ZStack {
                
                
                
                ScrollView {
                    veiw_detail(image: self.$image, titre: self.$titre, date_sortie: self.$date_sortie, synopsis: self.$synopsis)
                    
                    
                    Video_player(id_trailers: $id_trailers, id_video: $id_video, longText: $longText)
                        .padding(.bottom, 150)
                    
                }
                
                
                
                
            }
            .offset(y:50)
            
        }
        
        
    }
}

struct Film_detail_Previews: PreviewProvider {
    static var previews: some View {
        Film_detail(image: .constant("https://www.themoviedb.org/t/p/w1280/pGZqc9jQ6F8klQZKm37NAAMH70o.jpg"), titre: .constant("Forrest Gump"), date_sortie: .constant("05/10/1994"), synopsis: .constant("Forrest Gump est le symbole d’une époque, un candide dans une Amérique qui a perdu son innocence. Merveilleusement interprété par Tom Hanks, Forrest vit une série d’aventures, de l’état d’handicapé physique à celui de star du football, de héros du Vietnam au roi de la crevette, des honneurs de la Maison Blanche au bonheur d’une grande histoire d’amour. Son cœur dépasse les limites de son Q.I."), longText: .constant(false), id_trailers: .constant("qlx0JTy3LL8"), id_video: .constant("2MmjmhSCXNE"))
    }
}

struct veiw_detail: View {
    
    @State var viewState = CGSize.zero
    
    @Binding var image : String
    @Binding var titre : String
    @Binding var date_sortie : String
    @Binding var synopsis : String
    
    var body: some View {
        VStack{
            
            
            HStack {
                
                SwiftUI.Image(uiImage: image.load())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 190, height: 200 , alignment: .center)
                
                VStack {
                    GeometryReader { geometry in
                        Text(titre)
                            .font(.system(size: geometry.size.width/10 , weight: .bold))
                            .foregroundColor(.white)
                        
                    }
                    .frame(maxWidth: 370, maxHeight: 100)
                    .padding(.horizontal, 16)
                    .offset(x: -30 ,y: 40)
                    
                    
                    
                    GeometryReader { geometry in
                        Text("Date: \(date_sortie)")
                            .font(.system(size: geometry.size.width/12 , weight: .bold))
                            .foregroundColor(.white)
                        
                        
                    }
                    .frame(maxWidth: 370, maxHeight: 100)
                    .padding(.horizontal, 16)
                    .offset(x: -35 ,y: 0)
                    
                }
                
                
            }
            .offset(x: 75 ,y: -70)
            
            
            HStack {
                
                GeometryReader { geometry in
                    
                    Text(synopsis)
                        .font(.system(size: geometry.size.width/17 , weight: .bold))
                        .foregroundColor(.white)
                    
                }
                .frame(width: 370, height:  600 )
                .padding(.horizontal, 16)
                .offset(x: 0 ,y: -40)
                
                
                
                
            }
            
        }
        .offset(x: 0,y: 80)
        
    }
    
}

func long_text(synopsis: String) -> Int {
    var len : Int
    len = synopsis.count
    return len
}

struct Video_player: View {
    
    @Binding var id_trailers : String
    @Binding var id_video : String
    @Binding var longText : Bool
    
    @State var show = false
    
    var body: some View {
        
        
        HStack {
            Button(action: {
                self.show.toggle()
            },
            label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.white)
            }).offset(x: 160, y: 0)
            Spacer()
            
            
            
            
            ZStack {
                HStack {
                    YTWrapper(videoID: id_trailers).frame(width: 330, height: UIScreen.main.bounds.height/4)
                        .offset(x: show ? -1000 :-330)
                        .animation(.easeIn)
                    
                    
                    YTWrapper(videoID: id_video).frame( width: 330, height: UIScreen.main.bounds.height / 4)
                        .offset(x: show ? -670 : 100)
                        .animation(.easeIn)
                }
                .offset(x: 500)
                
              
            }

            Button(action: {
                
                self.show.toggle()
                
            },
            label: {
                Image(systemName: "chevron.right")
                    .foregroundColor(.white)
            }).offset(x: -160, y: 0)
        }.padding(20)
        .offset(y: longText ? 100 : -100)
   
    }
}


