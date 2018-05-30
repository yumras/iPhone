//
//  MasterViewController.swift
//  NaverBlogReader
//
//  Created by 스마트금융과29 on 2018. 5. 1..
//  Copyright © 2018년 hwy. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    var detailViewController: DetailViewController? = nil
    var managedObjectContext: NSManagedObjectContext? = nil
    let naverUrl = "https://openapi.naver.com/v1/search/blog?query=" // Naver Open API URL

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = editButtonItem

//        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
//        navigationItem.rightBarButtonItem = addButton
//        if let split = splitViewController {
//            let controllers = split.viewControllers
//            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
//        }
        
        // Naver Open API 호출
        // 0. 사용자가 입력한 검색어를 받아온다.
        // 1. Naver Open API URL -> String
        // 2. ID, Secret(네이버 발급) -> HTTP Header
        // 3. 1+2 -> GET 방식으로 HTTP 호출
        // 4. Naver서버 -> 응답(response)
        // 5. 응답 -> Parsing(내가 원하는 데이터를 추출)
        // 6. TextView 디스플레이
        
        let usrQuery = "폴리텍대학"
        
        // URL 인코딩 ex> 한국폴리텍대학 -> %ED%99%95 ~~~~~~
        let encodingQuery = usrQuery.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
        
        // myUrl = URL(http://openapi.naver.com/..... + ?query=%ED%99%95 ....)
        let myUrl = URL(string: (naverUrl + encodingQuery!))!
        
        // HTTP 통신시 세션을 공유한다.
        let session4 = URLSession.shared
        
        // HTTP Request 객체를 만든다.
        let request = NSMutableURLRequest(url: myUrl)
        
        //request.httpMethod = "POST" // POST 방식인 경우
        request.httpMethod = "GET" // GET 방식인 경우
        
        //ID, Secret 설정 -> HTTP 헤더에 설정
        request.setValue("NtF6I1bYeQpw1Z_V_gH0", forHTTPHeaderField: "X-Naver-Client-Id")
        request.setValue("o_tA7AtX2a", forHTTPHeaderField: "X-Naver-Client-Secret")
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData // 캐시 사용안함
        
        let taskTest = session4.dataTask(with: request as URLRequest, completionHandler: onFinish)
        
        taskTest.resume()
        
    }
    
    func onFinish(data: Data?, response: URLResponse?, error: Error?) {
        // print(data)
        
        do{
            let array = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary

            if let tempArrays = array["items"] as? NSArray{ // 배열로 변환
            
                let context = self.fetchedResultsController.managedObjectContext
                
                let request = NSFetchRequest<Event>(entityName: "Event")
                
                // 기존 데이터가 있을 경우, 모두 지운다. [START]
                do {
                    
                    let results = try context.fetch(request)
                    
                    if results.count > 0 {
                        
                        for result in results {
                            
                            context.delete(result)
                            
                            do {
                                
                                try context.save()
                                
                            } catch {
                                
                                print("Specific delete failed")
                                
                            }
                            
                        }
                        
                    }
                    
                } catch {
                    
                    print("Delete failed")
                    
                }  // 기존 데이터가 있을 경우, 모두 지운다. [END]
                
                for tempArray in tempArrays {
                    let newEvent = Event(context: context)
                    var tmp = tempArray as! NSDictionary // tempArray2["bloggername"] as! String, tempArray2["bloggerlink"] as! String
                    
                    newEvent.timestamp = NSDate() as Date
                    newEvent.setValue(tmp["bloggername"] as! String, forKey: "bloggername")
                    newEvent.setValue(tmp["bloggerlink"] as! String, forKey: "bloggerlink")
                    newEvent.setValue(tmp["description"] as! String, forKey: "blogdescription")
                    
                    
                    do {
                        try context.save()
                    } catch {
                        let nserror = error as NSError
                        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                    }
                }
                
                
            
            }
            
        } catch {
            print ("JSON Parsing Error")
        }
        
        DispatchQueue.main.sync(execute: {
            
            self.tableView.reloadData()
            
        })
    }

//    override func viewWillAppear(_ animated: Bool) {
//        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
//        super.viewWillAppear(animated)
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc
    func insertNewObject(_ sender: Any) {
        let context = self.fetchedResultsController.managedObjectContext
        let newEvent = Event(context: context)
             
        // If appropriate, configure the new managed object.
        newEvent.timestamp = Date()

        // Save the context.
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
            let object = fetchedResultsController.object(at: indexPath)
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let event = fetchedResultsController.object(at: indexPath)
        configureCell(cell, withEvent: event)
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        //return true
        return false
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let context = fetchedResultsController.managedObjectContext
            context.delete(fetchedResultsController.object(at: indexPath))
                
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func configureCell(_ cell: UITableViewCell, withEvent event: Event) {
        //cell.textLabel!.text = event.timestamp!.description
        cell.textLabel!.text = event.bloggername
    }

    // MARK: - Fetched results controller

    var fetchedResultsController: NSFetchedResultsController<Event> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "bloggername", ascending: false)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "Master")
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
             // Replace this implementation with code to handle the error appropriately.
             // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             let nserror = error as NSError
             fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }    
    var _fetchedResultsController: NSFetchedResultsController<Event>? = nil

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
            case .insert:
                tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
            case .delete:
                tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
            default:
                return
        }
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
            case .insert:
                tableView.insertRows(at: [newIndexPath!], with: .fade)
            case .delete:
                tableView.deleteRows(at: [indexPath!], with: .fade)
            case .update:
                configureCell(tableView.cellForRow(at: indexPath!)!, withEvent: anObject as! Event)
            case .move:
                configureCell(tableView.cellForRow(at: indexPath!)!, withEvent: anObject as! Event)
                tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

    /*
     // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
     
     func controllerDidChangeContent(controller: NSFetchedResultsController) {
         // In the simplest, most efficient, case, reload the table view.
         tableView.reloadData()
     }
     */

}

