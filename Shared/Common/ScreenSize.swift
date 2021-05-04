//
//  ScreenSize.swift
//  PopularMoviesSwiftUI (macOS)
//
//  Created by Alex2 on 02.05.2021.
//


#if os(watchOS)
import Foundation
#elseif os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif


class ScreenSize{
    #if os(watchOS)
    static var deviceWidth: CGFloat = WKInterfaceDevice.current().screenBounds.size.width
    static var screenScale: CGFloat = WKInterfaceDevice.current().scale
    #elseif os(iOS)
    static var deviceWidth: CGFloat = UIScreen.main.bounds.size.width
    static var screenScale: CGFloat = UIScreen.main.scale
    #elseif os(macOS)
    static var deviceWidth: CGFloat = NSScreen.main?.visibleFrame.size.width ?? 0
    static var screenScale: CGFloat = NSScreen.main?.backingScaleFactor ?? 1
    #endif
}

