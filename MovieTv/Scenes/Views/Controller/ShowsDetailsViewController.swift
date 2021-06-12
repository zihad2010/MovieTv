//
//  ShowsDetailsViewController.swift
//  MovieTv
//
//  Created by Asraful Alam on 9/6/21.
//

import UIKit
import RxSwift
import RxCocoa

class ShowsDetailsViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingDeatilsLabel: UILabel!
    @IBOutlet weak var generDetailsLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var navigationTitleLabel: UILabel!
    
    var coordinator: ShowsDetailsCoordinator?
    public var viewModel = ShowsDetailsViewModel()
    private let loader = ActivityIndicator()
    private let disposable = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupBindings()
    }
    
    private func setupBindings(){
        
        viewModel.info.subscribe(onNext: { [self] info in
           
            self.viewModel.fetchDtaWith(resource: self.viewModel.getResource(info: info))
        }).disposed(by: disposable)
        
        //Loader ----
        self.viewModel
            .loading
            .subscribe(onNext: { [weak self] active in
                print("active:---",active)
                active ? self?.loader.showLoading(view: self?.view) : self?.loader.hideLoading()
            })
            .disposed(by: disposable)
        
        // TostView ---
        self.viewModel
            .error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { error in
                switch error{
                case .internetError(let mess):
                    ToastView.shared.short(self.view, txt_msg: "  \(mess)  ")
                case .serverMessage(let mess):
                    ToastView.shared.short(self.view, txt_msg: "  \(mess)  ")
                }
            })
            .disposed(by: disposable)

        viewModel
            .posterImageUrl
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { url in
                self.posterImageView.getImage(url: url, placeholderImage: UIImage()) { (success) in
                } failer: { (failed) in
                }
            }).disposed(by: disposable)

        viewModel
            .title
            .observeOn(MainScheduler.instance)
            .bind(to:self.titleLabel.rx.text)
            .disposed(by:disposable)
        
        viewModel
            .ratingDetails
            .observeOn(MainScheduler.instance)
            .bind(to:self.ratingDeatilsLabel.rx.text)
            .disposed(by:disposable)
        
        viewModel
            .generDetails
            .observeOn(MainScheduler.instance)
            .bind(to:self.generDetailsLabel.rx.text)
            .disposed(by:disposable)
        
        viewModel
            .overView
            .observeOn(MainScheduler.instance)
            .bind(to:self.overViewLabel.rx.text)
            .disposed(by:disposable)
    }
    
    @IBAction func backButtonisClicked() {
        self.coordinator?.popViewController()
    }

}
