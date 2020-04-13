//
//  ViewController.swift
//  ExpandableTableView
//
//  Created by RakeshPC on 07/07/19.
//  Copyright © 2019 RakeshPC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var expandableTableVIew: UITableView!
    
    var tableData = [TableData(title: "Title1", subTitle: ["subtile1", "subtile2"], isExpand: false),
                     TableData(title: "Title2", subTitle: ["subtile1", "subtile2", "subtile3"], isExpand: false),
                     TableData(title: "Title3", subTitle: ["subtile1", "subtile2","subtile3","subtile4"], isExpand: false),
                     TableData(title: "Title4", subTitle: ["subtile1", "subtile2","subtile3","subtile4","subtile5"], isExpand: false),
                     TableData(title: "Title5", subTitle: ["subtile1", "subtile2"], isExpand: false)
                    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        expandableTableVIew.tableFooterView = UIView()
        expandableTableVIew.register(UINib(nibName: "HeaderCell", bundle: nil), forCellReuseIdentifier: "HeaderCell")
        // Do any additional setup after loading the view.
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = HeaderView(frame: CGRect(x: 30, y: 0, width: tableView.frame.width - 60, height: 40))
        let headerView = expandableTableVIew.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
        headerView.delegate = self
        headerView.sectionIndex = section
        headerView.btn.setTitle(tableData[section].title, for: .normal)
        
        if tableData[section].isExpand {
            headerView.backView.layer.cornerRadius = 10
            headerView.backView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            headerView.backView.dropShadow()
        }else{
            headerView.backView.layer.cornerRadius = 10
            headerView.backView.layer.shadowColor = UIColor.darkGray.cgColor
            headerView.backView.layer.shadowOffset = CGSize(width: 0, height: 1.0)//CGSize(width: 5.0, height: 5.0)
            headerView.backView.layer.shadowRadius = 4.0
            headerView.backView.layer.shadowOpacity = 0.9
        }
        
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 10))
        footerView.backgroundColor = .white
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableData[section].isExpand {
            return tableData[section].subTitle.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = expandableTableVIew.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as! MyTableViewCell
        cell.lblSubTitle.text = tableData[indexPath.section].subTitle[indexPath.row]
        cell.bgView.layer.cornerRadius = 0
        cell.bgView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let myCell = cell as? MyTableViewCell
        
        myCell?.bgView.dropShadow()
        myCell?.lineView.isHidden = false
        let totalRows = expandableTableVIew.numberOfRows(inSection: indexPath.section)
        if indexPath.row == totalRows - 1 {
            //this is the last row in section.
            myCell?.lineView.isHidden = true
            myCell?.bgView.layer.cornerRadius = 10
            myCell?.bgView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
    }
    
}

extension ViewController: HeaderViewDelegate {
    func cellHeader(idx: Int) {
        tableData[idx].isExpand = !tableData[idx].isExpand
//        expandableTableVIew.reloadSections([idx], with: .automatic)
        expandableTableVIew.reloadData()
    }
}

extension UITableView {
    
    func isLast(for indexPath: IndexPath) -> Bool {
        
        let indexOfLastSection = numberOfSections > 0 ? numberOfSections - 1 : 0
        let indexOfLastRowInLastSection = numberOfRows(inSection: indexOfLastSection) - 1
        
        return indexPath.section == indexOfLastSection && indexPath.row == indexOfLastRowInLastSection
    }
}

extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.54
        layer.shadowOffset = CGSize(width: 0, height: 1.0)//.zero
        layer.shadowRadius = 4
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
