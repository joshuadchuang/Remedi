//
//  CamInputForm.swift
//  RemediApp
//
//  Created by Joshua Chuang on 10/28/23.
//

import SwiftUI
import Vision

struct CamInputForm: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var image: UIImage?
    @State private var showCameraPicker = false
    @State private var showLibraryPicker = false
    
    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                Text(recognizeText(in: image))
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
            }
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

// This function uses the VNRecognizeTextRequest class to recognize text in an image
/*func recognizeText(in image: UIImage) -> String {
    var textResult = ""
    guard let cgImage = image.cgImage else {return ""}
    let requestHandler = VNImageRequestHandler(cgImage: cgImage)
    let request = VNRecognizeTextRequest(completionHandler: recognizeTextHandler)
    
    guard let observations = request.results as? [VNRecognizedTextObservation] else {
                print("No text found")
                return
            }
    
    do {
        // Perform the text-recognition request.
        try requestHandler.perform([request])
    } catch {
        print("Unable to perform the requests: \(error).")
    }
    return request.results[0]topCandidates(1).string
}*/

// A function that takes in a UIImage and returns a string of the text in the image
func recognizeText(in image: UIImage) -> String {
    // Create a variable to store the text result
    var textResult = ""
    
    // Create a request handler with the image
    let requestHandler = VNImageRequestHandler(cgImage: image.cgImage!, options: [:])
    
    // Create a request to perform optical character recognition (OCR)
    let request = VNRecognizeTextRequest { (request, error) in
        // Check if there is an error
        if let error = error {
            print("Error: \(error.localizedDescription)")
            return
        }
        
        // Get the observations from the request
        guard let observations = request.results as? [VNRecognizedTextObservation] else {
            print("No text found")
            return
        }
        
        // Loop through each observation
        for observation in observations {
            // Get the top candidate from the observation
            guard let topCandidate = observation.topCandidates(1).first else {
                print("No candidate found")
                continue
            }
            
            // Append the candidate's string to the text result
            textResult += topCandidate.string + "\n"
        }
    }
    
    // Set the recognition level to accurate
    request.recognitionLevel = .accurate
    
    // Perform the request
    do {
        try requestHandler.perform([request])
    } catch {
        print("Unable to perform the request: \(error.localizedDescription)")
    }
    
    // Return the text result
    if (textResult == "") {
        return "No words"
    }
    return textResult
}


func recognizeTextHandler(request: VNRequest, error: Error?) {
    guard let observations =
            request.results as? [VNRecognizedTextObservation] else {
        return
    }
    let recognizedStrings = observations.compactMap { observation in
        // Return the string of the top VNRecognizedText instance.
        return observation.topCandidates(1).first?.string
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
                
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
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
        CamInputForm().environmentObject(AppViewModel())
    }
}
