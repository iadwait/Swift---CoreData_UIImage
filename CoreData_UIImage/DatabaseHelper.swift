//
//  DatabaseHelper.swift
//  CoreData_UIImage
//
//  Created by Adwait Barkale on 20/08/20.
//  Copyright © 2020 Adwait Barkale. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DatabaseHelper{
    
    static let shared = DatabaseHelper()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveImageToCoreData(imgData: Data)
    {
        let profile = NSEntityDescription.insertNewObject(forEntityName: "Profile", into: context) as! Profile
        profile.img = imgData
        do{
            try context.save()
        }catch{
            print("Error saving Image Data")
        }
    }
    
    func getImageFromCoreData() -> [Profile]
    {
        var arrProfile = [Profile]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
        do{
            arrProfile = try context.fetch(fetchRequest) as! [Profile]
        }catch{
            print("Error getting Image")
        }
        return arrProfile
    }
}
