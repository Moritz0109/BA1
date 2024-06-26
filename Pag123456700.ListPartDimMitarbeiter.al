namespace BA.BA;

page 123456700 ListPartDimMitarbeiter
{
    ApplicationArea = All;
    Caption = 'ListPartDimMitarbeiter';
    PageType = ListPart;
    SourceTable = DimMitarbeiter;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Abteilung; Rec.Abteilung)
                {
                    ToolTip = 'Specifies the value of the Abteilung field.', Comment = '%';
                }
                field(Berufsbezeichnung; Rec.Berufsbezeichnung)
                {
                    ToolTip = 'Specifies the value of the Berufsbezeichnung field.', Comment = '%';
                }
                field(Einstellungstag; Rec.Einstellungstag)
                {
                    ToolTip = 'Specifies the value of the Einstellungstag field.', Comment = '%';
                }
                field(Geburtstag; Rec.Geburtstag)
                {
                    ToolTip = 'Specifies the value of the Geburtstag field.', Comment = '%';
                }
                field(Land; Rec.Land)
                {
                    ToolTip = 'Specifies the value of the Land field.', Comment = '%';
                }
                field(MitarbeiterInitailien; Rec.MitarbeiterInitailien)
                {
                    ToolTip = 'Specifies the value of the MitarbeiterInitailien field.', Comment = '%';
                }
                field(MitarbeiterNummer; Rec.MitarbeiterNummer)
                {
                    ToolTip = 'Specifies the value of the MitarbeiterNummer field.', Comment = '%';
                }
                field(Nachname; Rec.Nachname)
                {
                    ToolTip = 'Specifies the value of the Nachname field.', Comment = '%';
                }
                field(Ort; Rec.Ort)
                {
                    ToolTip = 'Specifies the value of the Ort field.', Comment = '%';
                }
                field(PLZ; Rec.PLZ)
                {
                    ToolTip = 'Specifies the value of the PLZ field.', Comment = '%';
                }
                field(Telefon; Rec.Telefon)
                {
                    ToolTip = 'Specifies the value of the Telefon field.', Comment = '%';
                }
                field(Vorname; Rec.Vorname)
                {
                    ToolTip = 'Specifies the value of the Vorname field.', Comment = '%';
                }
            }
        }
    }
}
