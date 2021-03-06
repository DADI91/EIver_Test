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
            Synopsis: "Forrest Gump est le symbole d???une ??poque, un candide dans une Am??rique qui a perdu son innocence. Merveilleusement interpr??t?? par Tom Hanks, Forrest vit une s??rie d???aventures, de l?????tat d???handicap?? physique ?? celui de star du football, de h??ros du Vietnam au roi de la crevette, des honneurs de la Maison Blanche au bonheur d???une grande histoire d???amour. Son c??ur d??passe les limites de son Q.I.",
            id_trailers: "qlx0JTy3LL8",
            id_video: "2MmjmhSCXNE"),
    
    Film_d( titre: "American Beauty",
            image:"https://www.themoviedb.org/t/p/w1280/ri7gRI9e0pCtyCYAcc8qJSCPn6V.jpg",
            Date_sortie: "2/02/2000 ",
            Synopsis: "Un pavillon bourgeois dans une banlieue r??sidentielle : c'est ici que r??sident Lester Burnhamm, sa femme Carolyn et leur fille Jane. Derri??re cette respectable fa??ade se tisse une grin??ante tragi-com??die familiale o?? se r??v??leront d??sirs inavou??s, frustrations et violences refoul??es.",
            id_trailers: "pnSBTE5EIu8",
            id_video: "CQH51MGFwpY"),
    
    Film_d(titre: "Citizen Kane",
           image:"https://www.themoviedb.org/t/p/w1280/h5Ys2Scx2DxHuZ8HrcJSitNbipV.jpg",
           Date_sortie: "2/07/1946",
           Synopsis: "?? la mort du milliardaire Charles Foster Kane, un grand magnat de la presse, Thompson, un reporter, enqu??te sur sa vie. Les contacts qu'il prend avec ses proches lui font d??couvrir un personnage gigantesque, m??galomane, ??go??ste et solitaire.",
           id_trailers: "wiS-E-u9M6A",
           id_video: "m1U9i1IOwJw"),
    
    Film_d(titre: "Dancer in the Dark",
           image:"https://www.themoviedb.org/t/p/w1280/sBh45R8jwJRiN72tnjV49Amhu09.jpg",
           Date_sortie: "18/10/2000",
           Synopsis: "Selma Jezkova, ??migr??e tch??que et m??re c??libataire, travaille dans une usine de l'Am??rique profonde. Elle trouve son salut dans sa passion pour la musique, sp??cialement les chansons et les danses des grandes com??dies musicales hollywoodiennes. Selma garde un lourd secret : elle perd la vue et son fils Gene conna??tra le m??me sort sauf si elle r??ussit ?? mettre assez d'argent de c??t?? pour lui payer une op??ration. Quand un voisin aux abois accuse ?? tort Selma d'avoir vol?? ses ??conomies, le drame de sa vie s'intensifie pour se terminer en final tragique.",
           id_trailers: "53vr9EiOH7g",
           id_video: "cM7FyvdkbZw"),
    
    Film_d(titre: "The Dark",
           image:"https://www.themoviedb.org/t/p/w1280/wZeBHVnCvaS2bwkb8jFQ0PwZwXq.jpg",
           Date_sortie: "26/10/2005",
           Synopsis: "En d??barquant dans cette contr??e isol??e du pays de Galles, Adelle esp??rait d'abord reconqu??rir son mari, James, pour le plus grand bonheur de leur fille, Sarah. Mais loin des retrouvailles id??ales qu'elle avait r??v??es, Adelle va vivre le pire des cauchemars : sa fille se noie. Bris??e, elle d??couvre que Sarah n'est peut-??tre pas morte, mais retenue dans une dimension parall??le li??e ?? une ancestrale l??gende pa??enne. Seule face au terrifiant secret qui hante la r??gion, Adelle va devoir affronter l'impossible pour tenter de sauver sa fille. Qui est donc Ebrill, la myst??rieuse enfant surgie de nulle part qui ressemble tant ?? Sarah ? Comment vaincre l'??pouvantable mal??diction qui trouve sa source pr??s des falaises ? Et plus que tout, comment ??chapper ?? un monde o?? vos pires terreurs prennent vie ? Adelle trouvera les r??ponses, mais il lui faudra payer le prix...",
           id_trailers: "IdCLtwSSIh0",
           id_video: "AhnXp-imOxM"),
    
    Film_d(titre: "Le cinqui??me ??l??ment",
           image:"https://www.themoviedb.org/t/p/w1280/8nx8sttha1Zidt73SbNncVfSwqk.jpg",
           Date_sortie: "7/05/1997",
           Synopsis: "New York, XXIII??me si??cle. Une boule de feu fonce sur la Terre. Pour l'arr??ter il faut retrouver le Cinqui??me ??l??ment, l'??tre supr??me, qui associ?? aux quatre ??l??ments vitaux - l'air, l'eau, le feu et la terre - peut seul repousser Le Mal. Corn??lius re??oit l'aide de Korben, taxi et ancien agent secret, et de Leeloo, extraterrestre qui a pris la forme d'une jeune femme aux cheveux oranges..",
           id_trailers: "NC0p_JAs-qw",
           id_video: "7rzmiE-pESk")
    
    
]




