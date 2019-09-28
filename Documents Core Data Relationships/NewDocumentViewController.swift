//
//  NewDocumentViewController.swift
//  Documents Core Data Relationships
//
//  Created by Carmel Braga on 9/26/19.
//  Copyright © 2019 Carmel Braga. All rights reserved.
//

import UIKit

class NewDocumentViewController: UIViewController {

    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var nameTextField: UITextField!
    
    var category: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        contentTextView.delegate = self as? UITextViewDelegate
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameTextField.resignFirstResponder()
        contentTextView.resignFirstResponder()
    }
    
    @IBAction func saveDocument(_ sender: Any) {
        
        let name = nameTextField.text
        let content = contentTextView.text
        
        if let document = Document(name: name, content: content){
            
            category?.addToRawDocuments(document)
            
            do{
                try document.managedObjectContext?.save()
                
                self.navigationController?.popViewController(animated: true)
            } catch{
                print("Document could not be created.")
            }
        }
    }
}

extension NewDocumentViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
