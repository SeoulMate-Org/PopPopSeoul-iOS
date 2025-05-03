// swiftlint:disable identifier_name
// swiftlint:disable inclusive_language

//
//  String+Language.swift
//  Common
//
//  Created by suni on 3/31/25.
//

import Foundation
import SwiftUI

public extension String {
  var localized: String {
    guard let lang = LocalizationManager.provider?.currentLanguage else {
      return NSLocalizedString(self, comment: "")
    }
    return localized(language: lang)
  }
  
  private func localized(language: String) -> String {
    guard let path = Bundle.main.path(forResource: language, ofType: "lproj"),
          let bundle = Bundle(path: path)
    else {
      return NSLocalizedString(self, comment: "")
    }
    return NSLocalizedString(self, bundle: bundle, comment: "")
  }
  
  init(sLocalization key: LocalizationsKey) {
    self = key.rawValue.localized
  }
  
  init(sLocalization key: LocalizedKey) {
    self = key.rawValue.localized
  }
  
  func localizedFormat(_ args: CVarArg...) -> String {
    String(format: NSLocalizedString(self, comment: ""), arguments: args)
  }
  
  func localizedFormat(arguments: [CVarArg]) -> String {
    String(format: NSLocalizedString(self, comment: ""), arguments: arguments)
  }
}
public extension L10n {
  static func localized(_ key: LocalizedKey) -> String {
    String(sLocalization: key).localized
//    NSLocalizedString(key.rawValue, comment: "")
  }
  
  static func localized(_ key: LocalizedKey, _ args: [CVarArg]) -> String {
    String(sLocalization: key).localizedFormat(args)
//    String(format: NSLocalizedString(key.rawValue, comment: ""), arguments: args)
  }
}

