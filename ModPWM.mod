MODULE ModPWM

    LOCAL VAR intnum intPwm;
    LOCAL VAR signaldo dosig;
    LOCAL VAR num tOn;

    PROC StartPWM(VAR signaldo sig,num aPeriod,num aDuty)
        IF intPwm > 0 THEN
            StopPWM;
        ENDIF
        
        AliasIO sig,dosig;
        IF aDuty>=1 THEN
            PWMHigh;
        ELSEIF aDuty<=0 THEN
            PWMLow;
        ELSE
            CONNECT intPwm WITH trPwm;
            tOn:=aPeriod*aDuty;
            ITimer aPeriod,intPwm;
        ENDIF
    ENDPROC

    PROC StopPWM()
        IDelete intPwm;
        Reset dosig;
        AliasIOReset dosig;
        tOn := 0;
    ENDPROC

    LOCAL PROC PWMHigh()
        Set dosig;
    ENDPROC

    LOCAL PROC PWMLow()
        Reset dosig;
    ENDPROC

    LOCAL TRAP trPwm
        PWMHigh;
        WaitTime tOn;
        PWMLow;
    ENDTRAP
ENDMODULE