namespace BA.BA;
using Microsoft.HumanResources.Employee;
using Microsoft.Foundation.Calendar;
using System.Utilities;
using Microsoft.Inventory.Item.Catalog;
using Microsoft.HumanResources.Absence;

page 123456701 PageFinal
{
    ApplicationArea = All;
    Caption = 'PageFinal';
    PageType = Card;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

            }
            group(Datumsfilter)
            {
                field(StartDate; StartDateFilter)
                {
                    Caption = 'Von Datum';
                    ToolTip = 'Wählen Sie das Startdatum des Zeitraumes aus.';
                }
                field(EndDate; EndDateFilter)
                {
                    Caption = 'Bis Datum';
                    ToolTip = 'Wählen Sie das Enddatum des Zeitraumes aus.';
                }

            }
            group(Bericht)
            {
                part(Report; ListPartReport)
                {
                    Editable = true;
                }

            }
            group(Facttable)
            {
                part(PSFT; ListPartPSFT)
                {
                    Editable = true;
                }
                part(TFT; ListPartTFT)
                {
                    Editable = true;
                }
                part(ASFT; ListPartASFT)
                {
                    Editable = true;
                }
            }
            group(Dimiensionen)
            {
                part(DimAbwesenheitsgrund; ListPartDimAbwesenheitsgrund)
                {
                    Editable = true;
                }
                part(DimMitarbeiter; ListPartDimMitarbeiter)
                {
                    Editable = true;
                }
                part(DimZeit; ListPartDimZeit)
                {
                    Editable = true;
                }

            }
            group(FehlerhafteDatensatze)
            {
                part(DoppelteDatensatz; ListPartDoppelteDatensatz)
                {
                    Editable = true;
                }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            group(Calculations)
            {
                Caption = 'Berechnungen';
                Visible = true;

                action(CalcPSFT)
                {
                    Caption = 'Befüllung';
                    ToolTip = 'Füllt die Tabellen';
                    trigger
                    OnAction()
                    begin
                        //Fehlerabfangen 
                        if EndDateFilter < StartDateFilter then
                            Message('Das Enddatum darf nicht hinter dem Startdatum liegen!')
                        else
                            if StartDateFilter = 0D then
                                Message('Das Startdatum muss ausgewählt sein!')
                            else
                                if EndDateFilter = 0D then
                                    Message('Das Enddatum muss ausgewählt sein!')
                                else begin
                                    //Beginn der Befüllung von Dim und Factable
                                    doppeltDatensatz();
                                    fillDimMitarbeiter();
                                    fillDimZeit();
                                    fillDimAbwesenheitsgrund();
                                    fillPSFT();
                                    fillTFT();
                                    fillASFT();
                                    fillReport();
                                    Message('Erfolgreich geladen');
                                end;
                    end;


                }
            }
        }
    }

    procedure fillDimMitarbeiter()
    var
        //Anlegen der Records
        RecMitarbeiter: Record Employee;
        RecDimMitarbeiter: Record DimMitarbeiter;
    begin
        //Dim leeren
        RecDimMitarbeiter.DeleteAll();
        if RecMitarbeiter.FindSet() then
            repeat
                //Datensatz initalisieren
                RecDimMitarbeiter.Init();
                //Dim Befüllen aus den jedweiligen Tabellen
                RecDimMitarbeiter."MitarbeiterNummer" := RecMitarbeiter."No.";
                RecDimMitarbeiter."Vorname" := RecMitarbeiter."First Name";
                RecDimMitarbeiter."Nachname" := RecMitarbeiter."Last Name";
                RecDimMitarbeiter.MitarbeiterInitailien := RecMitarbeiter.Initials;
                RecDimMitarbeiter.Berufsbezeichnung := RecMitarbeiter."Job Title";
                RecDimMitarbeiter.Adresse := RecMitarbeiter.Address;
                RecDimMitarbeiter.PLZ := RecMitarbeiter."Post Code";
                RecDimMitarbeiter.Ort := RecMitarbeiter.City;
                RecDimMitarbeiter.Land := RecMitarbeiter."Country/Region Code";
                RecDimMitarbeiter.Telefon := RecMitarbeiter."Phone No.";
                RecDimMitarbeiter.Geburtstag := RecMitarbeiter."Birth Date";
                RecDimMitarbeiter.Einstellungstag := RecMitarbeiter."Employment Date";
                RecDimMitarbeiter.Abteilung := RecMitarbeiter."Global Dimension 1 Code";
                //Datensatz einfügen
                RecDimMitarbeiter.Insert();
            until RecMitarbeiter.Next() = 0;
    end;

    procedure fillDimZeit()
    var
        //Anlegen der Records
        RecDimZeit: Record DimZeit;
        RecBasiskalender: Record Date;
        //Nutzung für IstArbeitstag
        CU7600: Codeunit 7600;
        Rec7602: Record 7602;
    begin
        //Leerung der Dim
        RecDimZeit.DeleteAll();
        //Tage werden in der Tabelle angezeigt
        RecBasiskalender.SetRange(RecBasiskalender."Period Type", 0);
        //Nach Zeitraum Filtern vom Nutzer
        RecBasiskalender.SetFilter("Period Start", '%1..%2', StartDateFilter, EndDateFilter);
        if RecBasiskalender.FindSet() then
            repeat
                //Befüllen der Dim durch Basiskalender
                RecDimZeit.Datum := RecBasiskalender."Period Start";
                RecDimZeit.Wochentag := Format(RecBasiskalender."Period Start", 0, '<Weekday Text>');
                RecDimZeit.Tag := Date2DMY(RecBasiskalender."Period Start", 1);
                RecDimZeit.Monat := Date2DMY(RecBasiskalender."Period Start", 2);
                RecDimZeit.Jahr := Date2DMY(RecBasiskalender."Period Start", 3);
                RecDimZeit.Quartal := Quartalberechnen(RecDimZeit.Monat);
                RecDimZeit.IstArbeitstag := isWorkday(RecBasiskalender."Period Start");
                //Datensatz einfügen
                RecDimZeit.Insert();

            until RecBasiskalender.Next() = 0;

    end;

    procedure fillDimAbwesenheitsgrund()
    var
        //Anlegen der Records
        RecDimAbwesenheitsgrund: Record DimAbwesenheitsgrund;
        RecAbwesenheitsgrund: Record 5206;
    begin
        //Leerung der Dim
        RecDimAbwesenheitsgrund.DeleteAll();
        if RecAbwesenheitsgrund.FindSet() then
            repeat
                //Datensatz Initalisieren
                RecDimAbwesenheitsgrund.Init();
                //Dim füllen aus Abwesenheitsgrund Tabelle
                RecDimAbwesenheitsgrund.GrundID := RecAbwesenheitsgrund.Code;
                RecDimAbwesenheitsgrund.Grundbezeichnung := RecAbwesenheitsgrund.Description;
                //Datensatz einfügen
                RecDimAbwesenheitsgrund.Insert()
            until RecAbwesenheitsgrund.Next() = 0;
    end;

    procedure fillPSFT()
    var
        //Anlegen der Records
        recPSFT: Record TablePSFT;
        recDimZeit: Record DimZeit;
        recDimMitarbeiter: Record DimMitarbeiter;
        recDimAbwesenheitsgrund: Record DimAbwesenheitsgrund;
        recAbwesenheitRoh: Record "Employee Absence";
    begin
        //Leerung der Dim
        recPSFT.DeleteAll();
        //Jeder Tag wird aufgenommen
        if recDimZeit.FindSet() then
            repeat
                //Jeder Mitarbeiter
                if recDimMitarbeiter.FindSet() then
                    repeat
                        //Kreuzprodukt bilden
                        recPSFT.Init();
                        recPSFT.Tag := recDimZeit.Tag;
                        recPSFT.Monat := recDimZeit.Monat;
                        recPSFT.Jahr := recDimZeit.Jahr;
                        recPSFT.MitarbeiterID := recDimMitarbeiter.MitarbeiterNummer;
                        recPSFT.Abteilung := recDimMitarbeiter.Abteilung;
                        //Sollte eine Abwesenheit vorhanden sein wird diese gespeichert
                        recAbwesenheitRoh.SetRange("Employee No.", recDimMitarbeiter.MitarbeiterNummer);
                        recAbwesenheitRoh.SetRange("From Date", recDimZeit.Datum);
                        if recAbwesenheitRoh.FindSet() then begin
                            recPSFT.Abwesenheitstag := true;
                            recPSFT.GrundID := recAbwesenheitRoh."Cause of Absence Code";
                            if recDimZeit.Wochentag = 'Montag' then
                                recPSFT.AbwesenheitsMontag := true;
                        end
                        else begin
                            recPSFT.Abwesenheitstag := false;
                            recPSFT.AbwesenheitsMontag := false;
                        end;
                        recAbwesenheitRoh.Reset();
                        recPSFT.Insert();
                    until recDimMitarbeiter.Next() = 0;
            until recDimZeit.Next() = 0;
    end;

    procedure fillTFT()
    var
        //Erstellung der Records
        recTFT: Record TableTFT;
        recDimZeit: Record DimZeit;
        recDimMitarbeiter: Record DimMitarbeiter;
        recDimAbwesenheitsgrund: Record DimAbwesenheitsgrund;
        recAbwesenheitRoh: Record "Employee Absence";
        TFTID: Integer;
    begin
        //Leerung der Dim
        recTFT.DeleteAll();
        TFTID := 1;
        recAbwesenheitRoh.SetRange("From Date", StartDateFilter, EndDateFilter);
        if recAbwesenheitRoh.FindSet() then
            repeat
                //Datensatz Initalisieren
                recTFT.Init();
                TFTID := TFTID + 1;
                recTFT.TFTID := TFTID;
                recTFT.MitarbeiterID := recAbwesenheitRoh."Employee No.";
                recTFT.Datum := recAbwesenheitRoh."From Date";
                recTFT.AbwesenheitsID := recAbwesenheitRoh."Cause of Absence Code";
                recDimZeit.SetRange(recDimZeit.Datum, recTFT.Datum);
                if recDimZeit.FindSet() then
                    recTFT.Wochentag := recDimZeit.Wochentag;
                if recDimZeit.Wochentag = 'Montag' then
                    recTFT.AbwesenheitsMontag := true;
                recTFT.Insert();
                recDimZeit.Reset();
            until recAbwesenheitRoh.Next() = 0;

    end;

    procedure fillASFT()
    var
        recASFT: Record TableASFT;
        recDimZeit: Record DimZeit;
        recDimMitarbeiter: Record DimMitarbeiter;
        recDimAbwesenheitsgrund: Record DimAbwesenheitsgrund;
        recAbwesenheitRoh: Record "Employee Absence";
        ASFTID: Integer;
        currentDate: Date;
        daysCount: Integer;
        i: Integer;
    begin
        recASFT.DeleteAll();
        ASFTID := 1;
        repeat
            recASFT.Init();
            recASFT.ASFTID := ASFTID;
            ASFTID := ASFTID + 1;

            if recAbwesenheitRoh."To Date" = 0D then begin
                recASFT.MitarbeiterID := recDimMitarbeiter.MitarbeiterNummer;
                recASFT.BeginAbwesenheit := recAbwesenheitRoh."From Date";
                recASFT.Messeinheit := recAbwesenheitRoh."Unit of Measure Code";
                recASFT.GrundID := recAbwesenheitRoh."Cause of Absence Code";
                recASFT.Dauer := recAbwesenheitRoh.Quantity;
                recASFT.Abteilung := recDimMitarbeiter.Abteilung;
                recDimZeit.SetRange(recDimZeit.Datum, recASFT.BeginAbwesenheit);

                if recDimZeit.FindSet() then begin
                    if recDimZeit.Wochentag = 'Montag' then
                        recASFT.AbwesenheitsMontage := 1;
                end;
            end else begin
                recASFT.MitarbeiterID := recDimMitarbeiter.MitarbeiterNummer;
                recASFT.BeginAbwesenheit := recAbwesenheitRoh."From Date";
                recASFT.EndeAbwesenheit := recAbwesenheitRoh."To Date";
                recASFT.Messeinheit := recAbwesenheitRoh."Unit of Measure Code";
                recASFT.GrundID := recAbwesenheitRoh."Cause of Absence Code";
                recASFT.Dauer := recAbwesenheitRoh.Quantity;
                recASFT.Abteilung := recDimMitarbeiter.Abteilung;
                recDimZeit.SetRange(recDimZeit.Datum, recASFT.BeginAbwesenheit);

                // Schleife über die Quantity-Tage
                currentDate := recAbwesenheitRoh."From Date";
                daysCount := recAbwesenheitRoh.Quantity;

                for i := 1 to daysCount do begin
                    recDimZeit.SetRange(recDimZeit.Datum, currentDate);
                    if recDimZeit.FindFirst() then begin
                        if recDimZeit.Wochentag = 'Montag' then begin
                            recASFT.AbwesenheitsMontage := recASFT.AbwesenheitsMontage + 1;
                        end;
                    end;
                    currentDate := currentDate + 1;
                end;
            end;
            recASFT.Insert();
        until recAbwesenheitRoh.Next() = 0;
    end;

    procedure doppeltDatensatz()
    var
        //Erstellung der Records
        recAbwesenheitRoh: Record "Employee Absence";
        recHilfsTabelle: Record "Employee Absence";
        recDoppel: Record DoppelteDatensatz;
        ID: Integer;
        Counter: Integer; //Zählvariable
    begin
        //Tabelle leeren
        recDoppel.DeleteAll();
        ID := 1;
        if recAbwesenheitRoh.FindSet() then
            repeat
                Counter := 0;
                if recHilfsTabelle.FindSet() then
                    repeat
                        //Wenn gleiche einträge gefunden sind zähl die Variable hoch
                        if recAbwesenheitRoh."Employee No." = recHilfsTabelle."Employee No." then
                            if recAbwesenheitRoh."From Date" = recHilfsTabelle."From Date" then
                                Counter := Counter + 1;
                        //Einmal wird es immer hier rein gehen, doch sind wirklich Datensätze
                        //Doppelt vorhanden geht diese über 1 und der Datensatz wird herausgeschrieben
                        if Counter >= 2 then begin
                            recDoppel.Init();
                            ID := ID + 1;
                            recDoppel.ID := ID;
                            recDoppel.MitarbeiterNummer := recAbwesenheitRoh."Employee No.";
                            recDoppel.Datum := recAbwesenheitRoh."From Date";
                            recDoppel.Insert();
                            //Zähler wieder auf 0
                            Counter := 0;
                        end;
                    until recHilfsTabelle.Next() = 0;
            until recAbwesenheitRoh.Next() = 0;
    end;

    procedure fillReport()
    var
        recReport: Record ReportTable;
        recDepartment: Record Manufacturer;
        recTFT: Record TableTFT;
        recASFT: Record TableASFT;
        recPSFT: Record TablePSFT;
        recDimZeit: Record DimZeit;
        recDimMitarbeiter: Record DimMitarbeiter;
        recDimAbwesenheitsgrund: Record DimAbwesenheitsgrund;
        recAbwesenheitRoh: Record "Employee Absence";
        krankstandMontags: Integer;
        arbeitsMontage: Integer;
        KrankheitstageMontags: Integer;
        monat: Integer;


    begin
        recReport.DeleteAll();
        recDimMitarbeiter.SetRange(Abteilung, 'PROD');
        if recDimMitarbeiter.FindSet() then begin
            recReport.DepID := recDimMitarbeiter.Abteilung;
            recReport.Abteilungsname := 'PROD';
            krankstandMontags := 0;
            KrankheitstageMontags := 0;

            recTFT.SetRange(MitarbeiterID, recDimMitarbeiter.MitarbeiterNummer);
            if recTFT.FindSet() then
                repeat
                    recReport.Init();
                    recDimZeit.SetRange(Datum, recTFT.Datum);
                    if recDimZeit.FindSet() then begin
                        recReport.Monatsname := Format(recDimZeit.Jahr) + ' ' + Format(recDimZeit.Datum, 0, '<Month Text>');
                        monat := recDimZeit.Monat;
                        recReport.MonthID := Format(recDimZeit.Jahr) + '-' + Format(monat);
                        recDimZeit.Reset();
                        recDimZeit.SetRange(recDimZeit.Monat, monat);
                        arbeitsMontage := 0;
                        if recDimZeit.FindSet() then
                            repeat
                                if recDimZeit.Wochentag = 'Montag' then
                                    arbeitsMontage := arbeitsMontage + 1;
                            until recDimZeit.Next() = 0;

                        if recTFT.AbwesenheitsMontag then
                            KrankheitstageMontags := KrankheitstageMontags + 1;

                        krankstandMontags := KrankheitstageMontags / (arbeitsMontage * recDimMitarbeiter.Count);

                    end;
                    recReport.ArbeitstageMontags := arbeitsMontage;
                    recReport.KrankheitstageMontags := krankstandMontags;
                    recReport.KrankenstandMontags := krankstandMontags;
                    recReport.Insert();

                until recTFT.Next() = 0;
        end;


    end;
    //Gibt das Quartal zu dem Monat aus
    procedure Quartalberechnen(Monat: Integer): Integer
    var
        ergbnis: Integer;
    begin
        case Monat of
            1, 2, 3:
                exit(1);
            4, 5, 6:
                exit(2);
            7, 8, 9:
                exit(3);
            10, 11, 12:
                exit(4);
            else
                exit(0);
        end;
    end;

    //Prüft ob es ein Arbeitstag ist
    procedure isWorkday(Datum: Date) return: Boolean
    var
        Rec7602: Record 7602;
        Cu7600: Codeunit 7600;
    begin
        Rec7602."Base Calendar Code" := 'DE';
        return := not Cu7600.IsNonworkingDay(Datum, Rec7602);
    end;

    //Variablen für die Datumsfilter 
    var
        StartDateFilter: Date;
        EndDateFilter: Date;
}