public enum L10n {
  public static var alarmListText_location: String { localized(.alarmListText_location) }
  public static var alarmListText_vibration: String { localized(.alarmListText_vibration) }
  public static var alertContent_deleteAccount: String { localized(.alertContent_deleteAccount) }
  public static var alertContent_locationAccess: String { localized(.alertContent_locationAccess) }
  public static var alertContent_login: String { localized(.alertContent_login) }
  public static var alertContent_loginContinue: String { localized(.alertContent_loginContinue) }
  public static var alertContent_logout: String { localized(.alertContent_logout) }
  public static var alertContent_notRestored: String { localized(.alertContent_notRestored) }
  public static var alertContent_quitChallenge: String { localized(.alertContent_quitChallenge) }
  public static var alertTitle_delete: String { localized(.alertTitle_delete) }
  public static var alertTitle_deleteAccount: String { localized(.alertTitle_deleteAccount) }
  public static var alertTitle_locationAccess: String { localized(.alertTitle_locationAccess) }
  public static var alertTitle_login: String { localized(.alertTitle_login) }
  public static var alertTitle_logout: String { localized(.alertTitle_logout) }
  public static var alertTitle_quitChallenge: String { localized(.alertTitle_quitChallenge) }
  public static var alertTitle_sessionExpired: String { localized(.alertTitle_sessionExpired) }
  public static var banner_allowLocation: String { localized(.banner_allowLocation) }
  public static var banner_collectStamp: String { localized(.banner_collectStamp) }
  public static var banner_nearby: String { localized(.banner_nearby) }
  public static var banner_signIn: String { localized(.banner_signIn) }
  public static var banner_signUp: String { localized(.banner_signUp) }
  public static var buttonText_changeLanguage: String { localized(.buttonText_changeLanguage) }
  public static var buttonText_loginAgain: String { localized(.buttonText_loginAgain) }
  public static var buttonText_logout: String { localized(.buttonText_logout) }
  public static var buttonText_refresh: String { localized(.buttonText_refresh) }
  public static var categoryName_art: String { localized(.categoryName_art) }
  public static var categoryName_culturalEvent: String { localized(.categoryName_culturalEvent) }
  public static var categoryName_foodie: String { localized(.categoryName_foodie) }
  public static var categoryName_history: String { localized(.categoryName_history) }
  public static var categoryName_local: String { localized(.categoryName_local) }
  public static var categoryName_mustSeeSpots: String { localized(.categoryName_mustSeeSpots) }
  public static var categoryName_nightViews: String { localized(.categoryName_nightViews) }
  public static var categoryName_photoSpots: String { localized(.categoryName_photoSpots) }
  public static var categoryName_walkingTours: String { localized(.categoryName_walkingTours) }
  public static var commentFormText_enter: String { localized(.commentFormText_enter) }
  public static var commentToastText_deleted: String { localized(.commentToastText_deleted) }
  public static var commentToastText_restored: String { localized(.commentToastText_restored) }
  public static var detailBadgeSubText_complete: String { localized(.detailBadgeSubText_complete) }
  public static var detailBadgeTitle_congrats: String { localized(.detailBadgeTitle_congrats) }
  public static var detailChallengeCommentText: String { localized(.detailChallengeCommentText) }
  public static var detailChallengeFloatText: String { localized(.detailChallengeFloatText) }
  public static var detailChallengeSubText_checkStamp: String { localized(.detailChallengeSubText_checkStamp) }
  public static var detailChallengeSubText_getStamp: String { localized(.detailChallengeSubText_getStamp) }
  public static var detailChallengeSubText_stampMission: String { localized(.detailChallengeSubText_stampMission) }
  public static var detailChallengeText_missionSpots: String { localized(.detailChallengeText_missionSpots) }
  public static var detailChallengeText_stamp: String { localized(.detailChallengeText_stamp) }
  public static var detailchallengeTitle_eventsMission: String { localized(.detailchallengeTitle_eventsMission) }
  public static var detaillanguageRadio_english: String { localized(.detaillanguageRadio_english) }
  public static var detaillanguageRadio_korean: String { localized(.detaillanguageRadio_korean) }
  public static var detaillanguageTitle: String { localized(.detaillanguageTitle) }
  public static var detailmenuItem_changeNickname: String { localized(.detailmenuItem_changeNickname) }
  public static var detailmenuItem_comment: String { localized(.detailmenuItem_comment) }
  public static var detailmenuItem_deleteAccount: String { localized(.detailmenuItem_deleteAccount) }
  public static var detailmenuItem_myBadge: String { localized(.detailmenuItem_myBadge) }
  public static var detailmenuItem_themeChallenge: String { localized(.detailmenuItem_themeChallenge) }
  public static var detailnicknameSubText: String { localized(.detailnicknameSubText) }
  public static var detailnicknameText_enter: String { localized(.detailnicknameText_enter) }
  public static var footer_home: String { localized(.footer_home) }
  public static var footer_my: String { localized(.footer_my) }
  public static var footer_mychallenge: String { localized(.footer_mychallenge) }
  public static var heartButton: String { localized(.heartButton) }
  public static var homeBackGroundText_event: String { localized(.homeBackGroundText_event) }
  public static var homeBackGroundText_jonggak: String { localized(.homeBackGroundText_jonggak) }
  public static var homeBackGroundText_keepGoing: String { localized(.homeBackGroundText_keepGoing) }
  public static var homeBackGroundText_lightChallenge: String { localized(.homeBackGroundText_lightChallenge) }
  public static var homeBackGroundText_missed: String { localized(.homeBackGroundText_missed) }
  public static var homeBackGroundText_mostPopular: String { localized(.homeBackGroundText_mostPopular) }
  public static var homeBackGroundText_nearby: String { localized(.homeBackGroundText_nearby) }
  public static var homeBackGroundText_ranking: String { localized(.homeBackGroundText_ranking) }
  public static var homeBackGroundText_recently: String { localized(.homeBackGroundText_recently) }
  public static var homeBackGroundText_seoulMaster: String { localized(.homeBackGroundText_seoulMaster) }
  public static var homeBackGroundText_similar: String { localized(.homeBackGroundText_similar) }
  public static var homeBackGroundText_startChallenge: String { localized(.homeBackGroundText_startChallenge) }
  public static var homeBackGroundText_theme: String { localized(.homeBackGroundText_theme) }
  public static var homelistText_joined: String { localized(.homelistText_joined) }
  public static var JJIMtoastText_removed: String { localized(.JJIMtoastText_removed) }
  public static var myBadgeContent_ready: String { localized(.myBadgeContent_ready) }
  public static var myBadgeTitle_moreCloser: String { localized(.myBadgeTitle_moreCloser) }
  public static var mybuttonText_badge: String { localized(.mybuttonText_badge) }
  public static var mybuttonText_JJIMSpots: String { localized(.mybuttonText_JJIMSpots) }
  public static var mybuttonText_myComments: String { localized(.mybuttonText_myComments) }
  public static var myCommentSub_joinChallenge: String { localized(.myCommentSub_joinChallenge) }
  public static var myCommentText_no: String { localized(.myCommentText_no) }
  public static var myJJIMContent_addMore: String { localized(.myJJIMContent_addMore) }
  public static var myJJIMContent_havenot: String { localized(.myJJIMContent_havenot) }
  public static var myJJIMSubText_havenot: String { localized(.myJJIMSubText_havenot) }
  public static var myJJIMSubText_total: String { localized(.myJJIMSubText_total) }
  public static var myJJIMTitle_havenot: String { localized(.myJJIMTitle_havenot) }
  public static var myListButtonText_deleteAccount: String { localized(.myListButtonText_deleteAccount) }
  public static var myListButtonText_korean: String { localized(.myListButtonText_korean) }
  public static var myListButtonText_logout: String { localized(.myListButtonText_logout) }
  public static var myListText_aboutService: String { localized(.myListText_aboutService) }
  public static var myListText_FAQ: String { localized(.myListText_FAQ) }
  public static var myListText_language: String { localized(.myListText_language) }
  public static var myListText_locationAccess: String { localized(.myListText_locationAccess) }
  public static var myListText_locationAgree: String { localized(.myListText_locationAgree) }
  public static var myListText_notifications: String { localized(.myListText_notifications) }
  public static var myListText_privacyPolicy: String { localized(.myListText_privacyPolicy) }
  public static var myListText_termsService: String { localized(.myListText_termsService) }
  public static var myListText_version: String { localized(.myListText_version) }
  public static var mySubText_JJIMBadge: String { localized(.mySubText_JJIMBadge) }
  public static var myTapButtonText_completed: String { localized(.myTapButtonText_completed) }
  public static var myTapButtonText_jjim: String { localized(.myTapButtonText_jjim) }
  public static var myTapButtonText_onIt: String { localized(.myTapButtonText_onIt) }
  public static var popupTitle_stampComplete: String { localized(.popupTitle_stampComplete) }
  public static var reviewSubButton_delete: String { localized(.reviewSubButton_delete) }
  public static var reviewSubButton_edit: String { localized(.reviewSubButton_edit) }
  public static var subButton_more: String { localized(.subButton_more) }
  public static var subText_away: String { localized(.subText_away) }
  public static var subText_closed: String { localized(.subText_closed) }
  public static var subText_hotSport: String { localized(.subText_hotSport) }
  public static var textButton_browse: String { localized(.textButton_browse) }
  public static var textButton_cancel: String { localized(.textButton_cancel) }
  public static var textButton_copy: String { localized(.textButton_copy) }
  public static var textButton_copyAddress: String { localized(.textButton_copyAddress) }
  public static var textButton_deleteAccount: String { localized(.textButton_deleteAccount) }
  public static var textButton_goToSetting: String { localized(.textButton_goToSetting) }
  public static var textButton_later: String { localized(.textButton_later) }
  public static var textButton_leaveChallenge: String { localized(.textButton_leaveChallenge) }
  public static var textButton_login: String { localized(.textButton_login) }
  public static var textButton_loginStamp: String { localized(.textButton_loginStamp) }
  public static var textButton_quit: String { localized(.textButton_quit) }
  public static var textButton_restore: String { localized(.textButton_restore) }
  public static var textButton_startChallenge: String { localized(.textButton_startChallenge) }
  public static var textButton_viewDetails: String { localized(.textButton_viewDetails) }
  public static var textButton_viewMyBadge: String { localized(.textButton_viewMyBadge) }
  public static var textButton_viewNaverMap: String { localized(.textButton_viewNaverMap) }
  public static var textButton_viewOnMap: String { localized(.textButton_viewOnMap) }
  public static var themeDetailText_comingSoon: String { localized(.themeDetailText_comingSoon) }
  public static var toastText_copied: String { localized(.toastText_copied) }
  public static var toastText_removedJJIM: String { localized(.toastText_removedJJIM) }
  public static var withdrawexplanation_description_1: String { localized(.withdrawexplanation_description_1) }
  public static var withdrawexplanation_description_2: String { localized(.withdrawexplanation_description_2) }
  public static var withdrawexplanation_description_3: String { localized(.withdrawexplanation_description_3) }
  public static var withdrawexplanation_shareyour: String { localized(.withdrawexplanation_shareyour) }
  public static var withdrawexplanation_thankyou: String { localized(.withdrawexplanation_thankyou) }
  public static var withdrawNote: String { localized(.withdrawNote) }
  
