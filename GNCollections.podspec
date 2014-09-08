#
#  Be sure to run `pod spec lint GNCollections.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "GNCollections"
  s.version      = "0.0.1"
  s.summary      = "Easy collection (UITableView/UICollectionView) handling"

  s.description  = <<-DESC
                   Set of classes for handling [Collection/Table]Views and their datasources/delegates.
                   DESC
                   
  s.homepage     = "https://github.com/jakubknejzlik/GNCollections"
  s.license      = { :type => "MIT", :file => "LICENSE" }


  s.author             = { "Jakub Knejzlik" => "jakub.knejzlik@gmail.com" }
  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/jakubknejzlik/GNCollections.git", :tag => "0.0.1" }
  s.requires_arc = true
  
  s.subspec "Core" do |ss|
    ss.source_files = "GNCollections/AssetsDataSource/*.{h,m}"
	ss.frameworks = "UIKit"
	ss.source_files  = "GNCollections/Core/*.{h,m}"
  end
  
  s.subspec "AssetsDataSource" do |ss|
    ss.dependency "GNCollections/Core"
	ss.frameworks = "MapKit","ImageIO"
    ss.source_files = "GNCollections/AssetsDataSource/*.{h,m}"
  end
  
  s.subspec "FetchedResultsController" do |ss|
    ss.dependency "GNCollections/Core"
	ss.frameworks = "CoreData"
    ss.source_files = "GNCollections/FetchedResultsController/*.{h,m}"
  end
  
end
