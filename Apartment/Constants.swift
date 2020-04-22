//
//  Constants.swift
//  Apartment
//
//  Created by Kittikawin Sontinarakul on 22/4/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import Foundation

struct K {
    
    struct StoryboardID {
        static let main = "Main"
        static let tabbarMain = "tabbarMain"
    }
    struct Segue {
        static let roomSetup = "goToRoomSetup"
        static let customerSetup = "goToCustomerSetup"
    }
    
    struct ReuseCell {
        static let roomcellNibName = "StartConfigRoomsCell"
        static let roomConfigReuseCell = "roomReusableCell"
        static let customercellNibName = "StartConfigCustomerCell"
        static let customerConfigReuseCell = "customerReusableCell"
    }
}
