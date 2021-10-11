program LockDisk;

uses
  Forms,
  F_LockDisk in 'F_LockDisk.pas' {Form_LockDisk};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'LockDisk';
  Application.CreateForm(TForm_LockDisk, Form_LockDisk);
  Application.Run;
end.
