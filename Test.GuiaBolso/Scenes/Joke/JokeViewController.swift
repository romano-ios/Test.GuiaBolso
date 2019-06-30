//
//  JokeViewController.swift
//  Test.GuiaBolso
//
//  Created by Leandro Romano on 28/06/19.
//  Copyright (c) 2019 Leandro Romano. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class JokeViewController: UIViewController {

    var interactor: JokeBusinessLogic?
    var router: (NSObjectProtocol & JokeRoutingLogic & JokeDataPassing)?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        let viewController = self
        let interactor = JokeInteractor()
        let presenter = JokePresenter()
        let router = JokeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupAccessibilityIdentifiers()
        requestRandomJoke()
    }
    
    fileprivate func setupView() {
        if #available(iOS 11.0, *) { navigationItem.largeTitleDisplayMode = .never }
        contentView.alpha = 0.0
        interactor?.setupViewTitle()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(requestRandomJoke))
    }
    
    fileprivate func setupAccessibilityIdentifiers() {
        avatarImageView.accessibilityIdentifier = JokeAccessibilityIdentifier.chuckNorrisAvatarImage.rawValue
        jokePhraseLabel.accessibilityIdentifier = JokeAccessibilityIdentifier.chuckNorrisRandomJokePhrase.rawValue
        jokeUrlPageButton.accessibilityIdentifier = JokeAccessibilityIdentifier.chuckNorrisButtonToJokePage.rawValue
    }
    
    @objc fileprivate func requestRandomJoke() {
        interactor?.setupLoadingState()
        interactor?.requestRandomJoke()
    }

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var jokePhraseLabel: UILabel!
    @IBOutlet weak var jokeUrlPageButton: VisitPageButton!
    
    @IBAction func openJokeLinkAct(_ sender: Any) {
        interactor?.requestOpenJokePage()
    }
    
}
