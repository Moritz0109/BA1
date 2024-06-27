namespace BA.BA;

page 123456707 ListPartDoppelteDatensatz
{
    ApplicationArea = All;
    Caption = 'ListPartDoppelteDatensatz';
    PageType = ListPart;
    SourceTable = DoppelteDatensatz;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Datum; Rec.Datum)
                {
                    ToolTip = 'Specifies the value of the Datum field.', Comment = '%';
                }
                field(MitarbeiterNummer; Rec.MitarbeiterNummer)
                {
                    ToolTip = 'Specifies the value of the MitarbeiterNummer field.', Comment = '%';
                }
            }
        }
    }
}
