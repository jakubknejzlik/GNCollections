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
  s.frameworks = "UIKit"
  s.source_files  = "Core/*.{h,m}"
  s.requires_arc = true
  
  spec.subspec 'AssetsDataSource' do |assets|
    assets.source_files = 'AssetsDataSource/*.{h,m}'
  end
  
  spec.subspec 'FetchedResultsController' do |fetchedResults|
    fetchedResults.source_files = 'FetchedResultsController/*.{h,m}'
  end
  
end
