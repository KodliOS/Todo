//
//  ViewController.swift
//  TodoApp
//
//  Created by Yasin Akbaş on 6.12.2019.
//  Copyright © 2019 Yasin Akbaş. All rights reserved.
//

import UIKit
import API

class ViewController: UIViewController {
    
    var layout = Layout()
    
    var dataArray = [Todo]()
    
    lazy var tableView = UITableView()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(addButtonClicked(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var removeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Remove", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(removeButtonClicked(_:)), for: .touchUpInside)
        return button
    }()
    
    @objc
    private func addButtonClicked(_ sender: UIButton) {
        dataArray.append(Todo(id: 0, title: "New Data", description: "...."))
        tableView.reloadData()
    }
    
    @objc
    private func removeButtonClicked(_ sender: UIButton) {
        dataArray.removeAll()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataArray = api.getTodoList()
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        setupTableview()
        setupAddButton()
        setupRemoveButton()
    }
    
    private func setupTableview() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        
        // disable default constraint
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        // setup constraints way 1
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: view.bounds.height / 2).isActive = true
        
        // setup constraints way 2
        //        NSLayoutConstraint.activate([
        //            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        //            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        //            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        //            tableView.heightAnchor.constraint(equalToConstant: view.bounds.height / 2)
        //        ])
        // <reference> setup constraints way 3 https://www.raywenderlich.com/277-auto-layout-visual-format-language-tutorial
        // example "V:[appImageView]-10-[welcomeLabel]"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setupAddButton() {
        view.addSubview(addButton)
        
        let width:CGFloat = self.view.bounds.width / 2
        let height:CGFloat = 70
        
        let gradient = CAGradientLayer()
        gradient.locations = [0.0,1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        let color1 = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).cgColor
        let color2 = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1).cgColor
        gradient.colors = [color1, color2]
        gradient.frame = CGRect(x: 0, y: 0, width: width, height: height)
        addButton.layer.insertSublayer(gradient, at: 0)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: layout.addButtonMargins.left).isActive = true
        addButton.topAnchor.constraint(equalTo: view.topAnchor, constant: layout.addButtonMargins.top).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupRemoveButton() {
        view.addSubview(removeButton)
        
        let width:CGFloat = self.view.bounds.width / 2
        let height:CGFloat = 70
        
        let gradient = CAGradientLayer()
        gradient.locations = [0.0,1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        let color1 = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1).cgColor
        let color2 = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).cgColor
        gradient.colors = [color1, color2]
        gradient.frame = CGRect(x: 0, y: 0, width: width, height: height)
        removeButton.layer.insertSublayer(gradient, at: 0)
        
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        removeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: layout.removeButtonMargins.right).isActive = true
        removeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: layout.removeButtonMargins.top).isActive = true
        removeButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        removeButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    struct Layout {
        let addButtonMargins = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
        let addButtonSize = CGSize(width: 0, height: 70)
        let removeButtonMargins = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
    }
}

extension ViewController: UITableViewDelegate { }

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell() }
        cell.textLabel?.text = dataArray[indexPath.row].title
        cell.textLabel?.textColor = .white
        cell.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        return cell
    }
    
}

