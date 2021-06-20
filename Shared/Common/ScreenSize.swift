//
//  ScreenSize.swift
//  PopularMoviesSwiftUI (macOS)
//
//  Created by Alex2 on 02.05.2021.
//


#if os(watchOS)
import WatchKit
#elseif os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#elseif os(tvOS)
import TVUIKit
#endif


class ScreenSize{
    #if os(watchOS)
    static var deviceWidth: CGFloat = WKInterfaceDevice.current().screenBounds.size.width
    static var screenScale: CGFloat = WKInterfaceDevice.current().screenScale
    #elseif os(iOS)
    static var deviceWidth: CGFloat = UIScreen.main.bounds.size.width
    static var screenScale: CGFloat = UIScreen.main.scale
    #elseif os(macOS)
    static var deviceWidth: CGFloat = NSScreen.main?.visibleFrame.size.width ?? 0
    static var screenScale: CGFloat = NSScreen.main?.backingScaleFactor ?? 1
    #elseif os(tvOS)
    static var deviceWidth: CGFloat = UIScreen.main.bounds.size.width
    static var deviceHeight: CGFloat = UIScreen.main.bounds.size.height
    static var screenScale: CGFloat = UIScreen.main.scale
    #endif
}

