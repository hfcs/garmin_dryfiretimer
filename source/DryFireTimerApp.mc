import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class DryFireTimerApp extends Application.AppBase {

    private var _timer_logic as timer_logic;
    private var _myView as DryFireTimerView;

    function initialize() {
        AppBase.initialize();
        _timer_logic = new timer_logic();
        _myView = new DryFireTimerView(_timer_logic);
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        return [ _myView, new DryFireTimerDelegate(_timer_logic) ] as Array<Views or InputDelegates>;
    }

}

function getApp() as DryFireTimerApp {
    return Application.getApp() as DryFireTimerApp;
}
