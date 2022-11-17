//
//  InstallCell.swift
//  testRick
//
//  Created by Андрей Цуркан on 16.11.2022.
//

import UIKit

enum Status: String {
    case alive = "Alive"
    case dead = "Dead"
    case unknow = "unknown"
    
    var text: String {
        switch self{
        case .alive:
          return "ALIVE"
        case .dead:
            return "DEAD"
        case .unknow:
            return "UNKNOWN"
       }
    }
    var backgroundColor: UIColor{
        switch self{
        case.alive:
            return UIColor(red: 199, green: 255, blue: 185)
        case.dead:
            return UIColor(red: 255, green: 232, blue: 224)
        case.unknow:
            return UIColor(red: 238, green: 238, blue: 238)
        }
    }
    var textColor: UIColor{
        switch self{
        case.alive:
            return UIColor(red: 49, green: 159, blue: 22)
        case.dead:
            return UIColor(red:233 , green: 56, blue: 0)
        case.unknow:
            return UIColor(red: 160, green: 160, blue: 160)
        }
    }
}
class InstallCell: UITableViewCell {
    var responseResult: ResponseResult?{
        didSet{
            downloadPoster()
            reloadData()
        }
    }
   
    static var reusedId = "InstallCell"
    var imageViewVector = UIImageView()
    let labelName = UILabel()
    let labelGenderRace = UILabel()
    let labelStatus = UILabel()
    let buttonWatch = UIButton()
    let labelPlanets = UILabel()
    let viewStatus = UIView()
    var networkDataFetcher = NetworkDataFetcher()
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
        installationImageView()
        installationLabelName()
        installationSubData()
        setupButton()
        installationLabelPlanets()
        installationLabelStatus()
        installatioImageViewVector()
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
    func installatioImageViewVector() {
        addSubview(imageViewVector)
        imageViewVector.translatesAutoresizingMaskIntoConstraints = false
        imageViewVector.image = UIImage(named: "Vector")
        
        [imageViewVector.topAnchor.constraint(equalTo: buttonWatch.bottomAnchor, constant: 10),
         imageViewVector.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 8),
         imageViewVector.widthAnchor.constraint(equalToConstant: 10)].forEach{$0.isActive = true}
    }
    
    func installationImageView() {
        addSubview(posterImageView)
        posterImageView.layer.cornerRadius = 40
        [posterImageView.topAnchor.constraint(equalTo: topAnchor,constant: 20),
         posterImageView.leftAnchor.constraint(equalTo: leftAnchor,constant: 10),
         posterImageView.heightAnchor.constraint(equalToConstant: 120),
         posterImageView.widthAnchor.constraint(equalToConstant: 120)].forEach{$0.isActive = true}
    }
    
    func installationLabelName() {
        addSubview(labelName)
        labelName.font = UIFont.systemFont(ofSize: 21)
        
        labelName.translatesAutoresizingMaskIntoConstraints = false
        [labelName.topAnchor.constraint(equalTo: topAnchor, constant: 20),
         labelName.leftAnchor.constraint(equalTo:posterImageView.rightAnchor,constant: 8),
         labelName.widthAnchor.constraint(equalToConstant: 180),
         labelName.heightAnchor.constraint(equalToConstant: 25)].forEach{$0.isActive = true}
    }
    func installationSubData() {
        addSubview(labelGenderRace)
        labelGenderRace.font = UIFont.systemFont(ofSize: 14)
        
        labelGenderRace.translatesAutoresizingMaskIntoConstraints = false
        [labelGenderRace.topAnchor.constraint(equalTo: labelName.bottomAnchor,constant: 5),
         labelGenderRace.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 8),
         labelGenderRace.heightAnchor.constraint(equalToConstant: 17)].forEach{$0.isActive = true}
    }
    
    func setupButton() {
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
    
    func installationLabelPlanets() {
        addSubview(labelPlanets)
        labelPlanets.translatesAutoresizingMaskIntoConstraints = false
        labelPlanets.font = UIFont.systemFont(ofSize: 14)
        
        [labelPlanets.topAnchor.constraint(equalTo: buttonWatch.bottomAnchor,constant: 8),
         labelPlanets.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 25),
         labelPlanets.heightAnchor.constraint(equalToConstant: 17)].forEach{$0.isActive = true}
    }
    
    func installationLabelStatus() {
        addSubview(viewStatus)
        viewStatus.addSubview(labelStatus)
        viewStatus.translatesAutoresizingMaskIntoConstraints = false
        labelStatus.translatesAutoresizingMaskIntoConstraints = false
        viewStatus.layer.cornerRadius = 10
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
            NetworkService().request(urlString: urlImage!.absoluteString) { [weak self] result in
            switch result {
            case let .success(data):
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self?.posterImageView.image = image
                }
            case let .failure(error):
                print(error)
                DispatchQueue.main.async {
                    self?.posterImageView.image = UIImage(named:"play.slash")
                }
            }
        }
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255)
        assert(green >= 0 && green <= 255)
        assert(blue >= 0 && blue <= 255)
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
