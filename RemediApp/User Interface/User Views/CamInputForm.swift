//
//  CamInputForm.swift
//  RemediApp
//
//  Created by Joshua Chuang on 10/28/23.
//

import SwiftUI

struct CamInputForm: View {
    @State private var image: UIImage?
    @State private var showCameraPicker = false
    @State private var showLibraryPicker = false
    
    var body: some View {
        VStack {
            Button(action: { self.showCameraPicker.toggle() }) {
                HStack {
                    Image(systemName: "camera")
                        .foregroundColor(.white)
                    
                    Text("Take Photo")
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
            }
            .sheet(isPresented: $showCameraPicker) {
                ImagePicker(image: self.$image, sourceType: .camera)
            }
            
            Button(action: { self.showLibraryPicker.toggle() }) {
                HStack {
                    Image(systemName: "photo")
                        .foregroundColor(.white)
                    
                    Text("Choose from photo library")
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
            }
            .sheet(isPresented: $showLibraryPicker) {
                ImagePicker(image: self.$image, sourceType: .photoLibrary)
            }
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    var sourceType: UIImagePickerController.SourceType
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}
}



//#Preview {
//    CamInputForm()
//}

struct CamInputForm_Previews: PreviewProvider {
    static var previews: some View {
        CamInputForm()
    }
}
