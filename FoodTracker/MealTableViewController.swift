//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Nattawat Nonsung on 14/7/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit
import os.log

class MealTableViewController: UITableViewController {

  // MARK: Properties

  var meals = [Meal]()

  // MARK: Actions

  @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
    if let sourceViewController = sender.source as? MealViewController, let meal = sourceViewController.meal {
      if let selectedIndexPath = tableView.indexPathForSelectedRow {
        // Update an existing meal.
        meals[selectedIndexPath.row] = meal
        tableView.reloadRows(at: [selectedIndexPath], with: .none)
      }
      else {
        // Add a new meal.
        let newIndexPath = IndexPath(row: meals.count, section: 0)

        meals.append(meal)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
      }
    }
  }

  // MARK: Private Methods

  private func loadSampleMeals() {
    let photo1 = UIImage(named: "meal1")
    let photo2 = UIImage(named: "meal2")
    let photo3 = UIImage(named: "meal3")

    guard let meal1 = Meal(name: "Salmon Steak", photo: photo1, rating: 4) else {
      fatalError("Unable to instantiate meal1")
    }

    guard let meal2 = Meal(name: "Chicken and Becon Burger", photo: photo2, rating: 5) else {
      fatalError("Unable to instantiate meal2")
    }

    guard let meal3 = Meal(name: "Pad Thai", photo: photo3, rating: 3) else {
      fatalError("Unable to instantiate meal3")
    }

    meals += [meal1, meal2, meal3]
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    // Load the sample data.
    loadSampleMeals()

    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   return meals.count
  }


  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Table view cells are reused and should be dequeued using a cell identifier.
    let cellIdentifier = "MealTableViewCell"

    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell  else {
      fatalError("The dequeued cell is not an instance of MealTableViewCell.")
    }

    // Fetches the appropriate meal for the data source layout.
    let meal = meals[indexPath.row]

    cell.nameLabel.text = meal.name
    cell.photoImageView.image = meal.photo
    cell.ratingControl.rating = meal.rating

    return cell
  }

  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)

    switch(segue.identifier ?? "") {

    case "NewItem":
      os_log("Adding a new meal.", log: OSLog.default, type: .debug)

    case "ShowDetail":
      guard let mealDetailViewController = segue.destination as? MealViewController else {
        fatalError("Unexpected destination: \(segue.destination)")
      }

      guard let selectedMealCell = sender as? MealTableViewCell else {
        fatalError("Unexpected sender: \(sender)")
      }

      guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
        fatalError("The selected cell is not being displayed by the table")
      }

      let selectedMeal = meals[indexPath.row]
      mealDetailViewController.meal = selectedMeal

    default:
      fatalError("Unexpected Segue Identifier; \(segue.identifier)")
    }
  }

}
