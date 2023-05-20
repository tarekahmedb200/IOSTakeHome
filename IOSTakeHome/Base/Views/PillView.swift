//
//  PillView.swift
//  IOSTakeHome
//
//  Created by lapshop on 5/12/23.
//

import SwiftUI

struct PillView: View {
    
    let id: Int
    
    var body: some View {
        Text("#\(id)")
            .font(
                .system(.caption,design: .rounded)
                .bold()
            )
            .foregroundColor(.white)
            .padding(.horizontal,9)
            .padding(.vertical,9)
            .background(Theme.pill,in:Capsule())
    }
}

struct PillView_Previews: PreviewProvider {
    static var previews: some View {
        PillView(id: 0)
    }
}
