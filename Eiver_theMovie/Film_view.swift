//
//  Film_view.swift
//  The_Movie
//
//  Created by walid dadi on 07/06/2021.
//

import SwiftUI

extension String {
    
    func load() -> UIImage {
        
        do{
            
            guard let url = URL(string: self) else {
                return UIImage()
                
            }
            let data: Data = try Data(contentsOf: url)
            
            return UIImage(data: data) ?? UIImage()
            
        }catch{
            
        }
        
        return UIImage()
    }
    
}

struct Film_view : View {
    
    @State var viewstat = CGSize.zero
    @State var showCard = false
    @State var active = false
    @State var BottomStat = CGSize.zero
    @State var showFull = false
    
    @State var image = ""
    @State var titre = ""
    @State var date_sortie = ""
    @State var synopsis = ""
    @State var id_trailers = ""
    @State var id_video = ""
    
    @State var longText = false
    
    
    @State var flou_reservation = false
    @State var Show_film_detail = false
    
    var body: some View {
        
        ZStack {
            
            Color(#colorLiteral(red: 0.003921568627, green: 0.7058823529, blue: 0.8941176471, alpha: 1)).edgesIgnoringSafeArea(.all)
            
            VStack {
                
                GeometryReader { geometry in
                    Text("Film")
                        .font(.system(size: geometry.size.width/9 , weight: .bold))
                        .foregroundColor(.white)
                        .animation(.easeIn)
                    
                }
                .frame(maxWidth: 370, maxHeight: 100)
                .padding(.horizontal, 16)
                .offset(y: 40)
                
                ScrollView {
                    ForEach(Film_data){ index in
                        
                        film_Card(show: false,
                                  active: $active,
                                  flou_reservation: $flou_reservation,
                                  Show_film_detail: $Show_film_detail,
                                  image: self.$image,
                                  titre: self.$titre,
                                  date_sortie: self.$date_sortie,
                                  synopsis: self.$synopsis,
                                  longText: self.$longText,
                                  Image: index.image,
                                  Titre: index.titre,
                                  Date_sortie: index.Date_sortie,
                                  Synopsis: index.Synopsis,
                                  id_trailers: index.id_trailers,
                                  id_video: index.id_video
                                  
                        )
                    }
                }
            }
            
            if self.Show_film_detail {
                ZStack {
                    Film_detail(image: $image, titre: $titre, date_sortie: $date_sortie , synopsis: $synopsis, longText: $longText, id_trailers: $id_trailers, id_video: $id_video)
                    VStack {
                        HStack {
                            
                            Image(systemName: "xmark")
                                .frame(width: 36, height: 36)
                                .foregroundColor(.white)
                                .background(Color.black)
                                .clipShape(Circle())
                                .offset(x: 175)
                        }.padding(.top, 10)
                        Spacer()
                    
                    }
                    .padding()
                    .onTapGesture {
                        self.Show_film_detail = false
                    
                   
                    }
                }
                
            }
        }
    }
    
}

struct film_Previews: PreviewProvider {
    static var previews: some View {
        Film_view()
    }
}




struct film_Card : View {
    
    @State var isDragging = false
    @State var show : Bool
    @Binding var active : Bool
    @Binding var flou_reservation : Bool
    @Binding var Show_film_detail : Bool
    
    @Binding var image : String
    @Binding var titre : String
    @Binding var date_sortie : String
    @Binding var synopsis : String
    @Binding var longText : Bool
    
    
    var Image : String
    var Titre : String
    var Date_sortie : String
    var Synopsis : String
    var id_trailers : String
    var id_video : String
    
    
    
    
    
    
    var body: some View {
        
        
        ZStack {
            
            
            VStack {
                
                
                
                
                HStack {
                
                    SwiftUI.Image(uiImage: Image.load())
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 190, height: 200 , alignment: .center)
                    
                    VStack {
                        GeometryReader { geometry in
                            Text(Titre)
                                .font(.system(size: geometry.size.width/7 , weight: .bold))
                                .foregroundColor(.white)
                                .animation(.easeIn)
                            
                        }
                        .frame(maxWidth: 370, maxHeight: 100)
                        .padding(.horizontal, 16)
                        .offset(x: -20 ,y: 60)
                        
  
                        
                        GeometryReader { geometry in
                            Text("Date: \(Date_sortie)")
                                .font(.system(size: geometry.size.width/8 , weight: .bold))
                                .foregroundColor(.white)
                                .animation(.easeIn)
                            
                        }
                        .frame(maxWidth: 370, maxHeight: 100)
                        .padding(.horizontal, 16)
                        .offset(x: -20 ,y: 30)
                        
                    }
                    
                    
                }
                .offset(x: 0 ,y: -70)
                
                
                HStack {
                    
                    GeometryReader { geometry in
                        
                        ScrollView {
                            Text(Synopsis)
                                    .font(.system(size: geometry.size.width/19 , weight: .bold))
                                .foregroundColor(.white)
                        }
                        
                    }
                    .frame(width: 350, height: 230)
                    .padding(.horizontal, 16)
                    .offset(x: -40 ,y: -40)
                    
                    
                }
                .offset(x: 40 ,y: -30)
                
            }
            
            
            
            
            
        }
        .multilineTextAlignment(.center)
        .padding(.top, 100)
        .frame(height: 500)
        .frame(width:  370 )
        .background(Color(#colorLiteral(red: 0.4117647059, green: 0.4705882353, blue: 0.9725490196, alpha: 1)))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .scaleEffect(isDragging ? 0.9 : 1)
        .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
        .onTapGesture {
            self.Show_film_detail.toggle()
            
            self.image = Image
            self.titre = Titre
            self.date_sortie = Date_sortie
            self.synopsis = Synopsis
            
            if (long_text(synopsis: synopsis) > 500){
                self.longText = true
                print(long_text(synopsis: synopsis), longText)
            }else{
                self.longText = false
                print(long_text(synopsis: synopsis), longText)
            }
        }
        
    }
}


struct Film_d : Identifiable {
    
