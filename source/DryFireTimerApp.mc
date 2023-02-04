import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class DryFireTimerApp extends Application.AppBase {

    private var _DryFireTimerLogic as DryFireTimerLogic;
    private var _myView as DryFireTimerView;

    function initialize() {
        AppBase.initialize();
        _DryFireTimerLogic = new DryFireTimerLogic();
        _myView = new DryFireTimerView(_DryFireTimerLogic);
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        return [ _myView, new DryFireTimerDelegate(_DryFireTimerLogic) ] as Array<Views or InputDelegates>;
    }

}

function getApp() as DryFireTimerApp {
    return Application.getApp() as DryFireTimerApp;
}
