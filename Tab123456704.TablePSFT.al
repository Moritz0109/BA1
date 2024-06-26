table 123456704 TablePSFT
{
    Caption = 'TablePSFT';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Tag; Integer)
        {
            Caption = 'Tag';
            DataClassification = CustomerContent;
        }
        field(2; MitarbeiterID; Code[10])
        {
            Caption = 'MitarbeiterID';
            DataClassification = CustomerContent;
        }
        field(3; Monat; Integer)
        {
            Caption = 'Monat';
            DataClassification = CustomerContent;
        }
        field(4; Jahr; Integer)
        {
            Caption = 'Jahr';
            DataClassification = CustomerContent;
        }
        field(5; Abteilung; Code[10])
        {
            Caption = 'Abteilung';
            DataClassification = CustomerContent;
        }
        field(6; Abwesenheitstag; Boolean)
        {
            Caption = 'Abwesenheitstag';
            DataClassification = CustomerContent;
        }
        field(7; GrundID; Integer)
        {
            Caption = 'GrundID';
            DataClassification = CustomerContent;
        }
        field(8; AbwesenheitsMontag; Boolean)
        {
            Caption = 'AbwesenheitsMontag';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; Tag, MitarbeiterID, Monat, Jahr)
        {
            Clustered = true;
        }
    }
}
