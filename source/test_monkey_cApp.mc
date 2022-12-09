import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class test_monkey_cApp extends Application.AppBase {

    private var _timer_logic as timer_logic;
    private var _myView as test_monkey_cView;

    function initialize() {
        AppBase.initialize();
        _timer_logic = new timer_logic();
        _myView = new test_monkey_cView(_timer_logic);
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        return [ _myView, new test_monkey_cDelegate(_timer_logic) ] as Array<Views or InputDelegates>;
    }

}

function getApp() as test_monkey_cApp {
    return Application.getApp() as test_monkey_cApp;
}