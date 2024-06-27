namespace BA.BA;

page 123456705 ListPartTFT
{
    ApplicationArea = All;
    Caption = 'ListPartTFT';
    PageType = ListPart;
    SourceTable = TableTFT;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(AbwesenheitsID; Rec.AbwesenheitsID)
                {
                    ToolTip = 'Specifies the value of the AbwesenheitsID field.', Comment = '%';
                }
                field(AbwesenheitsMontag; Rec.AbwesenheitsMontag)
                {
                    ToolTip = 'Specifies the value of the AbwesenheitsMontag field.', Comment = '%';
                }
                field(Datum; Rec.Datum)
                {
                    ToolTip = 'Specifies the value of the Datum field.', Comment = '%';
                }
                field(MitarbeiterID; Rec.MitarbeiterID)
                {
                    ToolTip = 'Specifies the value of the MitarbeiterID field.', Comment = '%';
                }
                field(TFTID; Rec.TFTID)
                {
                    ToolTip = 'Specifies the value of the TFTID field.', Comment = '%';
                }
                field(Wochentag; Rec.Wochentag)
                {
                    ToolTip = 'Specifies the value of the Wochentag field.', Comment = '%';
                }
            }
        }
    }
}
