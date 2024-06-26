namespace BA.BA;

page 123456703 ListPartDimZeit
{
    ApplicationArea = All;
    Caption = 'ListPartDimZeit';
    PageType = ListPart;
    SourceTable = DimZeit;

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
                field(Jahr; Rec.Jahr)
                {
                    ToolTip = 'Specifies the value of the Jahr field.', Comment = '%';
                }
                field(Monat; Rec.Monat)
                {
                    ToolTip = 'Specifies the value of the Monat field.', Comment = '%';
                }
                field(NichtArbeitstag; Rec.IstArbeitstag)
                {
                    ToolTip = 'Specifies the value of the IstArbeitstag field.', Comment = '%';
                }
                field(Quartal; Rec.Quartal)
                {
                    ToolTip = 'Specifies the value of the Quartal field.', Comment = '%';
                }
                field(Tag; Rec.Tag)
                {
                    ToolTip = 'Specifies the value of the Tag field.', Comment = '%';
                }
                field(Wochentag; Rec.Wochentag)
                {
                    ToolTip = 'Specifies the value of the Wochentag field.', Comment = '%';
                }
            }
        }
    }
}
