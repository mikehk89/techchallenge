//
//  DetailView.swift
//  TechChallenge
//
//  Created by Michael Woodruff on 2/12/2018.
//  Copyright © 2018 Michael Woodruff. All rights reserved.
//

import Foundation
import MapKit
import RxSwift
import UIKit

public class DetailView: UIView {

  private struct Dimensions {
    static let kTopMargin: CGFloat = 20
    static let kLeftMargin: CGFloat = 20
    static let kBackButtonSize: CGSize = CGSize(width: 100, height: 50)
  }

  public var viewModel: DetailViewModel? {
    didSet {
      didUpdate(viewModel: viewModel)
    }
  }

  public lazy var mapView: MKMapView = {
    return MKMapView(frame: .zero)
  }()

  public lazy var backButton: UIButton = {
    let backButton = UIButton(frame: .zero)
    backButton.backgroundColor = .black
    backButton.setTitle("Back", for: .normal)
    backButton.setTitleColor(.white, for: .normal)
    backButton.addTarget(self, action: #selector(tappedBack), for: .touchUpInside)
    return backButton
  }()

  init() {
    super.init(frame: .zero)
    setup()
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public func setup() {
    addSubview(mapView)
    addSubview(backButton)
  }

  public override func layoutSubviews() {
    super.layoutSubviews()
    mapView.frame = bounds
    backButton.frame = CGRect(x: Dimensions.kLeftMargin, y: Dimensions.kTopMargin , width: Dimensions.kBackButtonSize.width, height: Dimensions.kBackButtonSize.height)
  }

  @objc
  private func tappedBack() {
    coordinator.dismiss(animated: true, completion: nil)
  }

  public func didUpdate(viewModel: DetailViewModel?) {

    guard let viewModel = viewModel else { return }

    if let lat = viewModel.location.lat,
      let long = viewModel.location.long,
    let title = viewModel.location.address {
      addAnnotation(title: title,
                    lat: lat,
                    long: long)
      goToLocation(lat: lat,
                   long: long)

    }
  }

  private func addAnnotation(title: String,
                             lat: Double,
                             long: Double) {
    let annotation = MKPointAnnotation()
    annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
    annotation.title = title
    mapView.addAnnotation(annotation)
  }

  private func goToLocation(lat: Double, long: Double) {
    let center = CLLocationCoordinate2D(latitude: lat, longitude: long)
    let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))

    mapView.setRegion(region, animated: true)
  }
}
