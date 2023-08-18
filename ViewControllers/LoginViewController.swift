//
//  LoginViewController.swift
//  posttraining231
//
//  Created by prk on 18/08/23.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    var context : NSManagedObjectContext!
    
    @IBOutlet weak var usernameTxt: UITextField!
    
    
    @IBOutlet weak var passwordtxt: UITextField!
    
    
    @IBAction func loginButton(_ sender: Any) {
        let username = usernameTxt.text!
        let password = passwordtxt.text!
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.predicate = NSPredicate(format: "username == %@ AND password = %@",username, password)
        
        
        do{
            let result = try context.fetch(request) as! [NSManagedObject]
            
            if(result.count == 0){
                print("Invalid user")
                return
            }
            
            print("Login success")
            if let nextView = storyboard?.instantiateViewController(identifier: "homeViewController"){
//                navigationController?.pushViewController(nextView, animated: true)
                navigationController?.setViewControllers([nextView], animated: true)
            }
            
        }catch{
            print("error occureds")
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
