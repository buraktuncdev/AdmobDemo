//
//  ViewController.swift
//  AdmobDemo
//
//  Created by Burak Tunc on 18.01.21.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController {
      
    @IBOutlet weak var bannerView: GADBannerView!
    
    var interstitial:GADInterstitial!
    var rewardedAd: GADRewardedAd!
    
    private let bannerTestId = "ca-app-pub-3940256099942544/2934735716"
    private let interstitialId = "ca-app-pub-3940256099942544/4411468910"
    private let rewardId = "ca-app-pub-3940256099942544/1712485313"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBanner()
        interstitial = interstitialLoad()
        configureRewaredAd()
    }
    
}

// MARK: Configure Ads
extension ViewController {
    
    @IBAction func interstitialButtonPressed(_ sender: Any) {
        if interstitial.isReady{
            interstitial.present(fromRootViewController: self)
        }else {
            print("Ad is not prepared...")
        }
    }
    
    @IBAction func rewardButtonPressed(_ sender: Any) {
        if rewardedAd.isReady{
            rewardedAd.present(fromRootViewController: self, delegate: self)
        } else {
            print("Ad is not prepared...")
        }
    }
    
    func configureRewaredAd() {
        rewardedAd = GADRewardedAd(adUnitID: rewardId)
        rewardedAd.load(GADRequest())
    }
    
    func interstitialLoad() -> GADInterstitial {
        interstitial = GADInterstitial(adUnitID: interstitialId)
        interstitial.load(GADRequest())
        interstitial.delegate = self
        return interstitial
    }
    
    func configureBanner(){
        bannerView.adUnitID = bannerTestId
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
    }
}

// MARK: GADBannerViewDelegate
extension ViewController: GADBannerViewDelegate {
    
    // when received ad
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
    }
    
    // when error occured
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print("didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    // when will leave app
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
        bannerView.isHidden = true
    }
    
}

// MARK: GADInterstitialDelegate
extension ViewController: GADInterstitialDelegate{
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        print("didFailToReceiveAdWithError \(error.localizedDescription)")
    }
    
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        print("interstitialWillPresentScreen")
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        print("interstitialDidDismissScreen")
        interstitial = interstitialLoad()
    }
    
}

extension ViewController: GADRewardedAdDelegate {
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        print("user Did Earn")
    }
    
    func rewardedAd(_ rewardedAd: GADRewardedAd, didFailToPresentWithError error: Error) {
        print("didFailToPresentWithError \(error.localizedDescription)")
    }
    
    func rewardedAdDidPresent(_ rewardedAd: GADRewardedAd) {
        print("rewardedAdDidPresent")
    }
    
    func rewardedAdDidDismiss(_ rewardedAd: GADRewardedAd) {
        print("rewardedAdDidDismiss")
        configureRewaredAd()
    }
}
