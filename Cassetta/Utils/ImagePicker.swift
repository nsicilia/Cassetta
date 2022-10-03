//
//  ImagePicker.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 10/2/22.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable{
    
    @Binding var image: UIImage?
    //is used to dismiss the picker controller
    @Environment(\.presentationMode) var mode
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        //boiler
    }
    
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        //Does the actual image selection and sets the mode to dismiss itself
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = info[.originalImage] as? UIImage else{ return }
            self.parent.image = image
            self.parent.mode.wrappedValue.dismiss()
        }
    }
}

