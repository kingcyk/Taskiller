//
//  NewTaskViewController.swift
//  TaskillerDemo
//
//  Created by kingcyk on 02/07/2017.
//  Copyright © 2017 kingcyk. All rights reserved.
//

import UIKit

class NewTaskViewController: UIViewController {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var taskName: UITextField!
    @IBOutlet weak var selectTable: UITableView!
    @IBOutlet weak var choiceCollection: UICollectionView!
    @IBOutlet weak var createButton: UIButton!
    
    let icons = [
        "duetime",
        "cost_grey",
        "repeat_grey"
    ]
    
    let names = [
        "Due time",
        "Cost time",
        "Repeat"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectTable.rowHeight = 50
        selectTable.separatorStyle = .none
        selectTable.register(UINib(nibName: "NewTaskTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "Basic")
        selectTable.dataSource = self
        selectTable.delegate = self
        selectTable.isScrollEnabled = false
        
        choiceCollection.register(UINib(nibName: "NewTaskCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "Choice")
        choiceCollection.dataSource = self
        choiceCollection.delegate = self
        choiceCollection.isScrollEnabled = false

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelAdd(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func createTask(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NewTaskViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Basic", for: indexPath) as! NewTaskTableViewCell
        cell.nameLabel.text = names[indexPath.row]
        cell.categoryImage.image = UIImage(named: icons[indexPath.row])
        cell.valueLabel.isHidden = indexPath.row == 1 ? false : true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

extension NewTaskViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Choice", for: indexPath) as! NewTaskCollectionViewCell
        if indexPath.row == 8 {
            cell.choiceName.text = "..."
        }
        return cell
    }

}
