//
//  InstallCell.swift
//  testRick
//
//  Created by Андрей Цуркан on 16.11.2022.
//

import UIKit

class RickInfoCell: UITableViewCell {
    var responseResult: ResponseResult?{
        didSet{
            downloadPoster()
            reloadData()
        }
    }
    static var reusedId = "InstallCell"
    private let imageCeche = NSCache<NSString,UIImage>()
    private var imageViewVector = UIImageView()
    private let labelName = UILabel()
    private let labelGenderRace = UILabel()
    private let labelStatus = UILabel()
    private let buttonWatch = UIButton()
    private let labelPlanets = UILabel()
    private let viewStatus = UIView()
    private var networkDataFetcher = NetworkDataFetcher()
    private let posterImageView: UIImageView = {
           let imageView = UIImageView()
           imageView.translatesAutoresizingMaskIntoConstraints = false
           imageView.backgroundColor = .black
           imageView.contentMode = .scaleAspectFill
           imageView.clipsToBounds = true
           return imageView
       }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        settapImageView()
        settapLabelName()
        settapSubData()
        settapButton()
        settapLabelPlanets()
        settapLabelStatus()
        settapImageViewVector()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData() {
        guard let responseResult = responseResult else {
            return
        }
        labelName.text = responseResult.name
        labelStatus.text = responseResult.status
        labelGenderRace.text = "\(responseResult.species ?? ""), \(responseResult.gender?.lowercased() ?? "")"
        labelPlanets.text = responseResult.origin?.name
        
        let status = Status(rawValue: responseResult.status ?? "")
        labelStatus.text = status?.text
        labelStatus.textColor = status?.textColor
        viewStatus.backgroundColor = status?.backgroundColor
    }
    
    func settapImageViewVector() {
        addSubview(imageViewVector)
        imageViewVector.translatesAutoresizingMaskIntoConstraints = false
        imageViewVector.image = UIImage(named: "Vector")
        
        [imageViewVector.topAnchor.constraint(equalTo: buttonWatch.bottomAnchor, constant: 10),
         imageViewVector.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 8),
         imageViewVector.widthAnchor.constraint(equalToConstant: 10)].forEach{$0.isActive = true}
    }
    
    func settapImageView() {
        addSubview(posterImageView)
        posterImageView.layer.cornerRadius = 40
        
        [posterImageView.topAnchor.constraint(equalTo: topAnchor,constant: 20),
         posterImageView.leftAnchor.constraint(equalTo: leftAnchor,constant: 10),
         posterImageView.heightAnchor.constraint(equalToConstant: 120),
         posterImageView.widthAnchor.constraint(equalToConstant: 120)].forEach{$0.isActive = true}
    }
    
    func settapLabelName() {
        addSubview(labelName)
        labelName.font = UIFont.systemFont(ofSize: 21)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        
        [labelName.topAnchor.constraint(equalTo: topAnchor, constant: 20),
         labelName.leftAnchor.constraint(equalTo:posterImageView.rightAnchor,constant: 8),
         labelName.widthAnchor.constraint(equalToConstant: 180),
         labelName.heightAnchor.constraint(equalToConstant: 25)].forEach{$0.isActive = true}
    }
    
    func settapSubData() {
        addSubview(labelGenderRace)
        labelGenderRace.translatesAutoresizingMaskIntoConstraints = false
        labelGenderRace.font = UIFont.systemFont(ofSize: 14)
        
        [labelGenderRace.topAnchor.constraint(equalTo: labelName.bottomAnchor,constant: 5),
         labelGenderRace.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 8),
         labelGenderRace.heightAnchor.constraint(equalToConstant: 17)].forEach{$0.isActive = true}
    }
    
    func settapButton() {
        addSubview(buttonWatch)
        buttonWatch.translatesAutoresizingMaskIntoConstraints = false
        buttonWatch.layer.cornerRadius = 17
        buttonWatch.backgroundColor = UIColor(red: 255.0/255.0, green: 107.0/255.0, blue: 0.0, alpha: 0.1)
        buttonWatch.setTitleColor(UIColor(red: 255, green: 107, blue: 0), for: .normal)
        buttonWatch.setTitle("▶ Watch episodes", for: .normal)
        buttonWatch.titleLabel!.font = UIFont.systemFont(ofSize: 14)
        
        [buttonWatch.topAnchor.constraint(equalTo: labelGenderRace.bottomAnchor,constant: 8),
         buttonWatch.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 8),
         buttonWatch.heightAnchor.constraint(equalToConstant: 35),
         buttonWatch.widthAnchor.constraint(equalToConstant: 148)].forEach{$0.isActive = true}
    }
    
    func settapLabelPlanets() {
        addSubview(labelPlanets)
        labelPlanets.translatesAutoresizingMaskIntoConstraints = false
        labelPlanets.font = UIFont.systemFont(ofSize: 14)
        
        [labelPlanets.topAnchor.constraint(equalTo: buttonWatch.bottomAnchor,constant: 8),
         labelPlanets.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 25),
         labelPlanets.heightAnchor.constraint(equalToConstant: 17)].forEach{$0.isActive = true}
    }
    
    func settapLabelStatus() {
        addSubview(viewStatus)
        viewStatus.translatesAutoresizingMaskIntoConstraints = false
        viewStatus.layer.cornerRadius = 10
        
        viewStatus.addSubview(labelStatus)
        labelStatus.translatesAutoresizingMaskIntoConstraints = false
        labelStatus.font = UIFont.systemFont(ofSize: 14)
        
        [viewStatus.topAnchor.constraint(equalTo: topAnchor,constant: 20),
         viewStatus.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
         viewStatus.heightAnchor.constraint(equalToConstant: 25)].forEach{$0.isActive = true}
        
        [labelStatus.topAnchor.constraint(equalTo: viewStatus.topAnchor, constant: 3),
         labelStatus.leftAnchor.constraint(equalTo: viewStatus.leftAnchor, constant: 10),
         labelStatus.rightAnchor.constraint(equalTo: viewStatus.rightAnchor, constant: -10),
         labelStatus.bottomAnchor.constraint(equalTo: viewStatus.bottomAnchor, constant: -3)].forEach{$0.isActive = true}
    }
    
    func downloadPoster() {
        guard let url = responseResult?.image else {
            return
        }
        let urlImage = URL(string:url)
        if let imageCeche = imageCeche.object(forKey: urlImage!.absoluteString as NSString) {
            self.posterImageView.image = imageCeche
        } else {
            NetworkService().request(urlString: urlImage!.absoluteString) { [weak self] result in
                switch result {
                case let .success(data):
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self?.posterImageView.image = image
                    }
                case .failure(_):
                    DispatchQueue.main.async {
                        self?.posterImageView.image = UIImage(named:"play.slash")
                    }
                }
            }
        }
    }
}
