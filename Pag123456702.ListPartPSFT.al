namespace BA.BA;

page 123456702 ListPartPSFT
{
    ApplicationArea = All;
    Caption = 'ListPartPSFT';
    PageType = ListPart;
    SourceTable = TablePSFT;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Abteilung; Rec.Abteilung)
                {
                    ToolTip = 'Specifies the value of the Abteilung field.', Comment = '%';
                }
                field(AbwesenheitsMontag; Rec.AbwesenheitsMontag)
                {
                    ToolTip = 'Specifies the value of the AbwesenheitsMontag field.', Comment = '%';
                }
                field(Abwesenheitstag; Rec.Abwesenheitstag)
                {
                    ToolTip = 'Specifies the value of the Abwesenheitstag field.', Comment = '%';
                }
                field(GrundID; Rec.GrundID)
                {
                    ToolTip = 'Specifies the value of the GrundID field.', Comment = '%';
                }
                field(Jahr; Rec.Jahr)
                {
                    ToolTip = 'Specifies the value of the Jahr field.', Comment = '%';
                }
                field(MitarbeiterID; Rec.MitarbeiterID)
                {
                    ToolTip = 'Specifies the value of the MitarbeiterID field.', Comment = '%';
                }
                field(Monat; Rec.Monat)
                {
                    ToolTip = 'Specifies the value of the Monat field.', Comment = '%';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.', Comment = '%';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.', Comment = '%';
                }
                field(Tag; Rec.Tag)
                {
                    ToolTip = 'Specifies the value of the Tag field.', Comment = '%';
                }
            }
        }
    }
}
