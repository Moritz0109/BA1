table 123456700 DimZeit
{
    Caption = 'DimZeit';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Datum; Date)
        {
            Caption = 'Datum';
            DataClassification = SystemMetadata;
        }
        field(2; Wochentag; Text[20])
        {
            Caption = 'Wochentag';
            DataClassification = CustomerContent;
        }
        field(3; Tag; Integer)
        {
            Caption = 'Tag';
            DataClassification = CustomerContent;
        }
        field(4; Monat; Integer)
        {
            Caption = 'Monat';
            DataClassification = CustomerContent;
        }
        field(5; Quartal; Integer)
        {
            Caption = 'Quartal';
            DataClassification = CustomerContent;
        }
        field(6; Jahr; Integer)
        {
            Caption = 'Jahr';
            DataClassification = CustomerContent;
        }
        field(7; NichtArbeitstag; Boolean)
        {
            Caption = 'IstArbeitstag';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; Datum)
        {
            Clustered = true;
        }
    }
}
