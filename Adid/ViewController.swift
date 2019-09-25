//
//  ViewController.swift
//  Connect
//
//  Created by Ty Yiu on 08.08.19.
//  Copyright © 2019 Ty Yiu. All rights reserved.
//
import Foundation
import UIKit
class ViewController: UIViewController {
    private var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        scrollView.flashScrollIndicators()
        _ = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { timer in
            self.scrollView.flashScrollIndicators()
        }
    }
    private func setupUI() {
        let rightPanel = MenuViewController()
        let centerPanel = QRViewController()
        let leftPanel = EditViewController()
        scrollView = UIScrollView.makeHorizontal(
            with: [leftPanel, centerPanel, rightPanel],
            in: self
        )
        view.addSubview(scrollView)
        scrollView.fit(to: view)
    }
}
extension UIViewController {
    func addChild(_ controller: UIViewController, toContainer container: UIView) {
        guard let subView = controller.view else { return }
        addChild(controller)
        container.addSubview(subView)
        controller.didMove(toParent: self)
        subView.fit(to: container)
        container.clipsToBounds = true
    }
}
extension UIView {
    func fit(to container: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: container.leadingAnchor),
            trailingAnchor.constraint(equalTo: container.trailingAnchor),
            topAnchor.constraint(equalTo: container.topAnchor),
            bottomAnchor.constraint(equalTo: container.bottomAnchor)
            ])
    }
}
extension UIScrollView {
    fileprivate static func make() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }
    static func makeHorizontal(with horizontalControllers: [UIViewController], in parent: UIViewController) -> UIScrollView {
        let scrollView = UIScrollView.make()
        func add(_ child: UIViewController, withOffset offset: CGFloat) {
            parent.addChild(child)
            scrollView.addSubview(child.view)
            child.didMove(toParent: parent)
            child.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                child.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                child.view.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
                child.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: offset)
                ])
        }
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        for (index, controller) in horizontalControllers.enumerated() {
            let xPosition = CGFloat(index) * width
            add(controller, withOffset: xPosition)
        }
        scrollView.contentSize = CGSize(width: width * CGFloat(horizontalControllers.count), height: height)
        scrollView.setContentOffset(CGPoint(x: UIScreen.main.bounds.width, y: 0), animated: false)
        return scrollView
    }
}
