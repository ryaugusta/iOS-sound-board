//
//  ViewController.swift
//  soundboard sample
//
//  Created by Ryan Augusta on 8/26/18.
//  Copyright © 2018 Ryan Augusta. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
     //add different quotes for cells
    let quotes = [Quote(name:"Alrighty"),
                  Quote(name: "Go Home!"),
                  Quote(name: "Like a Glove"),
                  Quote(name: "Believe"),
                  Quote(name: "Wanna get High?")]
    
//    let sounds = [Sounds(soundName: "blaster-firing"),
//                 Sounds(soundName: "yodaLaughing")]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.darkGray
        
        navigationItem.title = "Tap to Listen"
        navigationController?.navigationBar.barTintColor = UIColor(red: 0/255, green: 200/255, blue: 255/255, alpha: 1)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20)]
        
        collectionView?.register(SoundBoardCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quotes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SoundBoardCell
        cell.quote = quotes[indexPath.item]
        cell.buttons.tag = indexPath.row
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 1) - 16, height: 100)
    }
    
    private func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insertForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}

class SoundBoardCell: UICollectionViewCell, AVAudioPlayerDelegate {
    
    //var soundName = ["blaster-firing", "yodalaughing"]
    var audio1 = AVAudioPlayer()
    var audio2 = AVAudioPlayer()
    var audio3 = AVAudioPlayer()
    var audio4 = AVAudioPlayer()
    var audio5 = AVAudioPlayer()
    
    var quote: Quote? {
        didSet {
            guard let quoteName = quote?.name else {return}
            buttons.setTitle("\(quoteName)", for: .normal)
        }
    }
//
//    var sound: Sounds? {
//        didSet {
//            guard let soundName = sound?.soundName else {return}
//
//        }
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setCellShadow()
    }

    func setCellShadow() {
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 1.0
        self.layer.masksToBounds = false
        self.clipsToBounds = false
        self.layer.cornerRadius = 3
    }
    
    func setup() {
        self.backgroundColor = UIColor.lightGray
        
        self.addSubview(buttons)

        do {
            let audioPath = Bundle.main.path(forResource: "aallrighty", ofType: "wav")
            try audio1 = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
        } catch {
            //ERROR
        }
        
        do {
            let audioPath = Bundle.main.path(forResource: "gohome", ofType: "wav")
            try audio2 = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
        } catch {
            //ERROR
        }
        
        do {
            let audioPath = Bundle.main.path(forResource: "lkaglove", ofType: "wav")
            try audio3 = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
        } catch {
            //ERROR
        }
        
        do {
            let audioPath = Bundle.main.path(forResource: "110_believe", ofType: "wav")
            try audio4 = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
        } catch {
            //ERROR
        }
        
        do {
            let audioPath = Bundle.main.path(forResource: "towelie_high", ofType: "wav")
            try audio5 = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
        } catch {
            //ERROR
        }

        // button setups
        buttons.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        buttons.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
        
    }
    // button creations
    var buttons: UIButton = {
        let button = UIButton()
        button.tag = 0
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.setTitle("", for: .normal)
        button.setTitleColor(.cyan, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.frame = CGRect(x: 50, y: 50, width: 150, height: 150)
        return button
    }()
    
    @IBAction func buttonClicked(sender: UIButton!) {
        if (sender.tag == 0) {
            audio1.play()

            audio2.stop()
            audio3.stop()
            audio4.stop()
            audio5.stop()
        }

        if (sender.tag == 1)  {
            audio2.play()

            audio1.stop()
            audio3.stop()
            audio4.stop()
            audio5.stop()
        }

        if (sender.tag == 2)  {
            audio3.play()

            audio2.stop()
            audio1.stop()
            audio4.stop()
            audio5.stop()

        }

        if (sender.tag == 3)  {
            audio4.play()

            audio5.stop()
            audio3.stop()
            audio2.stop()
            audio1.stop()

        }

        if (sender.tag == 4)  {
            audio5.play()

            audio4.stop()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct Quote {
    let name: String?
}

//struct Sounds {
//    let soundName: String?
//}

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?,
                right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat,
                width: CGFloat = 0, height: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: paddingRight).isActive = true
        }
        
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.topAnchor
        }
        return topAnchor
    }
    
    var safeLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.leftAnchor
        }
        return leftAnchor
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.bottomAnchor
        }
        return bottomAnchor
    }
    
    var safeRightAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.rightAnchor
        }
        return rightAnchor
    }
}

enum Sounds {
    case one
    case two
    case three
    case four
    case five
}
