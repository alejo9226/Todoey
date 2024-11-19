//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

//  var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demorgon"]
  var itemArray = [Item]()

  // 246. Commenting this to use our own plist.
  // let defaults = UserDefaults.standard

  // 246. Create our own plist file with our own data type.
  // let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

  // 250. Setting up the code to use CoreData, this is how we use the AppDelegate context.
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

  override func viewDidLoad() {
      super.viewDidLoad()

    // print(dataFilePath!)


    // 238. Retrieving data from User Defaults
//    if let items = defaults.array(forKey: "TodoListArray") as? [String] {
//      itemArray = items
//    }

    // 247. Commentint the following because
    // We're now loading our own plist file with our own data type.
    // let itemOne = Item(title: "Find Mike")
    // let itemTwo = Item(title: "Buy Eggos")
    // let itemThree = Item(title: "Destroy Demorgon")

    // itemArray.append(itemOne)
    // itemArray.append(itemTwo)
    //itemArray.append(itemThree)

    // 247. Load our own plist file with our own data type.
    // 250. Commenting this to use core data
     loadData()
  }

  // MARK: - Tableview Datasource Methods
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)

    let item = itemArray[indexPath.row]

    cell.textLabel?.text = item.title

    cell.accessoryType = item.done ? .checkmark : .none

    return cell
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemArray.count
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(indexPath.row)
    print(itemArray[indexPath.row])

    // 254. This is the command (setValue) to update keys in the NSManaged Object
    // Commented out bcs we're updating it by its done prop directly.
    // itemArray[indexPath.row].setValue(false, forKey: "done")

//    if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//      tableView.cellForRow(at: indexPath)?.accessoryType = .none
//    } else {
//      tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//    }

    // 255. Trying deleting stuff from CoreData.
    // Commenting it out since not being used.
    // context.delete(itemArray[indexPath.row])
    // itemArray.remove(at: indexPath.row)

//    itemArray[indexPath.row].done = !itemArray[i  ndexPath.row].done

    // 246. Writing to our own plist.
    saveData()

//    tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark

    tableView.deselectRow(at: indexPath, animated: true)

  }
  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    var textField = UITextField()

    let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)

    // This adds a button to the pop up
    let action = UIAlertAction(title: "Add", style: .default) { action in
      // What happens once the user clicks the CTA
      print("Success", textField.text ?? "")

      let newItem = Item(context: self.context)
      newItem.title = textField.text!
      newItem.done = false

      self.itemArray.append(newItem)

      // 246. Commenting this to use our own plist.
      // self.defaults.set(self.itemArray, forKey: "TodoListArray")

      // 246. Writing to our own plist.
      self.saveData()
    }

    alert.addTextField { alertTextField in
      alertTextField.placeholder = "Create new item"
      textField = alertTextField
      print(alertTextField.text!)
    }

    alert.addAction(action)

    present(alert, animated: true, completion: nil)
  }

  func saveData() {

    // 250. Commenting this to use CoreData
    // let encoder = PropertyListEncoder()
    do {
      // 250. Commenting this to use CoreData
      // let data = try encoder.encode(self.itemArray)
      // try data.write(to: self.dataFilePath!)

      // 250. Saving CoreData context
      try context.save()

      // Forces the call of the Data delegate methods
      tableView.reloadData()
    } catch {
      print("Error saving context: \(error)")
    }
  }

  func loadData() {

      // 253. Commenting the following to implement Core Data Reading
      //    if let data = try? Data(contentsOf: self.dataFilePath!) {
      //      let decoder = PropertyListDecoder()
      //      do {
      //        self.itemArray = try decoder.decode([Item].self, from: data)
      //      } catch {
      //        print("Error decoding item array: \(error)")
      //      }
      //    }
    let request: NSFetchRequest<Item> = Item.fetchRequest()

    do {
      itemArray = try context.fetch(request)
    } catch {
      print("Error fetching context: \(error)")
    }

  }

}

