namespace BA.BA;

using System.Utilities;

page 123456704 Testing
{
    ApplicationArea = All;
    Caption = 'Testing';
    PageType = Card;
    SourceTable = "Date";
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("Period End"; Rec."Period End")
                {
                    ToolTip = 'Specifies the value of the Period End field.', Comment = '%';
                }
                field("Period Invariant Name"; Rec."Period Invariant Name")
                {
                    ToolTip = 'Specifies the value of the Period Invariant Name field.', Comment = '%';
                }
                field("Period Name"; Rec."Period Name")
                {
                    ToolTip = 'Specifies the name of the period shown in the line.';
                }
                field("Period No."; Rec."Period No.")
                {
                    ToolTip = 'Specifies the value of the Period No. field.', Comment = '%';
                }
                field("Period Start"; Rec."Period Start")
                {
                    ToolTip = 'Specifies the starting date of the period that you want to view.';
                }
                field("Period Type"; Rec."Period Type")
                {
                    ToolTip = 'Specifies the value of the Period Type field.', Comment = '%';
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
            }
        }
    }
}
