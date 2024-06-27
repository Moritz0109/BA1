namespace BA.BA;

page 123456708 ListPartReport
{
    ApplicationArea = All;
    Caption = 'ListPartReport';
    PageType = ListPart;
    SourceTable = ReportTable;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Abteilungsname; Rec.Abteilungsname)
                {
                    ToolTip = 'Specifies the value of the Abteilungsname field.', Comment = '%';
                }
                field(ArbeitstageMontags; Rec.ArbeitstageMontags)
                {
                    ToolTip = 'Specifies the value of the ArbeitstageMontags field.', Comment = '%';
                }
                field(DepID; Rec.DepID)
                {
                    ToolTip = 'Specifies the value of the DepID field.', Comment = '%';
                }
                field(KrankenstandMontags; Rec.KrankenstandMontags)
                {
                    ToolTip = 'Specifies the value of the KrankenstandMontags field.', Comment = '%';
                }
                field(KrankheitstageMontags; Rec.KrankheitstageMontags)
                {
                    ToolTip = 'Specifies the value of the KrankheitstageMontags field.', Comment = '%';
                }
                field(Monatsname; Rec.Monatsname)
                {
                    ToolTip = 'Specifies the value of the Monatsname field.', Comment = '%';
                }
                field(MonthID; Rec.MonthID)
                {
                    ToolTip = 'Specifies the value of the MonthID field.', Comment = '%';
                }
            }
        }
    }
}
