//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Max on 1/11/18.
//  Copyright © 2018 Max. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categoryArray = [Categoryy]()
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        loadCategory()
    }
    //MARK: -  TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
    //MARK: - TabkeView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        //cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    //MARK: - Data Manipulation Methods
    
    func savedCategory(){
        do {
            try context.save()
        }catch {
            print("Error saving content, \(error)")
            
        }
        
        self.tableView.reloadData()
    }
    
    func loadCategory(with request: NSFetchRequest<Categoryy> = Categoryy.fetchRequest()){
        //   let request: NSFetchRequest<Item> = Item.fetchRequest()
        do {
            categoryArray = try context.fetch(request)
        }catch{
            print("Error fetching daa from context \(error)")
        }
        self.tableView.reloadData()
    }
    
    //MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            //what will happen once the user clicks the Add Item Button alert
            
            
            let newCategory = Categoryy(context: self.context)
            newCategory.name = textField.text!
            //newCategory.items = nil
           // newItem.done = false
            
            self.categoryArray.append(newCategory)
            
            self.savedCategory()
            
        }
        
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert,animated: true, completion: nil)
    
    }
    
    
   
    
}
