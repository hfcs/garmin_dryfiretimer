import Toybox.Lang;
import Toybox.WatchUi;

class DryFireTimerDelegate extends WatchUi.BehaviorDelegate {

    private var _timer_logic as timer_logic;

    function initialize(logic as timer_logic) {
        BehaviorDelegate.initialize();
        _timer_logic = logic;
    }

    protected function launchParTimePicker() as Void {
        WatchUi.pushView(new $.ParTimePicker(), new $.ParTimePickerDelegate(), WatchUi.SLIDE_RIGHT);
    }

    function onPreviousPage() as Boolean { // easier to trigger by "next" button, Menu action will keep incrementing
        launchParTimePicker();
        return true;
    }

    function onMenu() as Boolean {
        launchParTimePicker();
        return true;
    }


    function onKey(keyEvent) {
        var key = keyEvent.getKey() as Toybox.Lang.Object;
        System.println(key);  // e.g. KEY_MENU = 7
        System.println(keyEvent.getType() as Toybox.Lang.Object); // e.g. PRESS_TYPE_DOWN = 0
        if (key == KEY_ESC) {
            return false;
        }            
        else {
            if (key == KEY_ENTER) {
                _timer_logic.handleStart();
                return false;
            } else if (key == KEY_DOWN) {
                _timer_logic.handleReset();
                return false;
            } else {
                return true;
            }
        }
    }

}