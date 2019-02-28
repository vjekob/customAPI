page 50102 Vehicles
{
    Caption = 'Vehicles';
    PageType = List;
    SourceTable = Vehicle;
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(Vehicles)
            {
                field(Code; Code) { ApplicationArea = All; }
                field(Make; Make) { ApplicationArea = All; }
                field(Model; Model) { ApplicationArea = All; }
                field(Year; Year) { ApplicationArea = All; }
                field("Registration Plate"; "Registration Plate") { ApplicationArea = All; }
                field("Engine Type"; "Engine Type") { ApplicationArea = All; }
                field("Engine Power"; "Engine Power") { ApplicationArea = All; }
                field("Engine Displacement"; "Engine Displacement") { ApplicationArea = All; }
            }
        }
    }
}