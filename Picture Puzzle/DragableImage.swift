//
//  DragableImage.swift
//  Picture Puzzle
//
//  Created by Bodie Woods on 3/8/23.
//

import SwiftUI

struct DragableImage: View {
    private let imageSize: CGFloat = 120
    @State private var offset = CGSize.zero
    
    var imageData:Data
    var image:Image
    var endLocation:CGPoint
    
    init(imageData:Data, endLocation: CGPoint){
        self.imageData = imageData
        self.endLocation = endLocation
        
        self.offset = CGSize(width: Int.random(in:-120...120), height: Int.random(in:-120...120))
        
        var img = UIImage()
        if let originalImage = UIImage(data: imageData){
            let width = 120
            let height = 120
            let x = Int(endLocation.x)
            let y = Int(endLocation.y)
            
            img = cropImage(originalImage, toRect: CGRect(x: x, y: y, width: width, height: height))!
        }
        else{
            img = UIImage(systemName: "questionmark.folder")!
        }
        self.image = Image(uiImage: img)
    }
    
    var dragGesture: some Gesture{
        DragGesture()
            .onChanged{ value in
                var x = value.startLocation.x + value.translation.width - imageSize/2
                var y = value.startLocation.y + value.translation.height - imageSize/2
                
                
                if abs(x - endLocation.x) < 40 && abs(y - endLocation.y) < 40{
                    x = endLocation.x
                    y = endLocation.y
                }
                
                offset = CGSize(width:x, height:y)
            }
    }
    
    var body: some View {
        image
            .offset(offset)
            .gesture(dragGesture)
    }
}

struct DragableImage_Previews: PreviewProvider {
    static var previews: some View {
        DragableImage(imageData: Data(), endLocation: CGPoint(x: 0,y: 0))
    }
}
