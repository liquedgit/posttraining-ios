//
//  RegisterViewController.swift
//  posttraining231
//
//  Created by prk on 18/08/23.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let appledelegate = UIApplication.shared.delegate as! AppDelegate
        context = appledelegate.persistentContainer.viewContext
    }
    

    
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPasswordTxt: UITextField!
    var context: NSManagedObjectContext!
    
    
    
    @IBAction func RegisterButton(_ sender: Any) {
        let username = usernameTxt.text!
        let password = passwordTxt.text!
        let confirmPassword = confirmPasswordTxt.text!
        
        if(password != confirmPassword){
            print("Password is not matched !")
            return
        }
        
        let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
        
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        newUser.setValue(username, forKey: "username")
        newUser.setValue(password, forKey: "password")
        
        do{
            try context.save()
            print("Register Success")
        }catch{
            print("Register Failed")
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
