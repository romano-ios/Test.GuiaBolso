//
//  JokePresenter.swift
//  Test.GuiaBolso
//
//  Created by Leandro Romano on 28/06/19.
//  Copyright (c) 2019 Leandro Romano. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

protocol JokePresentationLogic {
    func presentView(title viewTitle: String)
    func presentLoadingState()
    func presentFilledState()
    func presentJoke(response: Joke.Response)
    func presentError(_ error: Error)
    func presentJokePageBy(url jokeUrl: String)
}

class JokePresenter: JokePresentationLogic {

    weak var viewController: JokeDisplayLogic?

    func presentView(title viewTitle: String) {
        viewController?.displayView(title: viewTitle)
    }
    
    func presentLoadingState() {
        viewController?.displayLoadingState()
    }
    
    func presentFilledState() {
        viewController?.displayFilledState()
    }
    
    func presentJoke(response: Joke.Response) {
        let viewModel = Joke.ViewModel(joke: response)
        viewController?.displayRandomJoke(viewModel: viewModel)
    }
    
    func presentError(_ error: Error) {
        viewController?.displayResponseError(message: error.localizedDescription)
    }
    
    func presentJokePageBy(url jokeUrl: String) {
        viewController?.displayJokePageBy(url: jokeUrl)
    }
    
}