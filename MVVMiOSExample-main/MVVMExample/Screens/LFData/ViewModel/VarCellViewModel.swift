//
//  VarCellViewModel.swift
//  MVVMExample
//
//  Created by Rinki Ganguly on 14/12/22.
//

import Foundation

struct VarCellViewModel {
    var lf: String
    var freq: Int
    var since: Int
    var varArr: [VarCellViewModelVar]
   }

   struct VarCellViewModelVar {
       var lf: String
       var freq: Int
       var since: Int
   }
