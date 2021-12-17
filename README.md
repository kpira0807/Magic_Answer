# Magic_Answer
 
 
 Provides an answer to any question

8-Ball Without Actual Ball:
Application gets random answers from endpoint https://8ball.delegator.com/magic/JSON/<question_string>. 

You are free to use any string as parameter (no need to send actual question). 
In case of internet connection absence or request failure, application uses one of hardcoded answers.

Application should have three screens: Main,  Settings and History.
Main screen contains call-to-shake text or answer, depending on the current application state.

Settings screen allows the user to set and save hardcoded answers like ""Just do it!"", ""Change your mind"", etc, even when the internet connection is broken.


## Information

- MVVM architecture with three-layers:  Model - ViewModel - ViewController

- Used Realm for data

- RxSwift for share data between Model - ViewModel - ViewController

- Used NavigationNote


