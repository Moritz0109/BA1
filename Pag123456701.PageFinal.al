namespace BA.BA;
using Microsoft.HumanResources.Employee;
using Microsoft.Foundation.Calendar;
using System.Utilities;
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
                    Caption = 'Berechnung PSFT';
                    ToolTip = 'Füllt die PSFT Tabelle';
                    trigger
                    OnAction()
                    begin
                        fillDimMitarbeiter();
                        fillDimZeit();
                        fillDimAbwesenheitsgrund();
                        fillPSFT();
                        fillTFT();
                        Message('Erfolgreich geladen');
                    end;


                }
            }
        }
    }

    procedure fillDimMitarbeiter()
    var
        RecMitarbeiter: Record Employee;
        RecDimMitarbeiter: Record DimMitarbeiter;
    begin
        RecDimMitarbeiter.DeleteAll();
        if RecMitarbeiter.FindSet() then
            repeat
                RecDimMitarbeiter.Init();
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
                RecDimMitarbeiter.Insert();
            until RecMitarbeiter.Next() = 0;
    end;

    procedure fillDimZeit()
    var
        RecDimZeit: Record DimZeit;
        RecBasiskalender: Record Date;
        CU7600: Codeunit 7600;
        Rec7602: Record 7602;
    begin
        RecDimZeit.DeleteAll();
        RecBasiskalender.SetRange(RecBasiskalender."Period Type", 0);
        // //Fehlerhandling erforderlich!!!
        RecBasiskalender.SetFilter("Period Start", '%1..%2', StartDateFilter, EndDateFilter);
        if RecBasiskalender.FindSet() then
            repeat
                RecDimZeit.Datum := RecBasiskalender."Period Start";
                RecDimZeit.Wochentag := Format(RecBasiskalender."Period Start", 0, '<Weekday Text>');
                RecDimZeit.Tag := Date2DMY(RecBasiskalender."Period Start", 1);
                RecDimZeit.Monat := Date2DMY(RecBasiskalender."Period Start", 2);
                RecDimZeit.Jahr := Date2DMY(RecBasiskalender."Period Start", 3);
                RecDimZeit.Quartal := Quartalberechnen(RecDimZeit.Monat);
                RecDimZeit.IstArbeitstag := isWorkday(RecBasiskalender."Period Start");
                RecDimZeit.Insert();

            until RecBasiskalender.Next() = 0;

    end;

    procedure fillDimAbwesenheitsgrund()
    var
        RecDimAbwesenheitsgrund: Record DimAbwesenheitsgrund;
        RecAbwesenheitsgrund: Record 5206;
    begin
        RecDimAbwesenheitsgrund.DeleteAll();
        if RecAbwesenheitsgrund.FindSet() then
            repeat
                RecDimAbwesenheitsgrund.Init();
                RecDimAbwesenheitsgrund.GrundID := RecAbwesenheitsgrund.Code;
                RecDimAbwesenheitsgrund.Grundbezeichnung := RecAbwesenheitsgrund.Description;
                RecDimAbwesenheitsgrund.Insert()
            until RecAbwesenheitsgrund.Next() = 0;
    end;

    procedure fillPSFT()
    var
        recPSFT: Record TablePSFT;
        recDimZeit: Record DimZeit;
        recDimMitarbeiter: Record DimMitarbeiter;
        recDimAbwesenheitsgrund: Record DimAbwesenheitsgrund;
        recAbwesenheitRoh: Record "Employee Absence";
    begin
        recPSFT.DeleteAll();
        if recDimZeit.FindSet() then
            repeat
                if recDimMitarbeiter.FindSet() then
                    repeat
                        // if recDimAbwesenheitsgrund.FindSet() then
                        //     repeat
                        recPSFT.Init();
                        recPSFT.Tag := recDimZeit.Tag;
                        recPSFT.Monat := recDimZeit.Monat;
                        recPSFT.Jahr := recDimZeit.Jahr;
                        recPSFT.MitarbeiterID := recDimMitarbeiter.MitarbeiterNummer;
                        recPSFT.Abteilung := recDimMitarbeiter.Abteilung;
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
                    // until recDimAbwesenheitsgrund.Next() = 0;
                    until recDimMitarbeiter.Next() = 0;
            until recDimZeit.Next() = 0;
    end;

    procedure fillTFT()
    var
        recTFT: Record TableTFT;
        recDimZeit: Record DimZeit;
        recDimMitarbeiter: Record DimMitarbeiter;
        recDimAbwesenheitsgrund: Record DimAbwesenheitsgrund;
        recAbwesenheitRoh: Record "Employee Absence";
        TFTID: Integer;
    begin
        recTFT.DeleteAll();
        TFTID := 1;
        recAbwesenheitRoh.SetRange("From Date", StartDateFilter, EndDateFilter);
        if recAbwesenheitRoh.FindSet() then
            repeat
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
        recASFT: Record TableTFT;
        recDimZeit: Record DimZeit;
        recDimMitarbeiter: Record DimMitarbeiter;
        recDimAbwesenheitsgrund: Record DimAbwesenheitsgrund;
        recAbwesenheitRoh: Record "Employee Absence";
    begin
        recASFT.DeleteAll();


    end;

    procedure doppeltDatensatz()
    var
        recAbwesenheitRoh: Record "Employee Absence";
        recHilfsTabelle: Record "Employee Absence";
    begin

    end;

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

    procedure isWorkday(Datum: Date) return: Boolean
    var
        Rec7602: Record 7602;
        Cu7600: Codeunit 7600;
    begin
        Rec7602."Base Calendar Code" := 'DE';
        return := not Cu7600.IsNonworkingDay(Datum, Rec7602);
    end;

    var
        StartDateFilter: Date;
        EndDateFilter: Date;
}


