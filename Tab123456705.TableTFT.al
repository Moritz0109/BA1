table 123456705 TableTFT
{
    Caption = 'TableTFT';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; TFTID; Integer)
        {
            Caption = 'TFTID';
            DataClassification = CustomerContent;
        }
        field(2; MitarbeiterID; Code[10])
        {
            Caption = 'MitarbeiterID';
            DataClassification = CustomerContent;
        }
        field(3; Datum; Date)
        {
            Caption = 'Datum';
            DataClassification = SystemMetadata;
        }
        field(4; AbwesenheitsID; Integer)
        {
            Caption = 'AbwesenheitsID';
            DataClassification = CustomerContent;
        }
        field(5; Wochentag; Text[15])
        {
            Caption = 'Wochentag';
            DataClassification = CustomerContent;
        }
        field(6; AbwesenheitsMontag; Boolean)
        {
            Caption = 'AbwesenheitsMontag';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; TFTID)
        {
            Clustered = true;
        }
    }
}
