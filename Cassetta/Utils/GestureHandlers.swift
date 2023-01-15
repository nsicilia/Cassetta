//
//  GestureHandlers.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 1/13/23.
//

import UIKit
import SwiftUI
import MinimizableView


struct GestureHandlers {
    static func dragUpdated(value: DragGesture.Value, miniHandler: MinimizableViewHandler) {
        
        if miniHandler.isMinimized == false && value.translation.height > 0   { // expanded state
            withAnimation(.spring(response: 0)) {
                miniHandler.draggedOffsetY = value.translation.height  // divide by a factor > 1 for more "inertia"
            }
            
        } else if miniHandler.isMinimized && value.translation.height < 0   {// minimized state
            if miniHandler.draggedOffsetY >= -60 {
                withAnimation(.spring(response: 0)) {
                    miniHandler.draggedOffsetY = value.translation.height // divide by a factor > 1 for more "inertia"
                }
            }
            
        }
    }
    
    
   static func dragOnEnded(value: DragGesture.Value, miniHandler: MinimizableViewHandler) {
        
        if miniHandler.isMinimized == false && value.translation.height > 90  {
            miniHandler.minimize()
            
        } else if miniHandler.isMinimized &&  value.translation.height <= -60 {
            miniHandler.expand()
        }
        withAnimation(.spring()) {
            miniHandler.draggedOffsetY = 0
        }
        
        
    }
    
}
