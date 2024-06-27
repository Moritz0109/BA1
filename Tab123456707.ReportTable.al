table 123456707 ReportTable
{
    Caption = 'ReportTable';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; DepID; Code[10])
        {
            Caption = 'DepID';
            DataClassification = CustomerContent;
        }
        field(2; Abteilungsname; Text[50])
        {
            Caption = 'Abteilungsname';
            DataClassification = CustomerContent;
        }
        field(3; MonthID; Code[10])
        {
            Caption = 'MonthID';
            DataClassification = CustomerContent;
        }
        field(4; Monatsname; Text[15])
        {
            Caption = 'Monatsname';
            DataClassification = CustomerContent;
        }
        field(5; ArbeitstageMontags; Integer)
        {
            Caption = 'ArbeitstageMontags';
            DataClassification = CustomerContent;
        }
        field(6; KrankheitstageMontags; Integer)
        {
            Caption = 'KrankheitstageMontags';
            DataClassification = CustomerContent;
        }
        field(7; KrankenstandMontags; Decimal)
        {
            Caption = 'KrankenstandMontags';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; DepID,MonthID)
        {
            Clustered = true;
        }
    }
}
