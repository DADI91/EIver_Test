//
//  test.swift
//  Eiver_theMovie
//
//  Created by walid dadi on 08/06/2021.
//

import SwiftUI
import youtube_ios_player_helper_swift



struct videoPlayer: View {

    var body: some View {
        
        VStack {
            YTWrapper(videoID: "qlx0JTy3LL8").frame(height: UIScreen.main.bounds.height / 3)
            Spacer()
        }
    }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        videoPlayer()
    }
}


struct YTWrapper : UIViewRepresentable {
    var videoID : String
    
    func makeUIView(context: Context) -> YTPlayerView {
        let playerView = YTPlayerView()
        playerView.load(videoId: videoID)
        return playerView
    }
    
    func updateUIView(_ uiView: YTPlayerView, context: Context) {
        //
    }
}
