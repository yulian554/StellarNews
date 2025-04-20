//
//  HomeDelegate.swift
//  StellarNews
//
//  Created by Yulian Hincapie on 18/04/25.
//

import AppCommons

protocol HomeDelegate: AnyObject {
    func didLoadArticles(_ articles: [ArticlesUIModel])
    func didErrorLoadArticles()
    func didNetworkError()
}
