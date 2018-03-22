//
//  AppDelegate.swift
//  TestProject
//
//  Created by Darren Tung on 13/11/17.
//  Copyright © 2017 Darren Tung. All rights reserved.
//

import Foundation
import ReachabilitySwift

class ReachabilityManager: NSObject {
	
    var reachability = Reachability(hostname: "www.google.com")!
	
    // MARK: - SHARED MANAGER
    static let shared: ReachabilityManager =  ReachabilityManager()

	
	func isInternetAvailableForAllNetworks() -> Bool
	{
        return reachability.isReachable
	}
	
	func doSetupReachability() {
		
		
		reachability.whenReachable = { reachability in
            
		}
        
		reachability.whenUnreachable = { reachability in
            
		}
		
		do {
			try reachability.startNotifier()
		}
		catch {
		}
	}
	
	deinit{
		reachability.stopNotifier()
	}
}
