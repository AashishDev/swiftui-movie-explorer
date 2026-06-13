//
//  AppRouter.swift
//  MovieExplorer
//
//  Created by Aashish Tyagi on 6/13/26.
//

import Observation
import SwiftUI

@MainActor
@Observable
final class Router {
    var path = NavigationPath()
    
    func push(_ route:AppRoute){
        path.append(route)
    }
    
    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
    func popToRoot(){
        path.removeLast(path.count)
    }
    
    
}
