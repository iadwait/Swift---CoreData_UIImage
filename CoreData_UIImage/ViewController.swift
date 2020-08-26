//
//  ViewController.swift
//  CoreData_UIImage
//
//  Created by Adwait Barkale on 20/08/20.
//  Copyright © 2020 Adwait Barkale. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgViewSave: UIImageView!
    @IBOutlet weak var imgViewGet: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        tapGesture.numberOfTouchesRequired = 1
        imgViewSave.isUserInteractionEnabled = true
        imgViewSave.layer.borderWidth = 0.5
        imgViewSave.layer.borderColor = UIColor.black.cgColor
        imgViewGet.layer.borderWidth = 0.5
        imgViewGet.layer.borderColor = UIColor.black.cgColor
        imgViewSave.addGestureRecognizer(tapGesture)
    }
    
    @objc func selectImage()
    {
        openImagePicker()
    }

    @IBAction func btnSaveClicked(_ sender: UIButton) {
        //let jpeg = imgViewSave.image?.jpegData(compressionQuality: 0.75)
        if let png = imgViewSave.image?.pngData(){
            DatabaseHelper.shared.saveImageToCoreData(imgData: png)
        }
        
    }
    
    @IBAction func btnFetchImage(_ sender: UIButton) {
        let arrImg = DatabaseHelper.shared.getImageFromCoreData()
        if let imgData = arrImg[0].img
        {
            imgViewGet.image = UIImage(data: imgData)
        }
    }
    
    
}

extension ViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    func openImagePicker()
    {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum)
        {
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            present(imagePicker,animated: true,completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        if let img = info[.originalImage] as? UIImage{
            imgViewSave.image = img
        }
    }
}
