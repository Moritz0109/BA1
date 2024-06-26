table 123456703 TableASFT
{
    Caption = 'TableASFT';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ASFTID; Integer)
        {
            Caption = 'ASFTID';
            DataClassification = CustomerContent;
        }
        field(2; MitarbeiterID; Code[10])
        {
            Caption = 'MitarbeiterID';
            DataClassification = CustomerContent;
        }
        field(3; BeginAbwesenheit; Date)
        {
            Caption = 'BeginAbwesenheit';
            DataClassification = CustomerContent;
        }
        field(4; EndeAbwesenheit; Date)
        {
            Caption = 'EndeAbwesenheit';
            DataClassification = CustomerContent;
        }
        field(5; GrundID; Integer)
        {
            Caption = 'GrundID';
            DataClassification = CustomerContent;
        }
        field(6; Dauer; Integer)
        {
            Caption = 'Dauer';
            DataClassification = CustomerContent;
        }
        field(7; Messeinheit; Text[15])
        {
            Caption = 'Messeinheit';
            DataClassification = CustomerContent;
        }
        field(8; AbwesenheitsMontage; Integer)
        {
            Caption = 'AbwesenheitsMontage';
            DataClassification = CustomerContent;
        }
        field(9; Abteilung; Code[10])
        {
            Caption = 'Abteilung';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; ASFTID, MitarbeiterID)
        {
            Clustered = true;
        }
    }
}
