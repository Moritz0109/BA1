namespace BA.BA;
using Microsoft.HumanResources.Employee;
using Microsoft.Foundation.Calendar;
using System.Utilities;

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
                part(PSFT; ListPartDimZeit)
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
        Rec7602."Base Calendar Code" := 'DE';
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
                if Rec7602.FindFirst() then
                    if CU7600.IsNonworkingDay(RecDimZeit.Datum, Rec7602) then
                        RecDimZeit.IstArbeitstag := false
                    else
                        RecDimZeit.IstArbeitstag := true
                else
                    Message('Tabelle 7602 leer!');
                RecDimZeit.Insert();

            until RecBasiskalender.Next() = 0;

    end;
    // var
    //     Msg: Label 'Today is %1.\And today is %2.';
    //     DateForWeek: Record Date;
    // begin
    //     if DateForWeek.Get(DateForWeek."Period Type"::Date, Today) then
    //         Message(Msg, StartDateFilter, DateForWeek."Period Name");
    // end;
    procedure Quartalberechnen(Monat: Integer): Integer
    var
        ergbnis: Integer;
    begin
        ergbnis := (Monat / 3 + 1);
        exit(ergbnis);
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


