
import Toybox.Lang;
import Toybox.System;

// this is a combined model and controller?

class timer_logic {
    const TIMER_REFRESH = 67;

    private var _countDown as Lang.Number = 0;
    private var _countdownTimer = new Timer.Timer();
    private var _countdownRefreshTimer = new Timer.Timer();

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
        _countDown = 0;
        _countdownRefreshTimer.stop();
        WatchUi.requestUpdate();
        System.println("state = start ");
        System.println("timer beep");
        Attention.playTone(Attention.TONE_LOUD_BEEP);
    }

    function countdownRefreshCallback() as Void {
        _countDown -= TIMER_REFRESH;
        WatchUi.requestUpdate();
    }

    protected function startupDelay () as Lang.Number {
        // random mode
        return (Math.rand() % 3000) + 1000; // 1-4 second delays
    }

    function handleStart() {
        if (_timerState == RESET || _timerState == START_AND_RESET) {
            _timerState = COUNTDOWN;
            System.println("state = countdown ");
            _countDown = startupDelay();
            WatchUi.requestUpdate();
            System.println("timer delay " + _countDown);
            _countdownTimer.start(method(:countdownCallback), _countDown, false);
            _countdownRefreshTimer.start(method(:countdownRefreshCallback), TIMER_REFRESH, true);
        }
    }

    function handleReset() {
        if (_timerState == COUNTDOWN) {
            _countdownTimer.stop();
            _countdownRefreshTimer.stop();
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
        if (_timerState == COUNTDOWN) {
            var second = _countDown / 1000;
            var subsecond = (_countDown % 1000) / 10; // divide by ten to extract only 2 digits
            var output = second.toString() + ".";
            if (subsecond < 10) {
                output = output + "0";
            }
            output = output + subsecond.toString();
            return (output);
            //return _countDown.toString();
        } else {
            return "0.00";
        }

    }
}