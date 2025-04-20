//
//  DetailDelegate.swift
//  AppDetail
//
//  Created by Yulian Hincapie on 19/04/25.
//

public protocol DetailDelegate: AnyObject {
    func goBack()
    func error(type: DetailsErrors)
}
