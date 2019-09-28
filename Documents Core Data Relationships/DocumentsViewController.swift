//
//  DocumentsViewController.swift
//  Documents Core Data Relationships
//
//  Created by Carmel Braga on 9/26/19.
//  Copyright © 2019 Carmel Braga. All rights reserved.
//

import UIKit

class DocumentsViewController: UIViewController {
    
    //@IBOutlet weak var dateLabel: UILabel!
    //@IBOutlet weak var sizeLabel: UILabel!
    //@IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var documentsTableView: UITableView!
    
    let dateFormatter = DateFormatter()
    
    var category: Category?
    var document: Document?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .medium
  
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.documentsTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addNewDocument(_ sender: Any) {
        performSegue(withIdentifier: "showDocument", sender: self)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? NewDocumentViewController else{
            return
        }
        
        destination.category = category
    }
    
    func deleteDocument(at indexPath: IndexPath){
        guard let document = category?.documents?[indexPath.row],
        let managedContext = document.managedObjectContext else{
            return
    }
        
        managedContext.delete(document)
        
        do{
            try managedContext.save()
            
            documentsTableView.deleteRows(at: [indexPath], with: .automatic)
            
        }catch{
            print("Could not delete document.")
            
            documentsTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category?.documents?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = documentsTableView.dequeueReusableCell(withIdentifier: "documentCell", for: indexPath)
        
        if let document = category?.documents?[indexPath.row]{
           
            //nameLabel.text = document.name
            cell.textLabel?.text = document.name
            
            //sizeLabel.text = String(document.size) + " bytes"
            cell.detailTextLabel?.text = String(document.size) + " bytes"

            if let date = document.date{
            cell.detailTextLabel?.text = dateFormatter.string(from: date)
            //dateLabel.text = dateFormatter.string(from: date)
        }
            
    }
            
            return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
        deleteDocument(at: indexPath)
        
        }

    }
}

extension DocumentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDocument", sender: self)
    }
}


