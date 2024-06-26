table 123456701 DimMitarbeiter
{
    Caption = 'DimMitarbeiter';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; MitarbeiterNummer; Code[10])
        {
            Caption = 'MitarbeiterNummer';
            DataClassification = CustomerContent;
        }
        field(2; Vorname; Text[30])
        {
            Caption = 'Vorname';
            DataClassification = CustomerContent;
        }
        field(3; Nachname; Text[30])
        {
            Caption = 'Nachname';
            DataClassification = CustomerContent;
        }
        field(4; MitarbeiterInitailien; Text[2])
        {
            Caption = 'MitarbeiterInitailien';
            DataClassification = CustomerContent;
        }
        field(5; Berufsbezeichnung; Text[30])
        {
            Caption = 'Berufsbezeichnung';
            DataClassification = CustomerContent;
        }
        field(6; Strasse; Text[50])
        {
            Caption = 'Strasse';
            DataClassification = CustomerContent;
        }
        field(7; Hausnummer; Integer)
        {
            Caption = 'Hausnummer';
            DataClassification = CustomerContent;
        }
        field(8; PLZ; Integer)
        {
            Caption = 'PLZ';
            DataClassification = CustomerContent;
        }
        field(9; Ort; Text[50])
        {
            Caption = 'Ort';
            DataClassification = CustomerContent;
        }
        field(10; Land; Text[3])
        {
            Caption = 'Land';
            DataClassification = CustomerContent;
        }
        field(11; Telefon; Integer)
        {
            Caption = 'Telefon';
            DataClassification = CustomerContent;
        }
        field(12; Geburtstag; Date)
        {
            Caption = 'Geburtstag';
            DataClassification = CustomerContent;
        }
        field(13; Einstellungstag; Date)
        {
            Caption = 'Einstellungstag';
            DataClassification = CustomerContent;
        }
        field(14; Abteilung; Text[30])
        {
            Caption = 'Abteilung';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; MitarbeiterNummer)
        {
            Clustered = true;
        }
    }
}
