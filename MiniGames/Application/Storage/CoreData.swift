//
//  CoreData.swift
//  MiniGames
//
//  Created by Артур on 19.12.21.
//

import UIKit
import CoreData
import FirebaseFirestore
import RxSwift

class CoreData {
    
    
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
    
    //MARK: Network user
    func saveNetworkUser(user: NetworkUser, completion: ((NetworkUser?, Bool) -> Void )?) {
        

        
        do {
            try self.context.save()
            completion?(user, true)
        } catch let error{
            print(error.localizedDescription)
            completion?(user, false)
        }
    }
    
    
    
    
    func updateUserData(data: [String: String] , completion: ((NetworkUser) -> Void)?) {
        let request: NSFetchRequest<NetworkUser> = NetworkUser.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", "id" , data["id"]! as CVarArg)
        
        do {
            let model = try context.fetch(request)
            if model.count == 0 {
                let user = NetworkUser(context: self.context)
                user.email = data["email"]
                user.avatar = data["avatar"]
                user.name = data["name"]
                user.id = data["id"]
                user.chatID = data["chatID"]
                user.lastMessage = data["lastMessage"] ?? ""
                print("NEW USER \(user)")
                self.saveContext()
                completion?(user)
            } else {
                model[0].email = data["email"]
                model[0].avatar = data["avatar"]
                model[0].name = data["name"]
                model[0].id = data["id"]
                model[0].chatID = data["chatID"]
                model[0].lastMessage = data["lastMessage"] ?? ""
                print("OLD USER \(model[0])")
                self.saveContext()
                completion?(model[0])
            }
        } catch {
            
        }
    }
    func removeAllUsers() {
        let deleteFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NetworkUser")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetchRequest)
        do {
            try persistentContainer.persistentStoreCoordinator.execute(deleteRequest, with: context)
            self.saveContext()
        } catch {
            print("Удаления не произошло")
        }
    }
    
    func requestNetworkUsers(completion: (Result<[NetworkUser], Error>) -> Void) {
        let context = self.persistentContainer.viewContext
        let request: NSFetchRequest<NetworkUser> = NetworkUser.fetchRequest()
        do {
            let model = try context.fetch(request)
            completion(.success(model))
        } catch let error as NSError {
            completion(.failure(error))
        }
    }
    
    //MARK: Single users
    func saveUser(name: String?,avatar: String, completion: (SingleUserModel?, Bool) -> Void ) {
        
        let user = SingleUserModel(context: context)
        user.name = (name != nil && name != "") ? name: "Новый игрок"
        user.id = UUID()
        user.avatar = avatar
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
            self.saveContext()
        } catch {
            print("Удаления не произошло")
        }
    }
    //MARK: Transactions
    func updateModel(user: SingleUserModel) {
        let request: NSFetchRequest<SingleUserModel> = SingleUserModel.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", "id" , user.id! as CVarArg)
        
        do {
            self.saveContext()
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
