//
//  String+Language.swift
//  Common
//
//  Created by suni on 3/31/25.
//

import Foundation

public extension String {
  var localized: String {
    NSLocalizedString(self, comment: "")
  }
  
  init(sLocalization key: LocalizationsKey) {
    self = key.rawValue.localized
  }
  
  func localizedFormat(_ args: CVarArg...) -> String {
    String(format: NSLocalizedString(self, comment: ""), arguments: args)
  }
  
  func localizedFormat(arguments: [CVarArg]) -> String {
    String(format: NSLocalizedString(self, comment: ""), arguments: arguments)
  }
}

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
