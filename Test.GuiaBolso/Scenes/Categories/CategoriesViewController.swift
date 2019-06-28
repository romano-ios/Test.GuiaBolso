//
//  CategoriesViewController.swift
//  Test.GuiaBolso
//
//  Created by Leandro Romano on 27/06/19.
//  Copyright (c) 2019 Leandro Romano. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CategoriesDisplayLogic: class {
    func displaySomething(viewModel: Categories.Something.ViewModel)
}

class CategoriesViewController: UIViewController, CategoriesDisplayLogic {

    var interactor: CategoriesBusinessLogic?
    var router: (NSObjectProtocol & CategoriesRoutingLogic & CategoriesDataPassing)?

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = CategoriesInteractor()
        let presenter = CategoriesPresenter()
        let router = CategoriesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        doSomething()
    }

    // MARK: Do something

    //@IBOutlet weak var nameTextField: UITextField!

    func doSomething() {
        let request = Categories.Something.Request()
        interactor?.doSomething(request: request)
    }

    func displaySomething(viewModel: Categories.Something.ViewModel) {
        //nameTextField.text = viewModel.name
    }
    
}