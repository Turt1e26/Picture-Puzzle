//
//  PuzzleView.swift
//  Picture Puzzle
//
//  Created by Bodie Woods on 3/8/23.
//

import SwiftUI

struct PuzzleView: View {
    var imageData:Data
    var body: some View {
        ZStack{
            Rectangle()
                .frame(width: 360,  height:360)
                .foregroundColor(.gray)
                .border(.black)
            
            DragableImage(imageData: imageData, endLocation: CGPoint(x: -120, y: -120))
            DragableImage(imageData: imageData, endLocation: CGPoint(x: 0, y: -120))
            DragableImage(imageData: imageData, endLocation: CGPoint(x: 120, y: -120))
            DragableImage(imageData: imageData, endLocation: CGPoint(x: -120, y: 0))
            DragableImage(imageData: imageData, endLocation: CGPoint(x: 0, y: 0))
            DragableImage(imageData: imageData, endLocation: CGPoint(x: 120, y: 0))
            DragableImage(imageData: imageData, endLocation: CGPoint(x: -120, y: 120))
            DragableImage(imageData: imageData, endLocation: CGPoint(x: 0, y: 120))
            DragableImage(imageData: imageData, endLocation: CGPoint(x: 120, y: 120))
        }
    }
}

struct PuzzleView_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleView(imageData: Data())
    }
}
