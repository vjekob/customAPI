table 50101 Vehicle
{
    Caption = 'Vehicle';

    fields
    {
        field(1; Code; Code[10])
        {
            Caption = 'Code';
        }

        field(2; Make; Text[50])
        {
            Caption = 'Make';
        }

        field(3; Model; Text[50])
        {
            Caption = 'Model';
        }

        field(4; Year; Integer)
        {
            Caption = 'Year';

            trigger OnValidate();
            var
                ErrorTooOld: Label 'The vehicle is too old.';
                ErrorNotManufactured: Label 'The vehicle has not been manufactured yet. Please come back in %1 and configure it.';
            begin
                if Year < 2000 then
                    Error(ErrorTooOld);
                if Year > Date2DMY(Today(), 3) then
                    Error(ErrorNotManufactured, Year);
            end;
        }

        field(5; "Registration Plate"; Code[20])
        {
            Caption = 'Registration Plate';
        }

        field(6; "Engine Type"; Option)
        {
            Caption = 'Engine Type';
            OptionMembers = Gasoline,Diesel,Hybrid,Electric;
            OptionCaption = 'Gasoline,Diesel,Hybrid,Electric';
        }

        field(7; "Engine Power"; Decimal)
        {
            Caption = 'Engine Power';
        }

        field(8; "Engine Displacement"; Decimal)
        {
            Caption = 'Engine Displacement';
        }

        field(8000; Id; Guid)
        {
            Caption = 'Id';
            Editable = false;
        }

        field(8001; "Last Modified Date Time"; DateTime)
        {
            Caption = 'Last Modified Date Time';
            Editable = false;
        }
    }

    keys
    {
        key(Primary; Code) { Clustered = true; }
    }

    trigger OnInsert();
    begin
        if not IsNullGuid(Id) then
            Error('Control Id is read-only');

        Id := CreateGuid();
        "Last Modified Date Time" := CurrentDateTime();
    end;

    trigger OnModify();
    begin
        "Last Modified Date Time" := CurrentDateTime();
    end;
}