//
//  ViewController.swift
//  WatherToday
//
//  Created by nimble on 13/6/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

extension Int {
    func formatCurrency() -> String {
        let formater = NumberFormatter()
        formater.numberStyle = .currency
        formater.locale = Locale.current
        formater.currencySymbol = ""
        formater.maximumFractionDigits = 0
        guard let currencyNumber = formater.string(from: NSNumber(value: self)) else { return "" }
        return "\(currencyNumber)"
    }

    func formatCurrencyOld(showUnit: Bool = true) -> String {
      let formater = NumberFormatter()
      formater.decimalSeparator = ","
      formater.numberStyle = .decimal
      formater.locale = Locale.current
      formater.currencySymbol = ""
      formater.allowsFloats = false
      let unit = showUnit ? " บาท" : ""

      if let currencyNumber = formater.string(from: NSNumber(value: self)) {
        return "\(currencyNumber)\(unit)"
      } else {
        let currencyFormatter = "\(unit)"
        return String(format: currencyFormatter, self)
      }
    }
}

