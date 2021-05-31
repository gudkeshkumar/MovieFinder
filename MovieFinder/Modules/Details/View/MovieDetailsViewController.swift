//
//  MovieDetailsViewController.swift
//  MovieFinder
//
//  Created by apple on 01/04/21.
//

import UIKit

final class MovieDetailsViewController: UIViewController {
    var presenter: MovieDetailsPresenter?

    @IBOutlet weak var directors: UILabel!
    @IBOutlet weak var writers: UILabel!
    @IBOutlet weak var actors: UILabel!
    @IBOutlet weak var plot: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var runTime: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    private func refreshView() {
        guard let details = presenter?.movie else { return }
        if let urlstring = details.imageURL {
            imageView.sd_setImage(with: URL(string: urlstring), placeholderImage: nil, options: [], context: nil)
        }
        movieTitle.text = details.title
        year.text = details.year
        genre.text = details.genre ?? "N/A"
        runTime.text = details.runTime ?? "N/A"
        rating.text = details.imdbRating ?? "N/A"
        plot.text = details.plot
        actors.text = details.actors
        writers.text = details.writer
        directors.text = details.director
    }
}

extension MovieDetailsViewController: MovieDetailsPresenterToViewProtocol {
    func onMovieDetailsFetchSuccess() {
        refreshView()
    }
    
    func onMovieDetailsFetchFailure(error: String?) {
        showAlert(title: "Error", message: error ?? "Unknown error")
    }
    
    func startLoading() {
        
    }
    
    func stopLoading() {
        
    }
}
