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
        tmpDate: Date;
    begin
        RecDimZeit.DeleteAll();
        RecBasiskalender.SetRange(RecBasiskalender."Period Type", 0);
        // //Fehlerhandling erforderlich!!!
        RecBasiskalender.SetFilter("Period Start", '%1..%2', StartDateFilter, EndDateFilter);
        RecBasiskalender.FindSet();
        RecDimZeit.Datum := RecBasiskalender."Period Start";
        RecBasiskalender.Next();
        RecDimZeit.Datum := RecBasiskalender."Period Start";

    end;


    var
        StartDateFilter: Date;
        EndDateFilter: Date;
}


