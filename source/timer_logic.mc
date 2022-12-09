
import Toybox.Lang;
import Toybox.System;

// this is a combined model and controller?

class timer_logic {

    private var _countDown as Lang.Number = 0;
    private var _myTimer = new Timer.Timer();

    // State machine for timer,

    enum timerStateEnum {
        RESET,
        COUNTDOWN,
        START,
        START_AND_RESET
        // PAR is not a registered state
    }
   
    private var _timerState as timerStateEnum = RESET;

    function countdownCallback() as Void {
        _timerState = START;
        System.println("state = start ");
        System.println("timer beep");
        Attention.playTone(Attention.TONE_LOUD_BEEP);
    }

    function handleStart() {
        if (_timerState == RESET || _timerState == START_AND_RESET) {
            _timerState = COUNTDOWN;
            System.println("state = countdown ");
            _countDown = (Math.rand() % 3000) + 1000; // 1-4 second delays
            WatchUi.requestUpdate();
            System.println("timer delay " + _countDown);
            _myTimer.start(method(:countdownCallback), _countDown, false);
        }
    }

    function handleReset() {
        if (_timerState == COUNTDOWN) {
            _myTimer.stop();
            _timerState = RESET;
            System.println("state = reset ");
            _countDown = 0;
            WatchUi.requestUpdate();
        } else if (_timerState == START) {
            _timerState = START_AND_RESET;
            System.println("state = start and reset ");
        }
        
    }

    function getTimerText() {
        return _countDown.toString();
    }
}