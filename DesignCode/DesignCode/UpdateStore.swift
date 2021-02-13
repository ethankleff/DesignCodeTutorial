//
//  UpdateStore.swift
//  DesignCode
//
//  Created by Ethan Rackleff on 11/13/20.
//  Copyright © 2020 Ethan Rackleff. All rights reserved.
//

import SwiftUI
import Combine

class UpdateStore: ObservableObject {
    @Published var updates: [Update] = updateData
}
