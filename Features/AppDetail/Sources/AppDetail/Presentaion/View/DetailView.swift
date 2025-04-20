//
//  DetailView.swift
//
//
//  Created by Yulian Hincapie on 19/04/25.
//

import SwiftUI
import AppCommons

public struct DetailView: View {
    
    let delegate: DetailDelegate?
    
    @ObservedObject private var viewModel: DetailViewModel
    private let id: String
    
    public init(id: String, delegate: DetailDelegate? = nil) {
        Appearance.registerPackageFonts()
        viewModel = DetailViewModel()
        self.id = id
        self.delegate = delegate
    }
    
    public var body: some View {
        ZStack(alignment: .top) {
            AppColors.colorPrimary.ignoresSafeArea()
            switch (viewModel.state) {
            case .loadin:
                VStack {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.5)
                    Spacer()
                }
            case .success(let data):
                BodyView(data: data, delegate: delegate)
            case .failure(let error):
                AppColors.colorPrimary.onAppear {
                    delegate?.error(type: error)
                }
            }
        }.onAppear {
            Task { await self.viewModel.loadDetail(id: id) }
        }
    }
    
    public struct BodyView: View {
        
        let delegate: DetailDelegate?
        let data: ArticleDetailUIModel
        
        private let arrow = "arrow.backward"
        private let newsSiteText = "News site:"
        private let publishedText = "Published at:"
        private let updatedText = "Updated at:"
        
        public init(data: ArticleDetailUIModel, delegate: DetailDelegate? = nil) {
            Appearance.registerPackageFonts()
            self.data = data
            self.delegate = delegate
        }
        
        public var body: some View {
            VStack(spacing: 0) {
                HStack {
                    Button(action: {
                        delegate?.goBack()
                    }, label: {
                        Image(systemName: arrow)
                            .resizable()
                            .foregroundColor(AppColors.colorSecondary)
                            .frame(width: 26, height: 18)
                            .padding(.leading, 14)
                    }).frame(width: 30, height: 30)
                    Spacer()
                }.padding(EdgeInsets(top: 8, leading: 10, bottom: 0, trailing: 0))
                ScrollView(showsIndicators: false) {
                    
                    if let image = data.imageUrl { BannerView(image: image) }
                    
                    if let title = data.title, !title.isEmpty  {
                        HStack {
                            Text(title).roboto(20, colorText: AppColors.colorSecondary)
                                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                            Spacer()
                        }
                    }
                    
                    if let summary = data.summary, !summary.isEmpty {
                        HStack {
                            Text(summary).specialGothic(15, colorText: AppColors.colorSecondary)
                                .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                            Spacer()
                        }
                    }
                    
                    if let link = data.url, !link.isEmpty { ButtonUnderLine(permalink: link) }
                    
                    if let newsSite = data.newsSite, !newsSite.isEmpty {
                        HStack {
                            Spacer()
                            Text("\(newsSiteText) \(newsSite)").specialGothic(15, colorText: AppColors.colorSecondary)
                                .padding(EdgeInsets(top: 40, leading: 20, bottom: 0, trailing: 20))
                            Spacer()
                        }
                    }
                    
                    if let authors = data.authors, !authors.isEmpty {
                        HStack {
                            Spacer()
                            Text(authors.map { $0.name ?? "" }.joined(separator: ", ")).specialGothic(15, colorText: AppColors.colorSecondary)
                                .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                            Spacer()
                        }
                    }
                    
                    if let publishedAt = data.publishedAt, !publishedAt.isEmpty {
                        let date = formatDate(dateString: publishedAt)
                        HStack {
                            Text("\(publishedText) \(date)").specialGothic(15, colorText: AppColors.colorSecondary)
                                .padding(EdgeInsets(top: 40, leading: 20, bottom: 0, trailing: 20))
                            Spacer()
                        }
                    }
                    
                    if let updatedAt = data.updatedAt, !updatedAt.isEmpty {
                        let date = formatDate(dateString: updatedAt)
                        HStack {
                            Text("\(updatedText) \(date)").specialGothic(15, colorText: AppColors.colorSecondary)
                                .padding(EdgeInsets(top: 20, leading: 20, bottom: 30, trailing: 20))
                            Spacer()
                        }
                    }
                    
                }
                .navigationBarHidden(true)
                .onReceive(NetworkMonitor.shared.$networkStatus.dropFirst(), perform: { _ in
                    delegate?.error(type: .errorNetworkDetail)
                })
                .padding(.top, 10)
            }
            .background(AppColors.colorPrimary)
        }
    }
}
