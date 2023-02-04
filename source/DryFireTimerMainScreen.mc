import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

class DryFireTimerView extends WatchUi.View {
    
    private var _DryFireTimerLogic as DryFireTimerLogic;


    function initialize(timerLogic as DryFireTimerLogic) {
        View.initialize();
        _DryFireTimerLogic = timerLogic;
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        var statusPromptLable = View.findDrawableById("StatusPromptLabel") as WatchUi.Text;
        statusPromptLable.setText(_DryFireTimerLogic.getStatusPromptText());
        var timerLabel = View.findDrawableById("CountdownLabel") as WatchUi.Text;
        timerLabel.setText(_DryFireTimerLogic.getTimerText());
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

}

class DryFireTimerDelegate extends WatchUi.BehaviorDelegate {

    private var _DryFireTimerLogic as DryFireTimerLogic;

    function initialize(timerLogic as DryFireTimerLogic) {
        BehaviorDelegate.initialize();
        _DryFireTimerLogic = timerLogic;
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
                _DryFireTimerLogic.handleStart();
                return false;
            } else if (key == KEY_DOWN) {
                _DryFireTimerLogic.handleReset();
                return false;
            } else {
                return true;
            }
        }
    }

}
