table 123456702 DimAbwesenheitsgrund
{
    Caption = 'DimAbwesenheitsgrund';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; GrundID; Code[10])
        {
            Caption = 'GrundID';
            DataClassification = CustomerContent;
        }
        field(2; Grundbezeichnung; Text[30])
        {
            Caption = 'Grundbezeichnung';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; GrundID)
        {
            Clustered = true;
        }
    }
}
