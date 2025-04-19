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
  case mypopInterestTitle = "mypop_interest_title"
  case mypopInterestEmptyTitle = "mypop_interest_empty_title"
  case mypopInterestEmptyDes = "mypop_interest_empty_des"
  case mypopInterestEmptyButton = "mypop_interest_empty_button"
  case mypopInprogressTitle = "mypop_inprogress_title"
  case mypopHeaderTitle = "mypop_header_title"
  case mypopCompletedTitle = "mypop_completed_title"
  case mypopInterestDeleteToast = "mypop_interest_delete_toast"
  case toastButtonRestoration = "toast_button_restoration"
  case mypopProgressEmptyButton = "mypop_progress_empty_button"
  case mypopProgressEmptyTitle = "mypop_progress_empty_title"
  case mypopProgressEmptyDes = "mypop_progress_empty_des"
  case mypopCompletedEmptyTitle = "mypop_completed_empty_title"
  case mypopCompletedEmptyDes = "mypop_completed_empty_des"

}
