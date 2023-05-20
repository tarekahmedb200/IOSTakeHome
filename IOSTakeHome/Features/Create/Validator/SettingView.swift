//
//  SettingView.swift
//  IOSTakeHome
//
//  Created by lapshop on 5/15/23.
//

import Foundation
import SwiftUI

struct SettingView: View {
    
    @AppStorage(UserDefaultKeys.hapticsEnabled) private var isHapticsEnabled : Bool = true
    
    var body: some View {
        NavigationView {
            Form {
                haptics
            }
            .navigationTitle("Settings")
        }
        
    }
}

struct SettingView_Previews: PreviewProvider {
    
    static var previews: some View {
        SettingView()
    }
}


private extension SettingView {
    var haptics : some View {
        Toggle("Enable Haptics",isOn: $isHapticsEnabled)
    }
}

