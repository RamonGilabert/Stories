import UIKit
import Sugar

struct Text {

  struct Welcome {
    static let title = localizedString("welcome").uppercaseString
  }

  struct Connecting {
    static let first = localizedString("connectingEstablishing")
    static let second = localizedString("connectingConnected")
  }

  struct Menu {
    static let story = localizedString("menuFullStory").uppercaseString
    static let backStory = localizedString("menuBackStory").uppercaseString
    static let motivation = localizedString("menuReadMotivation").uppercaseString
    static let end = localizedString("menuWatchTheEnd").uppercaseString
    static let github = localizedString("menuFindGithub").uppercaseString
    static let contact = localizedString("menuContact").uppercaseString
  }

  struct Contact {
    static let title = localizedString("contactTitle")
    static let message = localizedString("contactMessage")

    struct Error {
      static let title = localizedString("contactErrorTitle")
      static let message = localizedString("contactErrorMessage")
      static let button = localizedString("contactErrorButton").uppercaseString
    }
  }

  struct Story {
    static let title = localizedString("storyTitle").uppercaseString
    static let message = String(localizedString("storyMessage").characters.dropFirst())
    static let conclusion = localizedString("storyConclusion")
    static let footer = localizedString("storyFooter")
  }

  struct Motivation {
    static let title = localizedString("motivationTitle").uppercaseString
    static let message = String(localizedString("motivationMessage").characters.dropFirst())
    static let conclusion = localizedString("motivationConclusion")
    static let footer = localizedString("motivationFooter")
  }

  struct Finale {
    static let title = localizedString("finaleTitle")
    static let button = localizedString("finaleButton").uppercaseString
  }

  struct Interactive {
    static let one = localizedString("interactiveFirst")
    static let two = localizedString("interactiveSecond")
    static let three = localizedString("interactiveThird")
    static let four = localizedString("interactiveFourth")
    static let five = localizedString("interactiveFive")
    static let six = localizedString("interactiveSix")
    static let seven = localizedString("interactiveSeven")
    static let eight = localizedString("interactiveEight")
    static let nine = localizedString("interactiveNine")
    static let ten = localizedString("interactiveFirst")
    static let eleven = localizedString("interactiveSecond")
    static let twelve = localizedString("interactiveThird")
    static let thirteen = localizedString("interactiveFourth")
    static let fourteen = localizedString("interactiveFive")
    static let fiveteen = localizedString("interactiveSix")
    static let sixteen = localizedString("interactiveSeven")
    static let seventeen = localizedString("interactiveEight")
    static let nineteen = localizedString("interactiveNine")
    static let twenty = localizedString("interactiveFirst")
    static let twentyOne = localizedString("interactiveSecond")
    static let twentyTwo = localizedString("interactiveThird")
    static let twentyThree = localizedString("interactiveFourth")
    static let twentyFour = localizedString("interactiveFive")
    static let twentyFive = localizedString("interactiveSix")
    static let twentySix = localizedString("interactiveSeven")
    static let twentySeven = localizedString("interactiveEight")
    static let twentyEight = localizedString("interactiveNine")
    static let twentyNine = localizedString("interactiveNine")
    static let thirty = localizedString("interactiveFirst")
    static let thirtyOne = localizedString("interactiveSecond")
    static let thirtyTwo = localizedString("interactiveThird")
    static let thirtyThree = localizedString("interactiveFourth")
    static let thirtyFour = localizedString("interactiveFive")
    static let thirtyFive = localizedString("interactiveSix")
    static let thirtySix = localizedString("interactiveSeven")

    struct Buttons {
      static let firstOne = localizedString("interactiveFirstOne")
      static let firstTwo = localizedString("interactiveFirstTwo")
      static let fourOne = localizedString("interactiveFourthOne")
      static let fourTwo = localizedString("interactiveFourthTwo")
      static let sevenOne = localizedString("interactiveSevenOne")
      static let sevenTwo = localizedString("interactiveSevenTwo")
      static let nineOne = localizedString("interactiveNineOne")
      static let nineTwo = localizedString("interactiveNineTwo")
      static let elevenOne = localizedString("interactiveElevenOne")
      static let elevenTwo = localizedString("interactiveElevenTwo")
      static let thirteenOne = localizedString("interactiveThirteenOne")
      static let thireteenTwo = localizedString("interactiveThirteenTwo")
      static let fourteenOne = localizedString("interactiveFourteenOne")
      static let fourteenTwo = localizedString("interactiveFourteenTwo")
      static let seventeenOne = localizedString("interactiveSeventeeOne")
      static let seventeenTwo = localizedString("interactiveSeventeenTwo")
      static let twentyTwoOne = localizedString("interactiveTwentyTwoOne")
      static let twentyTwoTwo = localizedString("interactiveTwentyTwoTwo")
      static let twentyFiveOne = localizedString("interactiveTwentyFiveOne")
      static let twentyFiveTwo = localizedString("interactiveTwentyFiveTwo")
      static let twentyEightOne = localizedString("interactiveTwentyEightOne")
      static let twentyEightTwo = localizedString("interactiveTwentyEightTwo")
      static let thirtyOneOne = localizedString("interactiveThirtyOneOne")
      static let thirtyOneTwo = localizedString("interactiveThirtyOneTwo")
      static let thirtySixOne = localizedString("interactiveThirtySixOne")
      static let thirtySixTwo = localizedString("interactiveThirtySixTwo")
    }
  }
}
