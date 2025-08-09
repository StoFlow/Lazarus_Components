{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit FontCombo;

{$warn 5023 off : no warning about unused units}
interface

uses
  fontcomboImpl, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('fontcomboImpl', @fontcomboImpl.Register);
end;

initialization
  RegisterPackage('FontCombo', @Register);
end.
