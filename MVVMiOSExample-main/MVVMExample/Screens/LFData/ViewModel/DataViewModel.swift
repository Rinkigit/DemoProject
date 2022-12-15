//
//  DataViewModel.swift
//  MVVMExample
//
//  Created by Rinki Ganguly on 14/12/22.
//

import Foundation

class DataViewModel: NSObject{
    private var webService: WebServiceProtocol
    
    var reloadTableView: (() -> Void)?
    
    var employees = Results()
    
    var employeeCellViewModels = [VarCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    var employeeCellViewModelsVar = [VarCellViewModelVar]() {
        didSet {
            reloadTableView?()
        }
    }
    
    init(employeeService: WebServiceProtocol = WebService()) {
        self.webService = employeeService
    }
    
    func getEmployees() {
        webService.getEmployees { success, model, error in
            if success, let employees = model {
                self.fetchData(employees: employees)
            } else {
                print(error!)
            }
        }
    }
    
    func fetchData(employees: Results) {
        self.employees = employees
        if employees.count > 0 {
            employeeCellViewModels = createCellModel(employee: employees[0])
        }
        
    }
    
    
    
    func createCellModel(employee: Result) ->[VarCellViewModel] {
        if let lfsAr = employee.lfs {
            
            let lfsArr = lfsAr.compactMap {(singleData) -> VarCellViewModel? in

                let varArr = singleData.vars?.compactMap {(singleDataVar) -> VarCellViewModelVar? in
                    
                    return VarCellViewModelVar(lf: singleDataVar.lf , freq: singleDataVar.freq , since: singleDataVar.since)
                }
                
                return VarCellViewModel(lf: singleData.lf , freq: singleData.freq , since: singleData.since, varArr: varArr ?? [])
            }
            return lfsArr
        }else{
            return []
        }
    }
    
    func getCellViewModel(at indexPath: Int) -> VarCellViewModelVar {
        return employeeCellViewModelsVar[indexPath]
    }
}
