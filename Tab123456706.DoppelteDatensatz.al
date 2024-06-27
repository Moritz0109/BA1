table 123456706 DoppelteDatensatz
{
    Caption = 'DoppelteDatensatz';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
            DataClassification = CustomerContent;
        }
        field(2; MitarbeiterNummer; Code[10])
        {
            Caption = 'MitarbeiterNummer';
            DataClassification = CustomerContent;
        }
        field(3; Datum; Date)
        {
            Caption = 'Datum';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; ID,MitarbeiterNummer,Datum)
        {
            Clustered = true;
        }
    }
}
