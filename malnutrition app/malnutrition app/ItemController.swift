//
//  ItemController.swift
//  malnutrition app
//
//  Created by Bowen Jin on 11/14/16.
//  Copyright © 2016 Bowen Jin. All rights reserved.
//

import Foundation


protocol ItemController {
    var item: Item? {get set}
    func setItem(item: Item);
}
