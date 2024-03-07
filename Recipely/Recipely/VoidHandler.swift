// VoidHandler.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// Создаем типы для кложур
// swiftlint:disable all
public typealias VoidHandler = () -> ()
public typealias BoolHandler = (Bool) -> ()
public typealias StringHandler = (String) -> ()
public typealias DateHandler = (Date) -> ()
public typealias OptionalDateHandler = (Date?) -> ()
public typealias DataHandler = (Data) -> ()
// swiftlint:enable all
