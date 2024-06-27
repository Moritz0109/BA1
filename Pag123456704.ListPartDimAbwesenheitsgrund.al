namespace BA.BA;

page 123456704 ListPartDimAbwesenheitsgrund
{
    ApplicationArea = All;
    Caption = 'ListPartDimAbwesenheitsgrund';
    PageType = ListPart;
    SourceTable = DimAbwesenheitsgrund;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(GrundID; Rec.GrundID)
                {
                    ToolTip = 'Specifies the value of the GrundID field.', Comment = '%';
                }
                field(Grundbezeichnung; Rec.Grundbezeichnung)
                {
                    ToolTip = 'Specifies the value of the Grundbezeichnung field.', Comment = '%';
                }
            }
        }
    }
}
