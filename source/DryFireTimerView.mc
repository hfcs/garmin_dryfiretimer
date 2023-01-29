import Toybox.Graphics;
import Toybox.WatchUi;

class DryFireTimerView extends WatchUi.View {
    
    private var _timer_logic as timer_logic;


    function initialize(timer_logic as timer_logic) {
        View.initialize();
        _timer_logic = timer_logic;
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
        statusPromptLable.setText(_timer_logic.getStatusPromptText());
        var timerLabel = View.findDrawableById("CountdownLabel") as WatchUi.Text;
        timerLabel.setText(_timer_logic.getTimerText());
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

}
