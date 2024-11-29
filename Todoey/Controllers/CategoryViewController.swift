//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Alejandro Alfaro on 20/11/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {

  let realm = try! Realm()

  // 264. Realm returns Results of type Category
  // var categories = [Category]()
  var categories: Results<Category>?

  // 268. Commenting this out since we're switching to Realm
  // let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

  override func viewDidLoad() {
      super.viewDidLoad()

      self.title = "Todoey"

      loadData()
  }

  // MARK: - Add new Categories

  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {

    var textField = UITextField()

    let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)

    let action = UIAlertAction(title: "Add", style: .default) { action in

      // What happens once the user clicks the CTA
      print("Success", textField.text ?? "")

      let newCategory = Category()
      newCategory.name = textField.text!

      // Commenting this out since in Realm
      // Results auto update and monitor for
      // changes itself
      // self.categories.append(newCategory)

      self.saveData(category: newCategory)
    }

    alert.addTextField { alertTextField in
      alertTextField.placeholder = "Create category"
      textField = alertTextField
    }

    alert.addAction(action)

    // This shows/launches the modal
    present(alert, animated: true, completion: nil)

  }

  // MARK: - TableView Datasource Methods

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)

    cell.textLabel?.text = categories?[indexPath.row].name ?? "No categories added yet"

    return cell
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return categories?.count ?? 1
  }

  // MARK: - Data manipulation methods

  func saveData(category: Category) {


    do {
      try realm.write {
        realm.add(category)
      }

      // Forces the call of the Data delegate methods
      tableView.reloadData()
    } catch {
      print("Error saving context: \(error)")
    }
  }

  func loadData() {

    categories = realm.objects(Category.self)

    // Commenting this out to use Realm
//    do {
//      categories = try context.fetch(request)
//
      tableView.reloadData()
//    } catch {
//      print("Error fetching context: \(error)")
//    }
  }

  // MARK: - TableView Delegate Methods

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    performSegue(withIdentifier: "goToItems", sender: self)

    tableView.deselectRow(at: indexPath, animated: true)
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let destinationVC = segue.destination as! TodoListViewController

    // Grab the current selected row.
    if let indexPath = tableView.indexPathForSelectedRow {
      destinationVC.selectedCategory = categories?[indexPath.row]
    }

  }
}
