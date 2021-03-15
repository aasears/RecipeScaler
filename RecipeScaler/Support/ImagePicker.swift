//
//  ImagePicker.swift
//  RecipeScaler
//
//  Created by Aaron Sears on 3/6/21.
//

import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {

    var sourceType: UIImagePickerController.SourceType = .photoLibrary
     
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
 
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
 
        return imagePicker
    }
 
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
 
    }
    
}
