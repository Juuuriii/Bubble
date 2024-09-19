//
//  SettingsViewModel.swift
//  Bubble
//
//  Created by Juri Huhn on 19.09.24.
//

import Foundation

class SettingsViewModel: ObservableObject {
    
    let symbol = Locale.current.currencySymbol
    
    
    init(){
        print(symbol ?? "")
    }
    
    
}
