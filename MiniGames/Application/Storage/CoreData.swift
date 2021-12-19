//
//  CoreData.swift
//  MiniGames
//
//  Created by Артур on 19.12.21.
//

import UIKit
import CoreData

class CoreData {
    static var shared = CoreData()
    
    
    func saveModel(name: String, completion: (SingleUserModel?)-> Void) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "SingleUserModel", in: context) else { return }
        let object = SingleUserModel(entity: entity, insertInto: context)
        object.name = name
        do {
            try context.save()
            completion(object)
        } catch let error as NSError {
            print(error.localizedDescription)
            completion(nil)
        }
    }
    func requestCoreDataModel(completion: (Result<[SingleUserModel], Error>) -> Void) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<SingleUserModel> = SingleUserModel.fetchRequest()
        do {
            let model = try context.fetch(request)
            completion(.success(model))
        } catch let error as NSError {
            completion(.failure(error))
        }
    }
}
