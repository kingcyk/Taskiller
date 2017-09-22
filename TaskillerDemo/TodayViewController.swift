//
//  TodayViewController.swift
//  TaskillerDemo
//
//  Created by kingcyk on 02/07/2017.
//  Copyright © 2017 kingcyk. All rights reserved.
//

import UIKit
import TaskillerKit
import RealmSwift
import AppStoreStyleHorizontalScrollView

class TodayViewController: UIViewController {

    let taskScrollView = ASHorizontalScrollView(frame: CGRect(x: 0, y: 363, width: 320, height: 240))
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var avatarView: UIImageView!
    
    let accountManager = AccountManager.sharedInstance

    let dateFormatter = DateFormatter()
    
    var tasks = List<Task>()
    
    var notificationToken: NotificationToken!
    var realm: Realm!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.taskScrollView.removeAllItems()
        Bundle.main.loadNibNamed("TaskBlockCell", owner: self, options: nil)
        for task in self.tasks {
            let cell = TaskBlockCell()
            cell.taskTitle.text = task.name
            cell.leftButton.isHidden = true
            cell.rightButton.isHidden = false
            cell.listName.text = "Default"
            cell.listType.backgroundColor = UIColor(red: 0.94, green: 0.25, blue: 0.294, alpha: 1)
            cell.costLabel.text = "\(task.costHour)h \(task.costMin)min"
            cell.taskView.layer.shadowColor = UIColor.black.cgColor
            cell.taskView.layer.shadowOffset = CGSize(width: 0, height: 6)
            cell.taskView.layer.shadowOpacity = 0.85
            cell.taskView.layer.shadowRadius = 10
            self.taskScrollView.addItem(cell)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundAvatar(avatar: avatarView)
        
        dateFormatter.locale = Locale.current
        dateFormatter.dateStyle = DateFormatter.Style.long
        dateLabel.text = dateFormatter.string(from: Date()).uppercased()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.delegate = self
        avatarView.addGestureRecognizer(tapGestureRecognizer)
        
        self.view.addSubview(taskScrollView)
        taskScrollView.marginSettings_320 = MarginSettings(leftMargin: 10, miniMarginBetweenItems: 5, miniAppearWidthOfLastItem: 20)
        taskScrollView.marginSettings_414 = MarginSettings(leftMargin: 10, miniMarginBetweenItems: 5, miniAppearWidthOfLastItem: 20)
        taskScrollView.defaultMarginSettings = MarginSettings(leftMargin: 10, miniMarginBetweenItems: 10, miniAppearWidthOfLastItem: 10)
        taskScrollView.uniformItemSize = CGSize(width: 150, height: 240)
        taskScrollView.setItemsMarginOnce()
        taskScrollView.removeAllItems()
        
        setupRealm()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupRealm() {
        if let username = accountManager.currentAccount {
            let password = accountManager.passwordForAccount(username)!
            let usernameCredentials = SyncCredentials.usernamePassword(username: username, password: password, register: false)
            SyncUser.logIn(with: usernameCredentials, server: URL(string: serverURL)!, onCompletion: { (user, error) in
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
                            self.taskScrollView.removeAllItems()
                            Bundle.main.loadNibNamed("TaskBlockCell", owner: self, options: nil)
                            for task in self.tasks {
                                let cell = TaskBlockCell()
                                cell.taskTitle.text = task.name
                                cell.leftButton.isHidden = true
                                cell.rightButton.isHidden = false
                                cell.listName.text = "Default"
                                cell.listType.backgroundColor = UIColor(red: 0.94, green: 0.25, blue: 0.294, alpha: 1)
                                cell.costLabel.text = "\(task.costHour)h \(task.costMin)min"
                                cell.taskView.layer.shadowColor = UIColor.black.cgColor
                                cell.taskView.layer.shadowOffset = CGSize(width: 0, height: 6)
                                cell.taskView.layer.shadowOpacity = 0.85
                                cell.taskView.layer.shadowRadius = 10
                                self.taskScrollView.addItem(cell)
                            }
                        }
                        updateList()
                        
                        self.notificationToken = self.realm.addNotificationBlock { _ in
                            updateList()
                        }
                    }
                }
            })
        }
    }
    
    deinit {
        notificationToken.stop()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func tapHandler(_ sender: UITapGestureRecognizer) {
        let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
        let profileView = sb.instantiateViewController(withIdentifier: "ProfileView")
        profileView.modalTransitionStyle = .flipHorizontal
        profileView.modalPresentationStyle = .fullScreen
        self.present(profileView, animated: true, completion: nil)
    }
}

extension TodayViewController: UIGestureRecognizerDelegate {
    
}
