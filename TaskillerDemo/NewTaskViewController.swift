//
//  NewTaskViewController.swift
//  TaskillerDemo
//
//  Created by kingcyk on 02/07/2017.
//  Copyright © 2017 kingcyk. All rights reserved.
//

import UIKit
import CoreActionSheetPicker
import TaskillerKit
import RealmSwift

class NewTaskViewController: UIViewController {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var taskName: UITextField!
    @IBOutlet weak var selectTable: UITableView!
    @IBOutlet weak var choiceCollection: UICollectionView!
    @IBOutlet weak var createButton: UIButton!
    
    var costHour = 0
    var costMin = 0
    var repeatType = 0
    var dueTime: Date!
    var listId = 0
    
    var realm: Realm!
    var notificationToken: NotificationToken!
    
    let accountManager = AccountManager.sharedInstance
    
    var tasks = List<Task>()
    
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        costHour = 0
        costMin = 0
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
        
        setupRealm()

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
        let tasks = self.tasks
        try! tasks.realm?.write {
            tasks.insert(Task(value: ["name": taskName.text!,
                                      "costHour": costHour,
                                      "costMin": costMin,
                                      "dueTime": dueTime,
                                      "repeatType": repeatType]), at: tasks.filter("completed = false").count)
        }
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
    
    func setupRealm() {
        let username = accountManager.currentAccount!
        let password = accountManager.passwordForAccount(username)!
        let usernameCredentials = SyncCredentials.usernamePassword(username: username, password: password, register: false)
        SyncUser.logIn(with: usernameCredentials, server: URL(string: serverURL)!) { (user, error) in
            if let user = user  {
                DispatchQueue.main.async {
                    let configuration = Realm.Configuration(
                        syncConfiguration: SyncConfiguration(user: user, realmURL: URL(string: "realm://taskiller.kingcyk.com:9080/\(username)/tasks")!)
                    )
                    self.realm = try! Realm(configuration: configuration)
                    
                    func updateList() {
                        if self.tasks.realm == nil, let list = self.realm.objects(TaskList.self).first {
                            self.tasks = list.tasks
                        }
                    }
                    updateList()
                    
                    self.notificationToken = self.realm.addNotificationBlock { _ in
                        updateList()
                    }
                }
            }
        }
    }
    
    deinit {
        notificationToken.stop()
    }

}

extension NewTaskViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Basic", for: indexPath) as! NewTaskTableViewCell
        cell.nameLabel.text = names[indexPath.row]
        cell.categoryImage.image = UIImage(named: icons[indexPath.row])
        cell.valueLabel.text = ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            ActionSheetDatePicker.show(withTitle: "Due Time", datePickerMode: .dateAndTime, selectedDate: Date(), minimumDate: Date(), maximumDate: nil, doneBlock: { (picker, date, origin) in
                self.dueTime = date as! Date
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = TimeZone.current
                dateFormatter.dateFormat = "MM-dd HH:mm"
                let cell = tableView.cellForRow(at: indexPath) as! NewTaskTableViewCell
                cell.valueLabel.text = dateFormatter.string(from: date as! Date)
            }, cancel: { (picker) in
                return
            }, origin: tableView)
            return
        case 1:
            ActionSheetDatePicker.show(withTitle: "Cost Time", datePickerMode: .countDownTimer, selectedDate: Date(), doneBlock: { (picker, date, origin) in
                let counter = date as! Int
                self.costHour = counter / 3600
                self.costMin = counter % 3600 / 60
                let cell = tableView.cellForRow(at: indexPath) as! NewTaskTableViewCell
                cell.valueLabel.text = "\(self.costHour)Hr \(self.costMin)Min"
            }, cancel: { (picker) in
                return
            }, origin: tableView)
        case 2:
            ActionSheetStringPicker.show(withTitle: "Repeat", rows: ["Never", "Everyday"], initialSelection: 0, doneBlock: { (picker, index, value) in
                let cell = tableView.cellForRow(at: indexPath) as! NewTaskTableViewCell
                cell.valueLabel.text = index == 1 ? "Everyday" : "Never"
                self.repeatType = index
            }, cancel: { (picker) in
                return
            }, origin: tableView)
        default:
            return
        }
    }

}

extension NewTaskViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Choice", for: indexPath) as! NewTaskCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let cell = collectionView.cellForItem(at: indexPath) as! NewTaskCollectionViewCell
            cell.bgImage.image = UIImage(named: "oval_red")
            cell.choiceName.textColor = UIColor(red: 0.94, green: 0.25, blue: 0.294, alpha: 1)
        default:
            return
        }
    }

}
