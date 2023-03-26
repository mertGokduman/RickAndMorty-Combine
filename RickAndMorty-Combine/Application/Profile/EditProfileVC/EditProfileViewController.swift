//
//  EditProfileViewController.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 19.03.2023.
//

import UIKit
import PhotosUI
import Photos

enum EditProfileType {
    case photo
    case info
}

class EditProfileViewController: BaseVC<EditProfileViewModel> {

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 200
        tableView.tableHeaderView = UIView(frame: .zero)
        return tableView
    }()

    private lazy var btnSave: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("Save",
                        for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16,
                                                    weight: .semibold)
        button.setTitleColor(.white,
                             for: .normal)
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var typeArray: [EditProfileType] = [.photo, .info]

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.startLoading()
        self.tabBarController?.tabBar.isHidden = true
        self.btnAddHide()
        self.viewModel.setupDatas()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "BGColor")
        self.navigationItem.title = "Edit Profile"

        setupUI()
        bind()
        makeViewDismissKeyboard()
    }

    private func bind() {

        viewModel.isDataReady
            .receive(on: RunLoop.main)
            .sink { [weak self] isDataReady in
                guard let self = self else { return }
                self.tableView.reloadData()
                self.stopLoading()
            }.store(in: &cancelables)
    }

    private func setupUI() {

        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        ])

        btnSave.addTarget(self,
                          action: #selector(btnSaveTapped),
                          for: .touchUpInside)
        view.addSubview(btnSave)
        NSLayoutConstraint.activate([
            btnSave.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            btnSave.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            btnSave.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            btnSave.heightAnchor.constraint(equalToConstant: 50)
        ])

        self.setupTableView()
    }

    // MARK: - TableView Setup
    private func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        self.registerTableView()
    }

    private func registerTableView() {
        let nibs = [PhotoTVC.self, InfoTVC.self]
        tableView.registerNibs(withClassesAndIdentifiers: nibs)
    }

    // MARK: - Save Button Function
    @objc private func btnSaveTapped() {
        if let profileImage = self.viewModel.profilePicture {
            UserDefaults.standard.removeObject(forKey: AppConstants.UserDefaultsConstants.profilePicture)
            profileImage.saveImageToUserDefaults()
        }

        if let cell = tableView.cellForRow(at: IndexPath(item: 0, section: 1)) as? InfoTVC {
            saveUserDeafult(value: cell.getTextFieldText(),
                            key: AppConstants.UserDefaultsConstants.username)
        }

        if let cell = tableView.cellForRow(at: IndexPath(item: 1, section: 1)) as? InfoTVC {
            saveUserDeafult(value: cell.getTextFieldText(),
                            key: AppConstants.UserDefaultsConstants.firstname)
        }

        if let cell = tableView.cellForRow(at: IndexPath(item: 2, section: 1)) as? InfoTVC {
            saveUserDeafult(value: cell.getTextFieldText(),
                            key: AppConstants.UserDefaultsConstants.surname)
        }
        self.navigationController?.popToRootViewController(animated: true)
    }

    private func saveUserDeafult(value: String,
                                 key: String) {
        if let _ = UserDefaults.standard.string(forKey: key) {
            UserDefaults.standard.removeObject(forKey: key)
            UserDefaults.standard.set(value,
                                      forKey: key)
        } else {
            UserDefaults.standard.set(value,
                                      forKey: key)
        }
    }
}

// MARK: - UITableViewDataSource
extension EditProfileViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.typeArray.count
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        let section = typeArray[section]
        switch section {
        case .photo:
            return 1
        case .info:
            return viewModel.infoArray.count
        }
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = typeArray[indexPath.section]
        switch section {
        case .photo:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTVC",
                                                           for: indexPath) as? PhotoTVC else { return UITableViewCell() }
            cell.delegate = self
            cell.fillCell(with: self.viewModel.profilePicture)
            cell.selectionStyle = .none
            return cell
        case .info:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTVC",
                                                           for: indexPath) as? InfoTVC else { return UITableViewCell() }
            cell.fillCell(with: viewModel.infoArray[indexPath.row])
            cell.selectionStyle = .none
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension EditProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        let section = typeArray[indexPath.section]
        switch section {
        case .photo:
            cell.separatorInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        case .info:
            cell.separatorInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        }
    }
}

// MARK: - PhotoTVCDelegate
extension EditProfileViewController: PhotoTVCDelegate {

    func btnPhotoAddPressed() {
        self.showImagePicker()
    }
}

// MARK: - Setup Image Picker Options
extension EditProfileViewController {

    func imagePicker(sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        return imagePicker
    }

    func showImagePicker() {
        let alertVc = UIAlertController(title: "Choose a Photo",
                                        message: "Choose a photo from library or camera",
                                        preferredStyle: .actionSheet)

        //Image Picker For Camera
        let cameraAction = UIAlertAction(title: "Camera",
                                         style: .default) { [weak self] (action) in
            guard let self = self else { return }
            let cameraPicker = self.imagePicker(sourceType: .camera)
            self.present(cameraPicker, animated: true)
        }

        //Image Picker For Photo Library
        let photoLibraryAction = UIAlertAction(title: "Photo Library",
                                               style: .default) { [weak self] (action) in
            guard let self = self else { return }
            let photoLibraryPicker = self.imagePicker(sourceType: .photoLibrary)
            self.present(photoLibraryPicker, animated: true)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertVc.addAction(cameraAction)
        alertVc.addAction(photoLibraryAction)
        alertVc.addAction(cancelAction)
        self.present(alertVc, animated: true)
    }
}

// MARK: - UIImagePickerControllerDelegate
extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        self.viewModel.profilePicture = image
        self.dismiss(animated: true)
    }
}