  public static func alarmListText_location(_ args: CVarArg...) -> String { localized(.alarmListText_location, args) }
  public static func alarmListText_vibration(_ args: CVarArg...) -> String { localized(.alarmListText_vibration, args) }
  public static func alertContent_deleteAccount(_ args: CVarArg...) -> String { localized(.alertContent_deleteAccount, args) }
  public static func alertContent_locationAccess(_ args: CVarArg...) -> String { localized(.alertContent_locationAccess, args) }
  public static func alertContent_login(_ args: CVarArg...) -> String { localized(.alertContent_login, args) }
  public static func alertContent_loginContinue(_ args: CVarArg...) -> String { localized(.alertContent_loginContinue, args) }
  public static func alertContent_logout(_ args: CVarArg...) -> String { localized(.alertContent_logout, args) }
  public static func alertContent_notRestored(_ args: CVarArg...) -> String { localized(.alertContent_notRestored, args) }
  public static func alertContent_quitChallenge(_ args: CVarArg...) -> String { localized(.alertContent_quitChallenge, args) }
  public static func alertTitle_delete(_ args: CVarArg...) -> String { localized(.alertTitle_delete, args) }
  public static func alertTitle_deleteAccount(_ args: CVarArg...) -> String { localized(.alertTitle_deleteAccount, args) }
  public static func alertTitle_locationAccess(_ args: CVarArg...) -> String { localized(.alertTitle_locationAccess, args) }
  public static func alertTitle_login(_ args: CVarArg...) -> String { localized(.alertTitle_login, args) }
  public static func alertTitle_logout(_ args: CVarArg...) -> String { localized(.alertTitle_logout, args) }
  public static func alertTitle_quitChallenge(_ args: CVarArg...) -> String { localized(.alertTitle_quitChallenge, args) }
  public static func alertTitle_sessionExpired(_ args: CVarArg...) -> String { localized(.alertTitle_sessionExpired, args) }
  public static func banner_allowLocation(_ args: CVarArg...) -> String { localized(.banner_allowLocation, args) }
  public static func banner_collectStamp(_ args: CVarArg...) -> String { localized(.banner_collectStamp, args) }
  public static func banner_nearby(_ args: CVarArg...) -> String { localized(.banner_nearby, args) }
  public static func banner_signIn(_ args: CVarArg...) -> String { localized(.banner_signIn, args) }
  public static func banner_signUp(_ args: CVarArg...) -> String { localized(.banner_signUp, args) }
  public static func buttonText_changeLanguage(_ args: CVarArg...) -> String { localized(.buttonText_changeLanguage, args) }
  public static func buttonText_loginAgain(_ args: CVarArg...) -> String { localized(.buttonText_loginAgain, args) }
  public static func buttonText_logout(_ args: CVarArg...) -> String { localized(.buttonText_logout, args) }
  public static func buttonText_refresh(_ args: CVarArg...) -> String { localized(.buttonText_refresh, args) }
  public static func categoryName_art(_ args: CVarArg...) -> String { localized(.categoryName_art, args) }
  public static func categoryName_culturalEvent(_ args: CVarArg...) -> String { localized(.categoryName_culturalEvent, args) }
  public static func categoryName_foodie(_ args: CVarArg...) -> String { localized(.categoryName_foodie, args) }
  public static func categoryName_history(_ args: CVarArg...) -> String { localized(.categoryName_history, args) }
  public static func categoryName_local(_ args: CVarArg...) -> String { localized(.categoryName_local, args) }
  public static func categoryName_mustSeeSpots(_ args: CVarArg...) -> String { localized(.categoryName_mustSeeSpots, args) }
  public static func categoryName_nightViews(_ args: CVarArg...) -> String { localized(.categoryName_nightViews, args) }
  public static func categoryName_photoSpots(_ args: CVarArg...) -> String { localized(.categoryName_photoSpots, args) }
  public static func categoryName_walkingTours(_ args: CVarArg...) -> String { localized(.categoryName_walkingTours, args) }
  public static func commentFormText_enter(_ args: CVarArg...) -> String { localized(.commentFormText_enter, args) }
  public static func commentToastText_deleted(_ args: CVarArg...) -> String { localized(.commentToastText_deleted, args) }
  public static func commentToastText_restored(_ args: CVarArg...) -> String { localized(.commentToastText_restored, args) }
  public static func detailBadgeSubText_complete(_ args: CVarArg...) -> String { localized(.detailBadgeSubText_complete, args) }
  public static func detailBadgeTitle_congrats(_ args: CVarArg...) -> String { localized(.detailBadgeTitle_congrats, args) }
  public static func detailChallengeCommentText(_ args: CVarArg...) -> String { localized(.detailChallengeCommentText, args) }
  public static func detailChallengeFloatText(_ args: CVarArg...) -> String { localized(.detailChallengeFloatText, args) }
  public static func detailChallengeSubText_checkStamp(_ args: CVarArg...) -> String { localized(.detailChallengeSubText_checkStamp, args) }
  public static func detailChallengeSubText_getStamp(_ args: CVarArg...) -> String { localized(.detailChallengeSubText_getStamp, args) }
  public static func detailChallengeSubText_stampMission(_ args: CVarArg...) -> String { localized(.detailChallengeSubText_stampMission, args) }
  public static func detailChallengeText_missionSpots(_ args: CVarArg...) -> String { localized(.detailChallengeText_missionSpots, args) }
  public static func detailChallengeText_stamp(_ args: CVarArg...) -> String { localized(.detailChallengeText_stamp, args) }
  public static func detailchallengeTitle_eventsMission(_ args: CVarArg...) -> String { localized(.detailchallengeTitle_eventsMission, args) }
  public static func detaillanguageRadio_english(_ args: CVarArg...) -> String { localized(.detaillanguageRadio_english, args) }
  public static func detaillanguageRadio_korean(_ args: CVarArg...) -> String { localized(.detaillanguageRadio_korean, args) }
  public static func detaillanguageTitle(_ args: CVarArg...) -> String { localized(.detaillanguageTitle, args) }
  public static func detailmenuItem_changeNickname(_ args: CVarArg...) -> String { localized(.detailmenuItem_changeNickname, args) }
  public static func detailmenuItem_comment(_ args: CVarArg...) -> String { localized(.detailmenuItem_comment, args) }
  public static func detailmenuItem_deleteAccount(_ args: CVarArg...) -> String { localized(.detailmenuItem_deleteAccount, args) }
  public static func detailmenuItem_myBadge(_ args: CVarArg...) -> String { localized(.detailmenuItem_myBadge, args) }
  public static func detailmenuItem_themeChallenge(_ args: CVarArg...) -> String { localized(.detailmenuItem_themeChallenge, args) }
  public static func detailnicknameSubText(_ args: CVarArg...) -> String { localized(.detailnicknameSubText, args) }
  public static func detailnicknameText_enter(_ args: CVarArg...) -> String { localized(.detailnicknameText_enter, args) }
  public static func footer_home(_ args: CVarArg...) -> String { localized(.footer_home, args) }
  public static func footer_my(_ args: CVarArg...) -> String { localized(.footer_my, args) }
  public static func footer_mychallenge(_ args: CVarArg...) -> String { localized(.footer_mychallenge, args) }
  public static func heartButton(_ args: CVarArg...) -> String { localized(.heartButton, args) }
  public static func homeBackGroundText_event(_ args: CVarArg...) -> String { localized(.homeBackGroundText_event, args) }
  public static func homeBackGroundText_jonggak(_ args: CVarArg...) -> String { localized(.homeBackGroundText_jonggak, args) }
  public static func homeBackGroundText_keepGoing(_ args: CVarArg...) -> String { localized(.homeBackGroundText_keepGoing, args) }
  public static func homeBackGroundText_lightChallenge(_ args: CVarArg...) -> String { localized(.homeBackGroundText_lightChallenge, args) }
  public static func homeBackGroundText_missed(_ args: CVarArg...) -> String { localized(.homeBackGroundText_missed, args) }
  public static func homeBackGroundText_mostPopular(_ args: CVarArg...) -> String { localized(.homeBackGroundText_mostPopular, args) }
  public static func homeBackGroundText_nearby(_ args: CVarArg...) -> String { localized(.homeBackGroundText_nearby, args) }
  public static func homeBackGroundText_ranking(_ args: CVarArg...) -> String { localized(.homeBackGroundText_ranking, args) }
  public static func homeBackGroundText_recently(_ args: CVarArg...) -> String { localized(.homeBackGroundText_recently, args) }
  public static func homeBackGroundText_seoulMaster(_ args: CVarArg...) -> String { localized(.homeBackGroundText_seoulMaster, args) }
  public static func homeBackGroundText_similar(_ args: CVarArg...) -> String { localized(.homeBackGroundText_similar, args) }
  public static func homeBackGroundText_startChallenge(_ args: CVarArg...) -> String { localized(.homeBackGroundText_startChallenge, args) }
  public static func homeBackGroundText_theme(_ args: CVarArg...) -> String { localized(.homeBackGroundText_theme, args) }
  public static func homelistText_joined(_ args: CVarArg...) -> String { localized(.homelistText_joined, args) }
  public static func JJIMtoastText_removed(_ args: CVarArg...) -> String { localized(.JJIMtoastText_removed, args) }
  public static func myBadgeContent_ready(_ args: CVarArg...) -> String { localized(.myBadgeContent_ready, args) }
  public static func myBadgeTitle_moreCloser(_ args: CVarArg...) -> String { localized(.myBadgeTitle_moreCloser, args) }
  public static func mybuttonText_badge(_ args: CVarArg...) -> String { localized(.mybuttonText_badge, args) }
  public static func mybuttonText_JJIMSpots(_ args: CVarArg...) -> String { localized(.mybuttonText_JJIMSpots, args) }
  public static func mybuttonText_myComments(_ args: CVarArg...) -> String { localized(.mybuttonText_myComments, args) }
  public static func myCommentSub_joinChallenge(_ args: CVarArg...) -> String { localized(.myCommentSub_joinChallenge, args) }
  public static func myCommentText_no(_ args: CVarArg...) -> String { localized(.myCommentText_no, args) }
  public static func myJJIMContent_addMore(_ args: CVarArg...) -> String { localized(.myJJIMContent_addMore, args) }
  public static func myJJIMContent_havenot(_ args: CVarArg...) -> String { localized(.myJJIMContent_havenot, args) }
  public static func myJJIMSubText_havenot(_ args: CVarArg...) -> String { localized(.myJJIMSubText_havenot, args) }
  public static func myJJIMSubText_total(_ args: CVarArg...) -> String { localized(.myJJIMSubText_total, args) }
  public static func myJJIMTitle_havenot(_ args: CVarArg...) -> String { localized(.myJJIMTitle_havenot, args) }
  public static func myListButtonText_deleteAccount(_ args: CVarArg...) -> String { localized(.myListButtonText_deleteAccount, args) }
  public static func myListButtonText_korean(_ args: CVarArg...) -> String { localized(.myListButtonText_korean, args) }
  public static func myListButtonText_logout(_ args: CVarArg...) -> String { localized(.myListButtonText_logout, args) }
  public static func myListText_aboutService(_ args: CVarArg...) -> String { localized(.myListText_aboutService, args) }
  public static func myListText_FAQ(_ args: CVarArg...) -> String { localized(.myListText_FAQ, args) }
  public static func myListText_language(_ args: CVarArg...) -> String { localized(.myListText_language, args) }
  public static func myListText_locationAccess(_ args: CVarArg...) -> String { localized(.myListText_locationAccess, args) }
  public static func myListText_locationAgree(_ args: CVarArg...) -> String { localized(.myListText_locationAgree, args) }
  public static func myListText_notifications(_ args: CVarArg...) -> String { localized(.myListText_notifications, args) }
  public static func myListText_privacyPolicy(_ args: CVarArg...) -> String { localized(.myListText_privacyPolicy, args) }
  public static func myListText_termsService(_ args: CVarArg...) -> String { localized(.myListText_termsService, args) }
  public static func myListText_version(_ args: CVarArg...) -> String { localized(.myListText_version, args) }
  public static func mySubText_JJIMBadge(_ args: CVarArg...) -> String { localized(.mySubText_JJIMBadge, args) }
  public static func myTapButtonText_completed(_ args: CVarArg...) -> String { localized(.myTapButtonText_completed, args) }
  public static func myTapButtonText_jjim(_ args: CVarArg...) -> String { localized(.myTapButtonText_jjim, args) }
  public static func myTapButtonText_onIt(_ args: CVarArg...) -> String { localized(.myTapButtonText_onIt, args) }
  public static func popupTitle_stampComplete(_ args: CVarArg...) -> String { localized(.popupTitle_stampComplete, args) }
  public static func reviewSubButton_delete(_ args: CVarArg...) -> String { localized(.reviewSubButton_delete, args) }
  public static func reviewSubButton_edit(_ args: CVarArg...) -> String { localized(.reviewSubButton_edit, args) }
  public static func subButton_more(_ args: CVarArg...) -> String { localized(.subButton_more, args) }
  public static func subText_away(_ args: CVarArg...) -> String { localized(.subText_away, args) }
  public static func subText_closed(_ args: CVarArg...) -> String { localized(.subText_closed, args) }
  public static func subText_hotSport(_ args: CVarArg...) -> String { localized(.subText_hotSport, args) }
  public static func textButton_browse(_ args: CVarArg...) -> String { localized(.textButton_browse, args) }
  public static func textButton_cancel(_ args: CVarArg...) -> String { localized(.textButton_cancel, args) }
  public static func textButton_copy(_ args: CVarArg...) -> String { localized(.textButton_copy, args) }
  public static func textButton_copyAddress(_ args: CVarArg...) -> String { localized(.textButton_copyAddress, args) }
  public static func textButton_deleteAccount(_ args: CVarArg...) -> String { localized(.textButton_deleteAccount, args) }
  public static func textButton_goToSetting(_ args: CVarArg...) -> String { localized(.textButton_goToSetting, args) }
  public static func textButton_later(_ args: CVarArg...) -> String { localized(.textButton_later, args) }
  public static func textButton_leaveChallenge(_ args: CVarArg...) -> String { localized(.textButton_leaveChallenge, args) }
  public static func textButton_login(_ args: CVarArg...) -> String { localized(.textButton_login, args) }
  public static func textButton_loginStamp(_ args: CVarArg...) -> String { localized(.textButton_loginStamp, args) }
  public static func textButton_quit(_ args: CVarArg...) -> String { localized(.textButton_quit, args) }
  public static func textButton_restore(_ args: CVarArg...) -> String { localized(.textButton_restore, args) }
  public static func textButton_startChallenge(_ args: CVarArg...) -> String { localized(.textButton_startChallenge, args) }
  public static func textButton_viewDetails(_ args: CVarArg...) -> String { localized(.textButton_viewDetails, args) }
  public static func textButton_viewMyBadge(_ args: CVarArg...) -> String { localized(.textButton_viewMyBadge, args) }
  public static func textButton_viewNaverMap(_ args: CVarArg...) -> String { localized(.textButton_viewNaverMap, args) }
  public static func textButton_viewOnMap(_ args: CVarArg...) -> String { localized(.textButton_viewOnMap, args) }
  public static func themeDetailText_comingSoon(_ args: CVarArg...) -> String { localized(.themeDetailText_comingSoon, args) }
  public static func toastText_copied(_ args: CVarArg...) -> String { localized(.toastText_copied, args) }
  public static func toastText_removedJJIM(_ args: CVarArg...) -> String { localized(.toastText_removedJJIM, args) }
  public static func withdrawexplanation_description_1(_ args: CVarArg...) -> String { localized(.withdrawexplanation_description_1, args) }
  public static func withdrawexplanation_description_2(_ args: CVarArg...) -> String { localized(.withdrawexplanation_description_2, args) }
  public static func withdrawexplanation_description_3(_ args: CVarArg...) -> String { localized(.withdrawexplanation_description_3, args) }
  public static func withdrawexplanation_shareyour(_ args: CVarArg...) -> String { localized(.withdrawexplanation_shareyour, args) }
  public static func withdrawexplanation_thankyou(_ args: CVarArg...) -> String { localized(.withdrawexplanation_thankyou, args) }
  public static func withdrawNote(_ args: CVarArg...) -> String { localized(.withdrawNote, args) }
}

