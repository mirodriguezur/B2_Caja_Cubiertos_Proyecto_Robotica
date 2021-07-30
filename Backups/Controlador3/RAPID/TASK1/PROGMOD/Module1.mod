MODULE Module1
    CONST robtarget Target_10:=[[-23.679995733,30.000024272,64.999939178],[0.000000004,0,1,0.000000007],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_20:=[[-23.68,30,11.2],[0,0,1,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_30:=[[-23.679995733,30.000024272,64.999939178],[0.000000004,0,1,0.000000007],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_40:=[[126.149990693,-270.119999999,64.999933168],[0.000000011,0.486182918,0.873857065,0.000000019],[-1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_50:=[[126.149993351,-600.000025877,64.999935931],[0.000000004,0.4861829,0.873857075,-0.000000015],[-1,-1,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_60:=[[126.15,-620,65],[0,0.707106781,0.707106781,0],[-1,-1,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_70:=[[126.15,-620,63],[0,0.707106781,0.707106781,0],[-1,-1,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    VAR num contador:=0;
    !***********************************************************
    !
    ! M�dulo:  Module1
    !
    ! Descripci�n:
    !   <Introduzca la descripci�n aqu�>
    !
    ! Autor: Admin
    !
    ! Versi�n: 1.0
    !
    !***********************************************************


    !***********************************************************
    !
    ! Procedimiento Main
    !
    !   Este es el punto de entrada de su programa
    !
    !***********************************************************
    PROC main()
        !A�ada aqu� su c�digo
        setDO Start6_Controlador,0;
        setDO Start10_Controlador,0;
        setDO Start12_Controlador,0;
        SetDO Ventosa_C,0;
        SetDO Rutina,0;
        ciclo_inicio_cuchara:
        IF cubiertos_6=high THEN
            setDO Start6_Controlador,1;
            !setDO Start6_Controlador, 0;
            contador:=6;
            Rutina_cuchara;
            SetDO Rutina,1;
            WaitTime 1.5;
            SetDO Rutina,0;
        ELSEIF cubiertos_10=high THEN
            setDO Start10_Controlador,1;
            !setDO Start10_Controlador, 0;
            contador:=10;
            Rutina_cuchara;
            SetDO Rutina,1;
            WaitTime 1.5;
            SetDO Rutina,0;
        ELSEIF cubiertos_12=high THEN
            setDO Start12_Controlador,1;
            !setDO Start12_Controlador, 0;
            contador:=12;
            Rutina_cuchara;
            SetDO Rutina,1;
            WaitTime 1.5;
            SetDO Rutina,0;
        ELSE
            GOTO ciclo_inicio_cuchara;
        ENDIF
    ENDPROC
    PROC Rutina_cuchara()
        WHILE contador>0 DO
            WaitDI CajaOK,1;
            WaitDI CucharaOK,1;
            WaitDI TenedorOK,1;
            MoveJ Target_10,v600,z10,TCP_Ventosa\WObj:=Workobject_1;
            MoveL Target_20,v50,z1,TCP_Ventosa\WObj:=Workobject_1;
            SetDO Ventosa_C,1;
            WaitTime 1;
            MoveL Target_30,v150,z1,TCP_Ventosa\WObj:=Workobject_1;
            MoveJ Target_40,v600,z10,TCP_Ventosa\WObj:=Workobject_1;
            MoveL Target_50,v300,z1,TCP_Ventosa\WObj:=Workobject_1;
            MoveL Target_60,v300,z1,TCP_Ventosa\WObj:=Workobject_1;
            MoveL Target_70,v10,fine,Tooldata_1\WObj:=Workobject_1;
            SetDO Ventosa_C,0;
            WaitTime 1;
            MoveL Target_60,v300,z1,TCP_Ventosa\WObj:=Workobject_1;
            MoveL Target_50,v300,z1,TCP_Ventosa\WObj:=Workobject_1;
            MoveL Target_40,v300,z1,TCP_Ventosa\WObj:=Workobject_1;
            contador:=contador-1;
        ENDWHILE
    ENDPROC
ENDMODULE