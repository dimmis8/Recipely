// Font+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// MARK: - Добавление методов для вызова часто используемых шрифтов

extension UIFont {
    class func verdana(ofSize fontSize: CGFloat) -> UIFont {
        UIFont(name: "Verdana", size: fontSize) ?? UIFont()
    }

    class func verdanaBold(ofSize fontSize: CGFloat) -> UIFont {
        UIFont(name: "Verdana-Bold", size: fontSize) ?? UIFont()
    }
}
