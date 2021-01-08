//
//  MovieListController.swift
//  MovieBox
//
//  Created by Dinesh Tanwar on 07/01/21.
//  Copyright © 2021 Dinesh Tanwar. All rights reserved.
//

import UIKit
import AVKit

class MovieListController: UIViewController, videoPlayDelegate {
    
    //MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    
    var searchContoller: UISearchController!
    private var viewModel = MovieViewModel()
    private var videoVM = VideoViewModel()
    var test: String = ""
    //For Pagination
    var isDataLoading:Bool=false
    var pageNo:Int=1
    var limit:Int=20
    var offset:Int=0 //pageNo*limit
    var didEndReached:Bool=false
    
    //MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        //get movie data
        loadNewMoviesData(withOffset: offset, limit: pageNo)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorColor = .clear
    }
    
    func configureUI() {
        let logo = UIImage(named: "logo")
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit
        //        self.navigationItem.titleView = imageView
        self.navigationController?.navigationBar.barTintColor = UIColor.lightBlue1
        self.navigationItem.title = "MovieBox"
        
    }
    
    private func loadNewMoviesData(withOffset offset: Int, limit: Int) {
        viewModel.fetchNewMoviesData(withoffset: offset, limit: limit) { [weak self] in
            self?.tableView.dataSource = self
            //just to move focus to 1st row after for next page
            self?.tableView.setContentOffset(CGPoint.zero, animated: false)
            self?.tableView.reloadData()
            self?.tableView.layoutIfNeeded()
            self?.tableView.setContentOffset(CGPoint.zero, animated: false)
            self?.tableView.reloadData()
        }
    }
    
    func playvideo(atCell: Int) {
        let indexpath = IndexPath(row: atCell, section: 0)
        let movie = viewModel.cellForRowAt(indexPath: indexpath)

        videoVM.fetchVideoData(forMovieId: movie.id) { [weak self] in
            //get the first video for playing
            let video = self?.videoVM.cellForRowAt(indexPath: IndexPath(row: 0, section: 0))
            let key  = video?.key ?? "NA"
            if key == "NA" {
                //show alert of no video available
            }
            else {
                var urlString = "https://www.youtube.com/watch?v="+key
                urlString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                
                guard let videoURL = URL(string: urlString) else {return}
                let video = AVPlayer(url: videoURL)
                let videoPlayer = AVPlayerViewController()
                videoPlayer.player = video
                self!.present(videoPlayer, animated:true, completion: {
                       video.play()
                })
            }
            
        }
    }
    
}

//Implement pagination after the basic view
extension MovieListController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moviecell", for: indexPath) as! MovieItemCell
        
        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(movie)
        cell.playBtn.tag = indexPath.row
        cell.delegate = self
        cell.updateConstraintsIfNeeded()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailVC") as! MovieDetailVC
        viewController.selectedMovie = movie
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
}

extension MovieListController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("scrollViewWillBeginDragging")
        isDataLoading = false
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
    }
    
    //Pagination
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

            print("scrollViewDidEndDragging")
            if ((tableView.contentOffset.y + tableView.frame.size.height) >= tableView.contentSize.height)
            {
                if !isDataLoading{
                    isDataLoading = true
                    self.pageNo = self.pageNo+1
                    self.limit = self.limit+20
                    self.offset = self.limit * self.pageNo
                    self.loadNewMoviesData(withOffset: self.offset, limit: pageNo)

                }
            }


    }

}

