//
//  DataViewController.swift
//  MVVMExample
//
//  Created by Rinki Ganguly on 14/12/22.
//

import UIKit

class DataViewController: UIViewController {
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var noItemsView: UIView!
    var filteredIndices = [Int]()
    var countryList :String = ""
    
    lazy var viewModel = {
        DataViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
        
        self.searchBar.delegate = self
        
        // Change the Tint Color
        self.searchBar.barTintColor = UIColor.darkGray
        self.searchBar.tintColor = UIColor.white
        // Show/Hide Cancel Button
        self.searchBar.showsCancelButton = true
        // Change TextField Colors
        let searchTextField = self.searchBar.searchTextField
        searchTextField.textColor = UIColor.white
        searchTextField.clearButtonMode = .never
        searchTextField.backgroundColor = UIColor.lightGray
        // Change Glass Icon Color
        let glassIconView = searchTextField.leftView as! UIImageView
        glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
        glassIconView.tintColor = UIColor.black
        
        
        self.searchBar.keyboardAppearance = .dark
        
        //If showing LFS data in tableview section
        
//        let nib = UINib(nibName: "LFHeaderDetails", bundle: nil)
//        tableView.register(nib, forHeaderFooterViewReuseIdentifier: "LFHeader")
      
        tableView.backgroundView = noItemsView
    }
    
    func initView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.separatorColor = .black
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        
        tableView.register(VarCell.nib, forCellReuseIdentifier: VarCell.identifier)
    }
    
    func initViewModel() {
        // Reload TableView closure
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDelegate

extension DataViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 111
    }
    //If showing LFS data in tableview section
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 95.0
//    }
}


// MARK: - UITableViewDataSource

extension DataViewController: UITableViewDataSource {
    //If showing LFS data in tableview section
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//           return viewModel.employeeCellViewModels.count
//    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        let headerView = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "LFHeader")  as! LFHeaderDetails
//        headerView.lfLabel.text = viewModel.employeeCellViewModels[section].lf
//        headerView.freqLabel.text = String(viewModel.employeeCellViewModels[section].freq)
//        headerView.sinceLabel.text = String(viewModel.employeeCellViewModels[section].since)
//
//        return headerView
//
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (viewModel.employeeCellViewModels.count != 0) {
            tableView.backgroundView?.isHidden = true
                return viewModel.employeeCellViewModels.count
                
            }else{
                tableView.backgroundView?.isHidden = false
                return 0
            }
    }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VarCell.identifier, for: indexPath) as? VarCell else { fatalError("xib does not exists") }
       // let section = viewModel.employeeCellViewModels[indexPath.section]
        let headline = viewModel.employeeCellViewModels[indexPath.row]
        cell.cellViewModel = headline
        return cell
    }
}
// MARK: - UISearchBarDelegate

extension DataViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        UserDefaults.standard.set(searchText, forKey: "searchText")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.employeeCellViewModels.removeAll()
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.employeeCellViewModels.removeAll()
        
        if Reachability.isConnectedToNetwork(){
            // Get employees data
            viewModel.getEmployees()
        }else{
            let alert = UIAlertController(title: "Sorry", message: "No Internet Connection Available", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        searchBar.resignFirstResponder()
    }
}
