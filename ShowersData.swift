//
//  ShowersData.swift
//  Shower App
//
//  Created by Student on 20/11/21.
//

import Foundation
import SwiftUI

class <#Model#>Data: ObservableObject {
    @Published var <#Model#>s: [<#Model#>] = []
    
    let sample<#Model#>s = []
    
    func getArchiveURL() -> URL {
        let plistName = "<#Model#>s.plist"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        return documentsDirectory.appendingPathComponent(plistName)
    }
    
    func save() {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encoded<#Model#>s = try? propertyListEncoder.encode(<#Model#>s)
        try? encoded<#Model#>s?.write(to: archiveURL, options: .noFileProtection)
    }
    
    func load() {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
        
        var final<#Model#>s: [<#Model#>]!
        
        if let retrieved<#Model#>Data = try? Data(contentsOf: archiveURL),
            let decoded<#Model#>s = try? propertyListDecoder.decode([<#Model#>].self, from: retrieved<#Model#>Data) {
            final<#Model#>s = decoded<#Model#>s
        } else {
            final<#Model#>s = sample<#Model#>s
        }
        
        <#Model#>s = final<#Model#>s
    }
}
