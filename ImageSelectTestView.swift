//
//  ImageSelectTestView.swift
//  RemediApp
//
//  Created by Albert Su on 10/28/23.
//

import SwiftUI

struct ImageSelectTestView: View {
    @State private var selectedImage: Image?
    @State private var isImagePickerPresented = false

    var body: some View {
        VStack {
            Button(action: {
                isImagePickerPresented = true
            }) {
                Text("Select Image")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            selectedImage?
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(selectedImage: $selectedImage)
        }
    }
}

struct ImageSelectTestView_Previews: PreviewProvider {
    static var previews: some View {
        ImageSelectTestView()
    }
}

