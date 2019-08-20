//
//  AppDelegate.swift
//  DropPy License Manager
//
//  Created by Günther Eberl on 21.09.17.
//  Copyright © 2017 Günther Eberl. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
