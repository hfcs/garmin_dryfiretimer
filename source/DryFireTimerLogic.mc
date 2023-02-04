
import Toybox.Application.Storage;
import Toybox.Lang;
import Toybox.System;

// this is a combined model and controller?

class DryFireTimerLogic {
    const TIMER_REFRESH = 67;

    private static var _instance = null;
    private var _countDown as Lang.Number = 0;
    private var _countdownTimer = new Timer.Timer();
    private var _countdownRefreshTimer = new Timer.Timer();

    static function getInstance() {
        if (_instance == null) {
            _instance = new DryFireTimerLogic();
        }
        return _instance;
    }

    // State machine for timer,

    enum timerStateEnum {
        RESET,
        COUNTDOWN,
        START,
        PAR_COUNTDOWN,
        START_AND_RESET
        // PAR is not a registered state
    }
   
    private var _timerState as timerStateEnum = RESET;

    function parTimeCallback() as Void {
        _timerState = START;
        _countDown = 0;
        _countdownRefreshTimer.stop();
        WatchUi.requestUpdate();
        Attention.playTone(Attention.TONE_LOUD_BEEP);
    }

    function countdownCallback() as Void {
        _timerState = START;
        _countDown = 0;
        _countdownRefreshTimer.stop();
        WatchUi.requestUpdate();
        Attention.playTone(Attention.TONE_LOUD_BEEP);
        if (getParTime() > 0) {
            // zero means no par time
            handleParTime();
        }
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
            _countDown = startupDelay();
            WatchUi.requestUpdate();
            _countdownTimer.start(method(:countdownCallback), _countDown, false);
            _countdownRefreshTimer.start(method(:countdownRefreshCallback), TIMER_REFRESH, true);
        }
    }

    function handleParTime() {
        if (_timerState == START) {
            _timerState = PAR_COUNTDOWN;
            _countDown = getParTime();
            WatchUi.requestUpdate();
            _countdownTimer.start(method(:parTimeCallback), _countDown, false);
            _countdownRefreshTimer.start(method(:countdownRefreshCallback), TIMER_REFRESH, true);
        }
    }

    function handleReset() {
        if (_timerState == COUNTDOWN) {
            _countdownTimer.stop();
            _countdownRefreshTimer.stop();
            _timerState = RESET;
            _countDown = 0;
            WatchUi.requestUpdate();
        } else if (_timerState == START) {
            _timerState = START_AND_RESET;
            WatchUi.requestUpdate();
        }
        
    }

    function getTimerText() {
        if (_timerState == COUNTDOWN || _timerState == PAR_COUNTDOWN) {
            var second = _countDown / 1000;
            var subsecond = (_countDown % 1000) / 10; // divide by ten to extract only 2 digits
            var output = second.toString() + ".";
            if (subsecond < 10) {
                output = output + "0";
            }
            output = output + subsecond.toString();
            return (output);
        } else {
            return "0.00";
        }

    }

    function getStatusPromptText() {
        if (_timerState == RESET) {
            return $.Rez.Strings.TimerStatusReady;
        } else if (_timerState == COUNTDOWN) {
            return $.Rez.Strings.TimerStatusCountdown;
        } else if (_timerState == START) {
            return $.Rez.Strings.TimerStatusNeedReset;
        } else if (_timerState == PAR_COUNTDOWN) {
            return $.Rez.Strings.TimerStatusParCountdown;
        } else if (_timerState == START_AND_RESET) {
            return $.Rez.Strings.TimerStatusReady;
        } else {
            return $.Rez.Strings.InternalError;
        }
    }

    function setParTime(parMilliSecond as Lang.Number) as Void {
        Storage.setValue("parMilliSecond", parMilliSecond);
    }

    function getParTime() as Lang.Number {
        if (Storage.getValue("parMilliSecond") == null) { 
            // default to zero (no par time) on first time this app is run
            var parMilliSecond = 0;
            Storage.setValue("parMilliSecond", parMilliSecond);
        }
        return Storage.getValue("parMilliSecond");
    }
    
}
