//
//  ImagePicker.swift
//  Picture Puzzle
//
//  Created by Bodie Woods on 3/8/23.
//

import SwiftUI
import PhotosUI

struct ImagePicker: View {
    
    @State var selectedItem:PhotosPickerItem?
    @State var imageData: Data?
    
    @State var image:Image?
    
    var body: some View {
        NavigationStack{
            PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()){
                Text("select a photo")
            }
            .onChange(of: selectedItem){ newItem in
                Task{
                    if let data = try? await newItem?.loadTransferable(type: Data.self){
                        if let uiImage = UIImage(data:data){
                            
                            if let croppedImage = cropSquare(uiImage){
                                if let resizedImage = resizeImage(image: croppedImage, targetSize: CGSize(width: 360, height: 360)){
                                    image = Image(uiImage: resizedImage)
                                    imageData = resizedImage.pngData()
                                }
                            }
                            
                            image = Image(uiImage: uiImage)
                        }
                    }
                }
            }
            if let image{
                VStack{
                    image
                        .resizable()
                        .frame(width: 360, height: 360)
                    
                    NavigationLink("Puzzle", destination: PuzzleView(imageData: imageData!))
                }
            }
        }
    }
}

struct ImagePicker_Previews: PreviewProvider {
    static var previews: some View {
        ImagePicker()
    }
}
