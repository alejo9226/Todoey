//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {

//  var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demorgon"]
  // 263. Commenting this out to use Realm
  // var itemArray = [Item]()
  var toDoItems: Results<Item>?

  var selectedCategory: Category? {
    didSet {
      loadData()
      self.title = selectedCategory?.name
    }
  }

  // 246. Commenting this to use our own plist.
  // let defaults = UserDefaults.standard

  // 246. Create our own plist file with our own data type.
  // let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

  // 250. Setting up the code to use CoreData, this is how we use the AppDelegate context.
  // 263. Commenting this out to use Realm.
  // let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

  let realm = try! Realm()

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
//     loadData()
  }

  // MARK: - Tableview Datasource Methods
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)

    if let item = toDoItems?[indexPath.row] {
      cell.textLabel?.text = item.title
      cell.accessoryType = item.done ? .checkmark : .none
    } else {
      cell.textLabel?.text = "No items added yet!"
    }

    return cell
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return toDoItems?.count ?? 1
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(indexPath.row)
    print(toDoItems?[indexPath.row].title ?? "")

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

//    toDoItems?[indexPath.row].done = !toDoItems?[indexPath.row].done

    // 246. Writing to our own plist.
//    saveData()

//    tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark

    // 264. Implementing Update in CRUD
    if let item = toDoItems?[indexPath.row] {
      do {
        try realm.write {
          item.done = !item.done

          // 265. Implementing Delete in Realm
          // Commented out bcs we don't want that UX
          // realm.delete(item)
        }
      } catch {
        print("Error saving done status, \(error)")
      }
    }

    tableView.reloadData()

    tableView.deselectRow(at: indexPath, animated: true)

  }
  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    var textField = UITextField()

    let alert = UIAlertController(title: "Add New \(self.selectedCategory?.name ?? "Todoey") Item", message: "", preferredStyle: .alert)

    // This adds a button to the pop up
    let action = UIAlertAction(title: "Add", style: .default) { action in
      // What happens once the user clicks the CTA
      print("Success", textField.text ?? "")

      if let currentCategory = self.selectedCategory {
        do {
          try self.realm.write {
            let newItem = Item()
            newItem.title = textField.text!
            currentCategory.items.append(newItem)
            self.realm.add(newItem)
          }
        } catch {
          print("Error saving item: \(error)")
        }
      }

      self.tableView.reloadData()


//
//      self.itemArray.append(newItem)

      // 246. Commenting this to use our own plist.
      // self.defaults.set(self.itemArray, forKey: "TodoListArray")

      // 246. Writing to our own plist.
      // 263. Commenting this out to use Realm
      // self.saveData()


    }

    alert.addTextField { alertTextField in
      alertTextField.placeholder = "Create new item"
      textField = alertTextField
      print(alertTextField.text!)
    }

    alert.addAction(action)

    present(alert, animated: true, completion: nil)
  }

  func saveData(item: Item) {

    // 250. Commenting this to use CoreData
    // let encoder = PropertyListEncoder()
    do {
      // 250. Commenting this to use CoreData
      // let data = try encoder.encode(self.itemArray)
      // try data.write(to: self.dataFilePath!)

      // 250. Saving CoreData context
      // 263. Commenting this out to use Realm
      // try context.save()

      try realm.write {
        realm.add(item)
      }

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
    // 260. Generating a compound predicate.
    // 263. Commenting CoreData code out to use
    // Realm.
    // let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)

    // if let additionalPredicate = predicate {
    //  request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
    // } else {
    //   request.predicate = categoryPredicate
    // }

    toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
    // 263. Commenting CoreData code out to use
    // Realm.
//    do {
//      itemArray = try context.fetch(request)
//
//      tableView.reloadData()
//    } catch {
//      print("Error fetching context: \(error)")
//    }

  }
}

// MARK: - Search bar methods
//extension TodoListViewController: UISearchBarDelegate {
//  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
//    if let text = searchBar.text, !text.isEmpty {
//      let request: NSFetchRequest<Item> = Item.fetchRequest()
//
//      let predicate = NSPredicate(format: "title CONTAINS[cd] %@", text)
//      request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//      loadData(with: request, predicate: predicate)
//    } else {
//      loadData()
//    }
//  }
//
//  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//    if searchBar.text?.isEmpty == true {
//      loadData()
//
//      // This has to be executed in the main thread,
//      // it's a UI update
//      DispatchQueue.main.async {
//        searchBar.resignFirstResponder()
//      }
//
//    } else {
//
//      let request: NSFetchRequest<Item> = Item.fetchRequest()
//
//      let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//      request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//      loadData(with: request, predicate: predicate)
//    }
//  }
//}

