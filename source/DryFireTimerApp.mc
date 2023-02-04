import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class DryFireTimerApp extends Application.AppBase {

    private var _myView as DryFireTimerView;
    private var _myViewDelegate as DryFireTimerDelegate;

    function initialize() {
        AppBase.initialize();
        _myView = new DryFireTimerView();
        _myViewDelegate = new DryFireTimerDelegate();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        return [ _myView, _myViewDelegate ] as Array<Views or InputDelegates>;
    }

}

function getApp() as DryFireTimerApp {
    return Application.getApp() as DryFireTimerApp;
}
