//
//  CreatureRow.swift
//  Genetics
//
//  Created by Clément Nonn on 29/06/2020.
//  Copyright © 2020 clement.nonn. All rights reserved.
//

import SwiftUI

struct CreatureRow: View {
    let creature: Creature

    var body: some View {
        Text(creature.name)
    }
}
