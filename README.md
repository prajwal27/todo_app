# Proof of concepts

* Debounced Task
    - Perform an action with a debounce
    - Used for search field
* Delayed Task
    - Perform some task with a 5 second delay
* Timer Task
    - Perform some task repeatedly for between a delay and terminate,
    - Example would be OTP timer, countdown 60 secs
* Cancelable Task
    - Cancel previous action if any when same action is dispatched again when previous is active
    - Used to cancel calls when user leaves a page when there is an active api call and comes back again,
    - Changes the filters, apply recent filter 
    - We might want to cancel an operations, like file upload (user could cancel or upload a new photo when there is an active upload), or some data processing is active etc
* Timeout Task
    - Resolve with timeout when task takes too long than expected
* Paginated Task Based on State
    - Fetch N data, if dispatched same action again fetch next N data, N = No of items per page
    - We'll have this in the transactions list
* Retry Task
    - Retry N times on failure (Today we are using for api calls when response is 500, but could also be used when there is some connection errors)
* Sequential Tasks
    - `API 1 -> API 2 -> API 3` => Result: Success if all success, Fails if at least one api throws error
    - Fetch Card Status -> Request Automatically If Not Requested)
    - Used to automatically verify user phone, etc
*  Parallel Tasks
    - Scenario 2: 

                         |-> API 3
          API 1 -> API 2 |-> API 4
                         |-> API 5
                                 
      Result: Success if 1,2 make through (3,4,5 if success make state change, error should not affect state), Fails if 1 or 2 throws and error
    - Use case: Login -> Member details, other calls based on member details
* Global Error Handling
    - Helps to handle errors more effectively and report unhandled errors
* Logging State Transitions
    - Helps debug the state change and identify issues at state mutations
    - Offers more visibility of state
    - Helps record all state transitions and offers to playback if needed (Provided is states are serializable)
* Reset All State
    - Reset All States when some action happens
    - Use case: Clear data on Logout
* Handle Respective Action States
    - Handle Loading & Error states for individual actions (Say I'm updating two Todos, only show those loading indicator, if one resolves with error, only that show respective error)
* Testing
    - Write unit tests for all possible cases
    - Write widget tests for all possible cases (At least one test based on some remote config - test both scenario)
    - Analyse code coverage of all the Tests (You can get coverage by running `flutter test --coverage`)
    - Integration test (Not mandatory, as we don't have data sharing between the app and test) would be more or less same for both
* Service/Dependency Injection
    - Demonstrate how would action gets access to service
    - Demonstrate how would an action perform API call using a service
    - Check if Services can be Mocked and Injected
    