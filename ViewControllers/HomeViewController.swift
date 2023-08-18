//
//  HomeViewController.swift
//  posttraining231
//
//  Created by prk on 18/08/23.
//

import UIKit
import CoreData

class HomeViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    var arrayOfNames = [String]()
    var arrayOfRooms = [String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currName = arrayOfNames[indexPath.row]
        let currRoom = arrayOfRooms[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingCell") as! BookingTableTableViewCell
        
        cell.nameTxt.text = currName
        cell.roomTxt.text = currRoom
        
        cell.updateHandler = {
            self.updateHandler(cell: cell, indexPath: indexPath)
        }
        
        cell.deleteHandler = {
            self.deleteHandler(cell: cell, indexPath: indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func updateHandler(cell : BookingTableTableViewCell, indexPath : IndexPath){
        
        let oldName = arrayOfNames[indexPath.row]
        let oldRoom = arrayOfRooms[indexPath.row]
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Bookings")
        
        request.predicate = NSPredicate(format: "name == %@ AND room == %@", oldName, oldRoom )
        let newName = cell.nameTxt.text
        let newRoom = cell.roomTxt.text
        
        do{
            let res = try context.fetch(request) as! [NSManagedObject]
            for data in res {
                data.setValue(newName, forKey: "name")
                data.setValue(newRoom, forKey: "room")
            }
            try context.save()
            loadData()
        }catch{
            print("Error occured")
        }
        
    }
    
    
    func deleteHandler(cell : BookingTableTableViewCell, indexPath : IndexPath){
        let oldName = arrayOfNames[indexPath.row]
        let oldRoom = arrayOfRooms[indexPath.row]
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Bookings")
        
        request.predicate = NSPredicate(format: "name == %@ AND room == %@", oldName, oldRoom)
        
        do{
            let result = try context.fetch(request) as! [NSManagedObject]
            
            for data in result{
                context.delete(data)
            }
            
            loadData()
        }catch{
            print("Error Occured")
        }
    }
    
    func loadData ()
    {
        arrayOfRooms.removeAll()
        arrayOfNames.removeAll()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Bookings")
        
        do{
            let result = try context.fetch(request) as! [NSManagedObject]
            
            for data in result{
                arrayOfNames.append(data.value(forKey: "name") as! String)
                arrayOfRooms.append(data.value(forKey: "room") as! String)
            }
            
            tableTV.reloadData()
            
        }catch{
            print("loading data failed")
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        // Do any additional setup after loading the view.
        
        tableTV.delegate = self
        tableTV.dataSource = self
        loadData()
        
    }
    
    
    @IBOutlet weak var tableTV: UITableView!
    
    var context : NSManagedObjectContext!
    
    @IBOutlet weak var nameTxt: UITextField!
    
    @IBOutlet weak var roomTxt: UITextField!
    @IBAction func AddButton(_ sender: Any) {
        let name = nameTxt.text!
        let room = roomTxt.text!
        let entity = NSEntityDescription.entity(forEntityName: "Bookings", in: context)
        
        let newBooking = NSManagedObject(entity: entity!, insertInto: context)
        
        
        newBooking.setValue(name, forKey: "name")
        newBooking.setValue(room, forKey: "room")
        
        do{
            try context.save()
            print("Succesfully inserted data")
            loadData()
        }catch{
            print("Error occured")
        }
        
    }
    /*
     
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
