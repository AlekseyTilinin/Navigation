//
//  InfoViewController.swift
//  Navigation
//
//  Created by Aleksey on 01.09.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = infoTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var orbitalPeriod: UILabel = {
        let label = UILabel()
        label.text = "Период обращения планеты \(planetName) вокруг своей звезды равен: \(planetOrbitalPeriod)"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tableView: UITableView = {
         let tableView = UITableView(frame: .zero, style: .plain)
         tableView.dataSource = self
         tableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultTableCellIdentifier")
        tableView.translatesAutoresizingMaskIntoConstraints = false
         return tableView
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
          super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
              self.tableView.reloadData()

          }
      }
    
    func setupConstraints() {

        view.addSubview(titleLabel)
        view.addSubview(orbitalPeriod)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            orbitalPeriod.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            orbitalPeriod.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            orbitalPeriod.widthAnchor.constraint(equalToConstant: 300),
            
            tableView.topAnchor.constraint(equalTo: orbitalPeriod.bottomAnchor, constant: 50),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension InfoViewController : UITableViewDataSource {

     func numberOfSections(in tableView: UITableView) -> Int {
         return 1
     }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return residents.count
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

         let cell = tableView.dequeueReusableCell(withIdentifier: "defaultTableCellIdentifier", for: indexPath)

         NetworkService.request(for: residents[indexPath.row], index: indexPath.row)
         cell.textLabel?.text = residents[indexPath.row]

         return cell
     }
 }
