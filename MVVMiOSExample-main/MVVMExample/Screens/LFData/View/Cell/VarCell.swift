//
//  VarCell.swift
//  MVVMExample
//
//  Created by Rinki Ganguly on 13/12/22.
//

import UIKit

class VarCell: UITableViewCell {
    @IBOutlet var lfLabel: UILabel!
    @IBOutlet var freqLabel: UILabel!
    @IBOutlet var sinceLabel: UILabel!
   

    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }

    var cellViewModel: VarCellViewModel? {
        didSet {
            lfLabel.text = cellViewModel?.lf
            freqLabel.text = String(cellViewModel!.freq)
            sinceLabel.text = String(cellViewModel!.since)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }

    func initView() {
        // Cell view customization
        backgroundColor = .clear

        // Line separator full width
        preservesSuperviewLayoutMargins = true
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        lfLabel.text = nil
        freqLabel.text = nil
        sinceLabel.text = nil
    }
}
