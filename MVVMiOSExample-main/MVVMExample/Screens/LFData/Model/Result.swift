//
//  Result.swift
//  MVVMExample
//
//  Created by Rinki Ganguly on 13/12/22.
//

import Foundation

typealias Results = [Result]

//  let results: Results
//Rinki demo
struct Result: Codable {
    let lfs: [Lfs]?
    let sf: String
}
//}

struct Lfs: Codable {
    let vars: [Vars]?
    let lf: String
    let freq: Int
    let since: Int
}

struct Vars: Codable {
    let lf: String
    let freq: Int
    let since: Int
}


