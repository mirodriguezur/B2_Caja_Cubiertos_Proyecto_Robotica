MODULE Module1
    CONST robtarget Target_10:=[[17.680006378,29.000003785,64.999943406],[-0.000000006,1,0,0.000000004],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_20:=[[17.68,29,10.7],[0,1,0,0],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_30:=[[17.680006378,29.000003785,64.999943406],[-0.000000006,1,0,0.000000004],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_40:=[[-150.200005115,-270.140000008,64.999941394],[-0.000000007,0.871855665,0.489762902,0.000000004],[0,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_50:=[[-140.200013899,-600.000004341,64.999949592],[0.000000013,0.871855673,0.489762887,0.000000004],[0,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_60:=[[-140.2,-620,65],[0,0.707106781,0.707106781,0],[0,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_70:=[[-140.2,-620,63],[0,0.707106781,0.707106781,0],[0,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    VAR num contador:=0;
    !***********************************************************
    !
    ! Módulo:  Module1
    !
    ! Descripción:
    !   <Introduzca la descripción aquí>
    !
    ! Autor: Admin
    !
    ! Versión: 1.0
    !
    !***********************************************************


    !***********************************************************
    !
    ! Procedimiento Main
    !
    !   Este es el punto de entrada de su programa
    !
    !***********************************************************
    !Declaración de variables de interrupción
    
    VAR intnum int_buttonStopDI;                           !intnum comando que identifica interrupcion de parada de emergencia.
    
    PROC main()
        !Añada aquí su código
        setDO Start6_Controlador,0;
        setDO Start10_Controlador,0;
        setDO Start12_Controlador,0;
        SetDO Rutina,0;
        SetDO Ventosa_T,0;
        ciclo_inicio_tenedor:
        IF cubiertos_6=high THEN
            IDelete int_buttonStopDI;                          !Cancela interrupcion, necesario cuando el ciclo se repite.                
            CONNECT int_buttonStopDI WITH parada_emergencia;   !Se conecta la rutina TRAP con la interrupicion parada_emergencia
            iSignalDI Stop_button, 1, int_buttonStopDI;         !Se asocia buttonStop con la interrupcion parada_emergencia
            setDO Start6_Controlador,1;
            !setDO Start6_Controlador, 0;
            contador:=6;
            Rutina_tenedor;
            SetDO Rutina,1;
            WaitTime 1.5;
            SetDO Rutina,0;
        ELSEIF cubiertos_10=high THEN
            IDelete int_buttonStopDI;                          !Cancela interrupcion, necesario cuando el ciclo se repite.                
            CONNECT int_buttonStopDI WITH parada_emergencia;   !Se conecta la rutina TRAP con la interrupicion parada_emergencia
            iSignalDI Stop_button, 1, int_buttonStopDI;         !Se asocia buttonStop con la interrupcion parada_emergencia
            setDO Start10_Controlador,1;
            !setDO Start10_Controlador, 0;
            contador:=10;
            Rutina_tenedor;
            SetDO Rutina,1;
            WaitTime 1.5;
            SetDO Rutina,0;
        ELSEIF cubiertos_12=high THEN
            IDelete int_buttonStopDI;                          !Cancela interrupcion, necesario cuando el ciclo se repite.                
            CONNECT int_buttonStopDI WITH parada_emergencia;   !Se conecta la rutina TRAP con la interrupicion parada_emergencia
            iSignalDI Stop_button, 1, int_buttonStopDI;         !Se asocia buttonStop con la interrupcion parada_emergencia
            setDO Start12_Controlador,1;
            !setDO Start12_Controlador, 0;
            contador:=12;
            Rutina_tenedor;
            SetDO Rutina,1;
            WaitTime 1.5;
            SetDO Rutina,0;
        ELSE
            GOTO ciclo_inicio_tenedor;
        ENDIF
    ENDPROC
    PROC Rutina_tenedor()
        WHILE contador>0 DO
            WaitDI CajaOK,1;
            WaitDI CucharaOK,1;
            WaitDI TenedorOK,1;
            MoveJ Target_10,v600,z10,TCP_Ventosa\WObj:=Workobject_2;
            MoveL Target_20,v50,z1,TCP_Ventosa\WObj:=Workobject_2;
            SetDO Ventosa_T,1;
            WaitTime 1;
            MoveL Target_30,v150,z1,TCP_Ventosa\WObj:=Workobject_2;
            MoveJ Target_40,v600,z10,TCP_Ventosa\WObj:=Workobject_2;
            MoveL Target_50,v300,z1,TCP_Ventosa\WObj:=Workobject_2;
            MoveL Target_60,v300,z1,TCP_Ventosa\WObj:=Workobject_2;
            MoveL Target_70,v10,fine,TCP_Ventosa\WObj:=Workobject_2;
            SetDO Ventosa_T,0;
            WaitTime 1;
            MoveL Target_60,v300,z1,TCP_Ventosa\WObj:=Workobject_2;
            MoveL Target_50,v300,z1,TCP_Ventosa\WObj:=Workobject_2;
            MoveL Target_40,v300,z1,TCP_Ventosa\WObj:=Workobject_2;
            contador:=contador-1;
            IF contador=0 THEN
                IF cubiertos_6=high THEN
                   contador:=6;
                   SetDO Rutina,1;
                   WaitTime 1.5;
                   SetDO Rutina,0;
                ELSEIF cubiertos_10=high THEN
                   contador:=10;
                   SetDO Rutina,1;
                   WaitTime 1.5;
                   SetDO Rutina,0;
                ELSEIF cubiertos_12=high THEN
                   contador:=12;
                   SetDO Rutina,1;
                   WaitTime 1.5;
                   SetDO Rutina,0;
                ENDIF
            ENDIF
        ENDWHILE
    ENDPROC
    
   TRAP parada_emergencia                              !Interrupcion parada_emergencia
        StopMove;                                       !Detiene movimento de robot
        SetDO Rutina,0;
        !IF buttonStop=low THEN
        !    StartMove;
        !ELSE 
        !    parada_emergencia:
        !ENDIF
        WHILE Stop_button = high DO                      !Mientras siga activo pulsador buttonStop, el programa seguirá detenido
        ENDWHILE                                        
        StartMove;                                      !Si se desactiva pulsador buttonStop, el programa continua donde quedó.
    ENDTRAP
ENDMODULE