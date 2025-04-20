//
//  SearchDelegate.swift
//  StellarNews
//
//  Created by Yulian Hincapie on 19/04/25.
//

import AppCommons

protocol SearchDelegate: AnyObject {
    func didSearchArticles(_ articles: [ArticlesUIModel])
    func didSearchArticlesEmpty()
    func didErrorSearchArticles()
    func didNetworkError()
}
