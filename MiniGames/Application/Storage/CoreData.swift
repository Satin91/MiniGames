//
//  CoreData.swift
//  MiniGames
//
//  Created by Артур on 19.12.21.
//

import UIKit
import CoreData

class CoreData {
    // MARK: Outlets
    
    // MARK: Overriden funcs
    // MARK: Action funcs
    // MARK: Notifcation observers
    // MARK: Public funcs:
    // MARK: Private funcs
    // MARK: Delegate funcs
    // MARK: Class(Static) funcs
    
    // MARK: Properties
    static var shared = CoreData()
    lazy var context = persistentContainer.viewContext
    
    
    //MARK: CoreData stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SingleGameUsersCoreData")
        container.loadPersistentStores { store, error in
            if let error = error {
                fatalError("Error \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Error \(nsError.localizedDescription), \(nsError.userInfo)")
            }
        }
    }
    
    
    
    func saveUser(name: String?, completion: (SingleUserModel?, Bool) -> Void ) {
        let user = SingleUserModel(context: context)
        user.name = (name != nil && name != "") ? name: "Новый пользователь"
        user.id = UUID()
        do {
            try self.context.save()
            completion(user, true)
        } catch let error{
            print(error.localizedDescription)
            completion(user, false)
        }
    }

    func removeUser(user: SingleUserModel) {
        let request: NSFetchRequest<SingleUserModel> = SingleUserModel.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", "id" , user.id! as CVarArg)
        do {
            let user = try context.fetch(request)
            context.delete(user.first!)
        } catch {
            
        }
        
        //context.delete(<#T##object: NSManagedObject##NSManagedObject#>)
    }
    //MARK: Transactions
    func updateModel(user: SingleUserModel) {
        let request: NSFetchRequest<SingleUserModel> = SingleUserModel.fetchRequest()
        //request.predicate = NSPredicate(format: "id == %@",
        request.predicate = NSPredicate(format: "%K == %@", "id" , user.id! as CVarArg)
        
        do {
            let users = try context.fetch(request)
        } catch {
            
        }
        
    }
    
    func requestUsers(completion: (Result<[SingleUserModel], Error>) -> Void) {
        let context = self.persistentContainer.viewContext
        let request: NSFetchRequest<SingleUserModel> = SingleUserModel.fetchRequest()
        do {
            let model = try context.fetch(request)
            completion(.success(model))
        } catch let error as NSError {
            completion(.failure(error))
        }
    }
}
