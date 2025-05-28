//
//  EditPictureAI.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 27.05.2025.
//

import SwiftUI
import PhotosUI
import ImagePlayground

struct EditPictureAI: View {

    var onSave: (() -> Void)?

    @Environment(\.supportsImagePlayground) var supportImagePlayground

    @State private var avatarImage: Image?
    @State private var profileImage: UIImage?
    @State private var userName: String = ""
    @State private var name: String = ""
    @State private var surname: String = ""
    @State private var photosPicketItem: PhotosPickerItem?
    @State private var userBio = ""
    @State private var isShowingPlayground: Bool = false
    @FocusState private var isFocused: Bool

    var body: some View {
        ZStack {

            Color.clear
                   .contentShape(Rectangle())
                   .onTapGesture {
                       hideKeyboard()
                   }

            VStack(spacing: 32) {
                VStack(spacing: 10) {
                    PhotosPicker(selection: $photosPicketItem, matching: .not(.screenshots)) {
                        (avatarImage ?? Image(systemName: "person.circle.fill"))
                            .resizable()
                            .foregroundStyle(.mint)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150)
                            .clipShape(.circle)
                    }

                    TextField("Name", text: $name)
                        .font(.subheadline)
                        .padding()
                        .background(.quinary, in: .rect(cornerRadius: 16, style: .continuous))

                    TextField("Surname", text: $surname)
                        .font(.subheadline)
                        .padding()
                        .background(.quinary, in: .rect(cornerRadius: 16, style: .continuous))
                }

                NativeWritingToolsTextView(text: $userBio, placeholder: "Describe generation concept...")
                     .frame(height: 120)
                     .padding()
                     .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
                     .focused($isFocused)

                HStack(spacing: 10) {
                    if supportImagePlayground {
                        Button("Generate Image", systemImage: "sparkles") {
                            isShowingPlayground = true
                        }
                        .padding()
                        .foregroundStyle(.mint)
                        .fontWeight(.bold)
                        .background(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .stroke(.mint, lineWidth: 3)
                        )
                    }

                    Button("Save") {
                        if let profileImage = profileImage {
                            profileImage.saveImageToUserDefaults()
                        }

                        if !name.isEmpty {
                            saveUserDeafult(value: name, key: AppConstants.UserDefaultsConstants.firstname)
                        }

                        if !surname.isEmpty {
                            saveUserDeafult(value: surname, key: AppConstants.UserDefaultsConstants.surname)
                        }

                        if !userBio.isEmpty {
                            saveUserDeafult(value: userBio, key: AppConstants.UserDefaultsConstants.bio)
                        }

                        onSave?()
                    }
                    .padding()
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(Color.mint)
                    )
                }

                Spacer()
            }
            .padding(30)
            .onChange(of: photosPicketItem) { _, _ in
                Task {
                    if let photosPicketItem, let data = try? await photosPicketItem.loadTransferable(type: Data.self), let image = UIImage(data: data) {
                        profileImage = image
                        avatarImage = Image(uiImage: image)
                    }
                }
            }
            .imagePlaygroundSheet(isPresented: $isShowingPlayground, sourceImage: avatarImage) { url in
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    profileImage = image
                    avatarImage = Image(uiImage: image)
                }
            } onCancellation: { }
        }
    }

    private func saveUserDeafult(value: String,
                                 key: String) {
        if let _ = UserDefaults.standard.string(forKey: key) {
            UserDefaults.standard.set(value,
                                      forKey: key)
        } else {
            UserDefaults.standard.set(value,
                                      forKey: key)
        }
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    EditPictureAI()
}
