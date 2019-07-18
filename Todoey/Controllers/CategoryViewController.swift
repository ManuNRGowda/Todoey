//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Manu Gowda N R on 7/17/19.
//  Copyright © 2019 i-exceed. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

   var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }
    
    //MARK: - Tableview data source methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
    
    //MARK: - Tableview delegate source methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexpath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories[indexpath.row]
        }
    }
    
    
    //MARK: - Data manipulation
    
    func loadCategories(with request : NSFetchRequest<Category> = Category.fetchRequest()){
        do{
            categories = try context.fetch(request)
        }catch{
            print("error fetching data from context, \(error)")
        }
        tableView.reloadData()
    }
    
    func saveCategories() {
        do {
            try context.save()
        }catch{
            print("Error in saving to context, \(error)")
        }
        tableView.reloadData()
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categories.append(newCategory)
            self.saveCategories()
            
        }
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "Create new category"
            textField = alertTextfield
        }
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
}
