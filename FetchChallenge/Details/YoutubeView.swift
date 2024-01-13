//
//  YoutubeView.swift
//  FetchChallenge
//
//  Created by S J on 1/13/24.
//
import Foundation
import SwiftUI
import WebKit

struct YoutubeView: UIViewRepresentable {
  
  var videoURL: URL

  func makeUIView(context: Context) -> WKWebView {
    let request = URLRequest(url: videoURL)
    let wkWebView = WKWebView()
    wkWebView.load(request)
    return wkWebView
  }

  func updateUIView(_ uiView: WKWebView, context: Context) {}
}