// MARK: - lagacy
public enum LocalizationsKey: String {
  case tabProfile = "tab_profile"
  case tabMychallenge = "tab_mychallenge"
  case tabHome = "tab_home"
  case mychallengeInterestTitle = "mychallenge_interest_title"
  case mychallengeInterestEmptyTitle = "mychallenge_interest_empty_title"
  case mychallengeInterestEmptyDes = "mychallenge_interest_empty_des"
  case mychallengeInterestEmptyButton = "mychallenge_interest_empty_button"
  case mychallengeInprogressTitle = "mychallenge_inprogress_title"
  case mychallengeHeaderTitle = "mychallenge_header_title"
  case mychallengeCompletedTitle = "mychallenge_completed_title"
  case mychallengeInterestDeleteToast = "mychallenge_interest_delete_toast"
  case toastButtonRestoration = "toast_button_restoration"
  case mychallengeProgressEmptyButton = "mychallenge_progress_empty_button"
  case mychallengeProgressEmptyTitle = "mychallenge_progress_empty_title"
  case mychallengeProgressEmptyDes = "mychallenge_progress_empty_des"
  case mychallengeCompletedEmptyTitle = "mychallenge_completed_empty_title"
  case mychallengeCompletedEmptyDes = "mychallenge_completed_empty_des"
  case detailchallengeCommentButton = "detailchallenge_comment_button"
  case detailchallengeCommentTitle = "detailchallenge_comment_title"
  case detailchallengeInterestButton = "detailchallenge_interest_button"
  case detailchallengeLoginButton = "detailchallenge_login_button"
  case detailchallengeMapButton = "detailchallenge_map_button"
  case detailchallengePlaceDes = "detailchallenge_place_des"
  case detailchallengePlaceTitle = "detailchallenge_place_title"
  case detailchallengeStampDes = "detailchallenge_stamp_des"
  case detailchallengeStampTitle = "detailchallenge_stamp_title"
  case detailchallengeStartButton = "detailchallenge_start_button"
  case mychallengeTotal = "mychallenge_total"
  case placeDistance = "place_distance"
  case detailchallengeCommentDes = "detailchallenge_comment_des"
  case detailchallengeEndButton = "detailchallenge_end_button"
  case detailchallengeStampButton = "detailchallenge_stamp_button"
  case detailchallengeFloatingText = "detailchallenge_floating_text"
}

