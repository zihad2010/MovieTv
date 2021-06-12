//
//  ShowsDetailsViewModel.swift
//  MovieTv
//
//  Created by Asraful Alam on 12/6/21.
//
import RxSwift
import RxCocoa


class ShowsDetailsViewModel {
    
    private let disposable = DisposeBag()
    
    public let info: BehaviorRelay<Info> = BehaviorRelay(value: Info())
    public let loading: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    public let error : PublishSubject<ApiError> = PublishSubject()
    public let title: PublishSubject<String> = PublishSubject()
    public let ratingDetails: PublishSubject<String> = PublishSubject()
    public let posterImageUrl: PublishSubject<URL> = PublishSubject()
    public let language: PublishSubject<String> = PublishSubject()
    public let generDetails: PublishSubject<String> = PublishSubject()
    public let overView: PublishSubject<String> = PublishSubject()
  
    private static let dateFormatter: DateFormatter = {
        $0.dateFormat = "yyyy"
        return $0
    }(DateFormatter())
    
    func getResource(info: Info) -> Resource<MovieDetailsResponse> {
        
        guard let url = URL.getDetailsUrl(info: info) else {
            fatalError("URl was incorrect")
        }
        var resource = Resource<MovieDetailsResponse>(url: url)
        resource.httpMethod = .get
        return resource
    }
    
    func fetchDtaWith(resource: Resource<MovieDetailsResponse>) {
    
        self.loading.accept(true)
        TMDbWebService
            .load(resource: resource)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] response in
                self?.loading.accept(false)
                switch response{
                case .success(let data):
                    if let title = data.original_title {
                        self?.title.onNext(title)
                    }
                    if let url = URL.getImageUrl(path: data.backdrop_path) {
                        self?.posterImageUrl.onNext(url)
                    }
                    if let ratingDetail = self?.movieInfoString(movieDetail: data) {
                        self?.ratingDetails.onNext(ratingDetail)
                    }
                    if let lan = data.original_language {
                        self?.language.onNext(lan)
                    }
                    if let overView = data.overview {
                        self?.overView.onNext(overView)
                    }
                    
                    if let gener = self?.moveGenerDetails(movieDetail: data) {
                        self?.generDetails.onNext(gener)
                    }
                
                
                  break
                case .failure(let failure):
                    switch failure {
                    case .unknownError:
                        self?.error.onNext(.serverMessage(UIMessages.error))
                    case .authorizationError(_):
                        self?.error.onNext(.serverMessage(UIMessages.error))
                    default:
                        self?.error.onNext(.serverMessage(UIMessages.error))
                    }
                }
            }, onError: {[weak self] (error) in
                self?.loading.accept(false)
                self?.error.onNext(.serverMessage(error.localizedDescription))
            })
            .disposed(by: disposable)
    }
}

extension ShowsDetailsViewModel {
    
    private func moveGenerDetails(movieDetail: MovieDetailsResponse) -> String? {
       
        let generList = movieDetail.genres?.map({ (item) -> String in
            return item.name ?? ""
        })
       return generList?.joined(separator:" • ")

    }
    
    private func movieInfoString(movieDetail: MovieDetailsResponse) -> String {
        var details = "" //2019 • 129 min • 5.9/10 ★
        if let releaseDate = movieDetail.release_date {
            details += releaseDate//ShowsDetailsViewModel.dateFormatter.string(from: releaseDate)
        }
        if let runtime = movieDetail.runtime {
            details += (details.isEmpty ? "" : " • ") + "\(runtime) min"
        }

        if let voteAvg = movieDetail.vote_average {
            details += (details.isEmpty ? "" : " • ") + "\(voteAvg)/10 ★"
        }
        return details
    }
    
}

struct Info {
    var id: Int?
    var type: String?
}