    var id = UUID()
    var titre : String
    var image : String
    var Date_sortie : String
    var Synopsis : String
    var id_trailers : String
    var id_video : String
}

var Film_data = [
    Film_d(titre: "Forrest Gump",
            image:"https://www.themoviedb.org/t/p/w1280/pGZqc9jQ6F8klQZKm37NAAMH70o.jpg",
            Date_sortie: "05/10/1994",
            Synopsis: "Forrest Gump est le symbole d’une époque, un candide dans une Amérique qui a perdu son innocence. Merveilleusement interprété par Tom Hanks, Forrest vit une série d’aventures, de l’état d’handicapé physique à celui de star du football, de héros du Vietnam au roi de la crevette, des honneurs de la Maison Blanche au bonheur d’une grande histoire d’amour. Son cœur dépasse les limites de son Q.I.",
            id_trailers: "qlx0JTy3LL8",
            id_video: "2MmjmhSCXNE"),
    
    Film_d( titre: "American Beauty",
            image:"https://www.themoviedb.org/t/p/w1280/ri7gRI9e0pCtyCYAcc8qJSCPn6V.jpg",
            Date_sortie: "2/02/2000 ",
            Synopsis: "Un pavillon bourgeois dans une banlieue résidentielle : c'est ici que résident Lester Burnhamm, sa femme Carolyn et leur fille Jane. Derrière cette respectable façade se tisse une grinçante tragi-comédie familiale où se révéleront désirs inavoués, frustrations et violences refoulées.",
            id_trailers: "pnSBTE5EIu8",
            id_video: "CQH51MGFwpY"),
    
    Film_d(titre: "Citizen Kane",
           image:"https://www.themoviedb.org/t/p/w1280/h5Ys2Scx2DxHuZ8HrcJSitNbipV.jpg",
           Date_sortie: "2/07/1946",
           Synopsis: "À la mort du milliardaire Charles Foster Kane, un grand magnat de la presse, Thompson, un reporter, enquête sur sa vie. Les contacts qu'il prend avec ses proches lui font découvrir un personnage gigantesque, mégalomane, égoïste et solitaire.",
           id_trailers: "wiS-E-u9M6A",
           id_video: "m1U9i1IOwJw"),
    
    Film_d(titre: "Dancer in the Dark",
           image:"https://www.themoviedb.org/t/p/w1280/sBh45R8jwJRiN72tnjV49Amhu09.jpg",
           Date_sortie: "18/10/2000",
           Synopsis: "Selma Jezkova, émigrée tchèque et mère célibataire, travaille dans une usine de l'Amérique profonde. Elle trouve son salut dans sa passion pour la musique, spécialement les chansons et les danses des grandes comédies musicales hollywoodiennes. Selma garde un lourd secret : elle perd la vue et son fils Gene connaîtra le même sort sauf si elle réussit à mettre assez d'argent de côté pour lui payer une opération. Quand un voisin aux abois accuse à tort Selma d'avoir volé ses économies, le drame de sa vie s'intensifie pour se terminer en final tragique.",
           id_trailers: "53vr9EiOH7g",
           id_video: "cM7FyvdkbZw"),
    
    Film_d(titre: "The Dark",
           image:"https://www.themoviedb.org/t/p/w1280/wZeBHVnCvaS2bwkb8jFQ0PwZwXq.jpg",
           Date_sortie: "26/10/2005",
           Synopsis: "En débarquant dans cette contrée isolée du pays de Galles, Adelle espérait d'abord reconquérir son mari, James, pour le plus grand bonheur de leur fille, Sarah. Mais loin des retrouvailles idéales qu'elle avait rêvées, Adelle va vivre le pire des cauchemars : sa fille se noie. Brisée, elle découvre que Sarah n'est peut-être pas morte, mais retenue dans une dimension parallèle liée à une ancestrale légende païenne. Seule face au terrifiant secret qui hante la région, Adelle va devoir affronter l'impossible pour tenter de sauver sa fille. Qui est donc Ebrill, la mystérieuse enfant surgie de nulle part qui ressemble tant à Sarah ? Comment vaincre l'épouvantable malédiction qui trouve sa source près des falaises ? Et plus que tout, comment échapper à un monde où vos pires terreurs prennent vie ? Adelle trouvera les réponses, mais il lui faudra payer le prix...",
           id_trailers: "IdCLtwSSIh0",
           id_video: "AhnXp-imOxM"),
    
    Film_d(titre: "Le cinquième élément",
           image:"https://www.themoviedb.org/t/p/w1280/8nx8sttha1Zidt73SbNncVfSwqk.jpg",
           Date_sortie: "7/05/1997",
           Synopsis: "New York, XXIIIème siècle. Une boule de feu fonce sur la Terre. Pour l'arrêter il faut retrouver le Cinquième Élément, l'être suprême, qui associé aux quatre éléments vitaux - l'air, l'eau, le feu et la terre - peut seul repousser Le Mal. Cornélius reçoit l'aide de Korben, taxi et ancien agent secret, et de Leeloo, extraterrestre qui a pris la forme d'une jeune femme aux cheveux oranges..",
           id_trailers: "NC0p_JAs-qw",
           id_video: "7rzmiE-pESk")
    
    
]




