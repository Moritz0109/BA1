namespace BA.BA;

page 123456706 ListPartASFT
{
    ApplicationArea = All;
    Caption = 'ListPartASFT';
    PageType = ListPart;
    SourceTable = TableASFT;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(ASFTID; Rec.ASFTID)
                {
                    ToolTip = 'Specifies the value of the ASFTID field.', Comment = '%';
                }
                field(Abteilung; Rec.Abteilung)
                {
                    ToolTip = 'Specifies the value of the Abteilung field.', Comment = '%';
                }
                field(AbwesenheitsMontage; Rec.AbwesenheitsMontage)
                {
                    ToolTip = 'Specifies the value of the AbwesenheitsMontage field.', Comment = '%';
                }
                field(BeginAbwesenheit; Rec.BeginAbwesenheit)
                {
                    ToolTip = 'Specifies the value of the BeginAbwesenheit field.', Comment = '%';
                }
                field(Dauer; Rec.Dauer)
                {
                    ToolTip = 'Specifies the value of the Dauer field.', Comment = '%';
                }
                field(EndeAbwesenheit; Rec.EndeAbwesenheit)
                {
                    ToolTip = 'Specifies the value of the EndeAbwesenheit field.', Comment = '%';
                }
                field(GrundID; Rec.GrundID)
                {
                    ToolTip = 'Specifies the value of the GrundID field.', Comment = '%';
                }
                field(Messeinheit; Rec.Messeinheit)
                {
                    ToolTip = 'Specifies the value of the Messeinheit field.', Comment = '%';
                }
                field(MitarbeiterID; Rec.MitarbeiterID)
                {
                    ToolTip = 'Specifies the value of the MitarbeiterID field.', Comment = '%';
                }
            }
        }
    }
}