public enum LocalizedKey: String {
  case alarmListText_location
  case alarmListText_vibration
  case alertContent_deleteAccount
  case alertContent_locationAccess
  case alertContent_login
  case alertContent_loginContinue
  case alertContent_logout
  case alertContent_notRestored
  case alertContent_quitChallenge
  case alertTitle_delete
  case alertTitle_deleteAccount
  case alertTitle_locationAccess
  case alertTitle_login
  case alertTitle_logout
  case alertTitle_quitChallenge
  case alertTitle_sessionExpired
  case banner_allowLocation
  case banner_collectStamp
  case banner_nearby
  case banner_signIn
  case banner_signUp
  case buttonText_changeLanguage
  case buttonText_loginAgain
  case buttonText_logout
  case buttonText_refresh
  case categoryName_art
  case categoryName_culturalEvent
  case categoryName_foodie
  case categoryName_history
  case categoryName_local
  case categoryName_mustSeeSpots
  case categoryName_nightViews
  case categoryName_photoSpots
  case categoryName_walkingTours
  case commentFormText_enter
  case commentToastText_deleted
  case commentToastText_restored
  case detailBadgeSubText_complete
  case detailBadgeTitle_congrats
  case detailChallengeCommentText
  case detailChallengeFloatText
  case detailChallengeSubText_checkStamp
  case detailChallengeSubText_getStamp
  case detailChallengeSubText_stampMission
  case detailChallengeText_missionSpots
  case detailChallengeText_stamp
  case detailchallengeTitle_eventsMission
  case detaillanguageRadio_english
  case detaillanguageRadio_korean
  case detaillanguageTitle
  case detailmenuItem_changeNickname
  case detailmenuItem_comment
  case detailmenuItem_deleteAccount
  case detailmenuItem_myBadge
  case detailmenuItem_themeChallenge
  case detailnicknameSubText
  case detailnicknameText_enter
  case footer_home
  case footer_my
  case footer_mychallenge
  case heartButton
  case homeBackGroundText_event
  case homeBackGroundText_jonggak
  case homeBackGroundText_keepGoing
  case homeBackGroundText_lightChallenge
  case homeBackGroundText_missed
  case homeBackGroundText_mostPopular
  case homeBackGroundText_nearby
  case homeBackGroundText_ranking
  case homeBackGroundText_recently
  case homeBackGroundText_seoulMaster
  case homeBackGroundText_similar
  case homeBackGroundText_startChallenge
  case homeBackGroundText_theme
  case homelistText_joined
  case JJIMtoastText_removed
  case myBadgeContent_ready
  case myBadgeTitle_moreCloser
  case mybuttonText_badge
  case mybuttonText_JJIMSpots
  case mybuttonText_myComments
  case myCommentSub_joinChallenge
  case myCommentText_no
  case myJJIMContent_addMore
  case myJJIMContent_havenot
  case myJJIMSubText_havenot
  case myJJIMSubText_total
  case myJJIMTitle_havenot
  case myListButtonText_deleteAccount
  case myListButtonText_korean
  case myListButtonText_logout
  case myListText_aboutService
  case myListText_FAQ
  case myListText_language
  case myListText_locationAccess
  case myListText_locationAgree
  case myListText_notifications
  case myListText_privacyPolicy
  case myListText_termsService
  case myListText_version
  case mySubText_JJIMBadge
  case myTapButtonText_completed
  case myTapButtonText_jjim
  case myTapButtonText_onIt
  case popupTitle_stampComplete
  case reviewSubButton_delete
  case reviewSubButton_edit
  case subButton_more
  case subText_away
  case subText_closed
  case subText_hotSport
  case textButton_browse
  case textButton_cancel
  case textButton_copy
  case textButton_copyAddress
  case textButton_deleteAccount
  case textButton_goToSetting
  case textButton_later
  case textButton_leaveChallenge
  case textButton_login
  case textButton_loginStamp
  case textButton_quit
  case textButton_restore
  case textButton_startChallenge
  case textButton_viewDetails
  case textButton_viewMyBadge
  case textButton_viewNaverMap
  case textButton_viewOnMap
  case themeDetailText_comingSoon
  case toastText_copied
  case toastText_removedJJIM
  case withdrawexplanation_description_1
  case withdrawexplanation_description_2
  case withdrawexplanation_description_3
  case withdrawexplanation_shareyour
  case withdrawexplanation_thankyou
  case withdrawNote
}
