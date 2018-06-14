//
//  pop_up_view_controller.swift
//  playing with sql
//
//  Created by Stuart Cameron on 2018-06-11.
//  Copyright © 2018 Stuart Cameron. All rights reserved.
//

import UIKit

class pop_up_view_controller: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func Back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
