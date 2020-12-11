//
//  ProfileImage.swift
//  Checkmate
//
//  Created by Paul Scott on 11/8/20.
//

import SwiftUI

// Code from:
// https://www.hackingwithswift.com/books/ios-swiftui/importing-an-image-into-swiftui-using-uiimagepickercontroller
struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        @Environment(\.managedObjectContext) private var viewContext
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
}

struct PlayerImage: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var imageData: Data?
    let size: CGFloat
    let showEditButton: Bool
    @State var shouldShowImagePicker: Bool = false
    @State var selectedImage: UIImage?
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            if imageData == nil {
                Image("profile")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size, height: size)
                    .background(Colors.imageBackground)
                    .clipShape(Circle())
            } else {
                Image(uiImage: UIImage(data: imageData!)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size, height: size)
                    .background(Colors.imageBackground)
                    .clipShape(Circle())
            }
            if showEditButton {
                CircleIconButton(iconName: "pencil") {
                    shouldShowImagePicker = true
                }.sheet(isPresented: $shouldShowImagePicker, onDismiss: loadImage) {
                    ImagePicker(image: $selectedImage)
                }
            }
        }
        .frame(width: size, height: size)
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        imageData = selectedImage.jpegData(compressionQuality: ViewConstants.imageCompression)
    }
}
