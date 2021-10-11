{
Application: LockDisk
Auteur: Gladis NDOUAB'S
Pseudo CodesSources: Diglas
e-mail: gndouabs@hotmail.de
Version 1.1 Copyrigth Mai 2010
Description: Avez-vous deja eu envie d'interdire au gens la lecture d'un de vos
             CD ou DVD préféré sur votre PC? Eh bien! voici une solution.
             Comme le nom l'indique, ce programme vous permet d'interdire sinon
             de bloquer un CD/DVD inséré sur l'un de vos lecteur CD/DVD.
             le principe est simple:
             - il scanne tous vos lecteurs optiques au lancement
             - vous lui indiquez les CD/DVD à bloquer en les insérant a tour de
               rôle et en cliquant à chaque fois sur le boutton Bloquer.
             - A chaque fois qu'il détectera l'un des CD/DVD bloqué, il l'ejectera
               du lecteur optique.
             - pour débloquer un CD/DVD, un mot de passe est nécéssaire (mot de passe
               saisi au premier lancement de l'application sur votre PC)    
}
unit F_LockDisk;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, NDMD5Utils, ExtCtrls, Grids, ValEdit, Buttons,
  NDUtils, NDTypes, Menus, Registry;

type
  TForm_LockDisk = class(TForm)
    Rafraichisseur: TTimer;
    Bloc_Infos: TGroupBox;
    SerialNumber: TLabel;
    Hachage: TLabel;
    TotalSpace: TLabel;
    SelectDrive: TComboBox;
    Bloc_liste: TGroupBox;
    Liste_Autorisee: TValueListEditor;
    Bloc_Autorisation: TGroupBox;
    Btn_Enlever: TSpeedButton;
    Btn_Autoriser: TSpeedButton;
    PMenu: TPopupMenu;
    PM1: TMenuItem;
    PM5: TMenuItem;
    MMenu: TMainMenu;
    MM1: TMenuItem;
    MM1_4: TMenuItem;
    MM1_3: TMenuItem;
    PM4: TMenuItem;
    MM1_2: TMenuItem;
    MM1_1: TMenuItem;
    PM3: TMenuItem;
    PM2: TMenuItem;
    Bloc_Surveillance: TGroupBox;
    Btn_Desactiver: TSpeedButton;
    Btn_Activer: TSpeedButton;
    Locker: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Liste_AutoriseeClick(Sender: TObject);
    procedure Btn_AutoriserClick(Sender: TObject);
    procedure Btn_EnleverClick(Sender: TObject);
    procedure SelectDriveChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RafraichisseurTimer(Sender: TObject);
    procedure PM5Click(Sender: TObject);
    procedure PM1Click(Sender: TObject);
    procedure NDTrayIcon1Minimize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MM1_4Click(Sender: TObject);
    procedure MM1_3Click(Sender: TObject);
    procedure MM1_2Click(Sender: TObject);
    procedure MM1_1Click(Sender: TObject);
    procedure Btn_ActiverClick(Sender: TObject);
    procedure Btn_DesactiverClick(Sender: TObject);
    procedure LockerTimer(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    function GetLecteurCD: TStrings;
    procedure Afficher;
  end;

var
  Form_LockDisk: TForm_LockDisk;
  InfosDisk: TInfosCD;
  DriveList,Valeur_mdp:string;
  MinimiseOnstart,StartWithWindows:boolean;
implementation

{$R *.dfm}

{Scanne et renvoi la liste des lecteurs optique sur votre PC}
function TForm_LockDisk.GetLecteurCD: TStrings;
var Lecteur: char;
begin
 Result:= TStringList.Create;
 DriveList:='';
 for Lecteur := 'A' to 'Z' do
  if (GetDriveType(PChar(Lecteur + ':\')) = DRIVE_CDROM) then
  begin
   Result.Add(format('%s%s%s%s%s',[Lecteur,':','[',String(GetInfosCD(Lecteur).Name),']']));
   DriveList:= DriveList + Lecteur;
  end;
end;

{Affiche sur la forme les informations du disque inséré}
procedure TForm_LockDisk.Afficher;
var pos:integer;
begin
 InfosDisk:=GetInfosCD(SelectDrive.Text);
 SerialNumber.Caption := 'Numéro de Série : '+inttostr(InfosDisk.SerialNummer);
 TotalSpace.Caption := 'Taille: '+OctetAutoConvert(InfosDisk.TotalSpace)+' de capacité';
 Hachage.Caption:='Hachage: '+InfosDisk.Hachage;
{Trouve le disque inséré dans la liste des disques autorisés s'il y en a et renvoi sa position}
 Liste_Autorisee.FindRow(InfosDisk.Hachage,pos);
{Définie l'accès aux boutton Autoriser et Enlever}
 Bloc_Autorisation.Enabled:=not (InfosDisk.SerialNummer = 0);
{Réinitialise les bouttons} 
 Btn_Autoriser.Enabled:=(pos < 0);
 Btn_Enlever.Enabled:=(pos >= 0);
end;

procedure TForm_LockDisk.FormCreate(Sender: TObject);
var pos,FileHandle:Integer;
begin
{On crée le fichier de configuration s'il n'existe pas}
 if not fileexists('Cfg.kcd') then
 begin
  FileHandle :=FileCreate('Cfg.kcd');
  FileClose(FileHandle);
 end;
{On charge le fichier de configuration après l'avoir décrypté}
 if CrypterF('Cfg.kcd','Cfg.tmp','Liste des CD/DVD autorisés') then
 begin
  Liste_Autorisee.Strings.LoadFromFile('cfg.tmp');
  Deletefile('Cfg.tmp');
 end;

 {Vous permet de créer votre mot de passe de déblocage au premier lancement}
 if not Liste_Autorisee.FindRow('Mdp',pos) then
 begin
  messagedlg('Bienvenu! Avant la première utilisation, '#10#13'vous devez créer un mot de passe pour pouvoir débloquer un CD/DVD.',mtInformation,[mbOk],0);
  Valeur_mdp:=inputbox('Création de mot de passe','Entrez le mot de passe à créer:','');
 end
 else
 begin
  Valeur_mdp:= Liste_Autorisee.Values['Mdp'];
  Liste_Autorisee.DeleteRow(pos);
 end;

 { Récuperation des options de l'application}
 if Liste_Autorisee.FindRow('Mad',pos) then
 begin
  MinimiseOnstart:= strtobool(Liste_Autorisee.Values['Mad']);
  Liste_Autorisee.DeleteRow(pos);
 end
 else
  MinimiseOnstart:= False;

 if Liste_Autorisee.FindRow('Lad',pos) then
 begin
  StartWithWindows:= strtobool(Liste_Autorisee.Values['Lad']);
  Liste_Autorisee.DeleteRow(pos);
 end
 else
  StartWithWindows:= False;
 {Mise à jour des menus}
 MM1_2.Checked:=MinimiseOnstart;
 PM3.Checked:=MinimiseOnstart;
 MM1_1.Checked:= StartWithWindows;
 PM2.Checked:= StartWithWindows;
 {Actualise la liste des lecteurs optiques}
 SelectDrive.Items:= GetLecteurCD;
 SelectDrive.ItemIndex:=0;
 Afficher;
 {Mise à jour des bouttons}
 Btn_Activer.Enabled:= false;
 Btn_Desactiver.Enabled:= true;
 Btn_Autoriser.Enabled:= true;
 Btn_Enlever.Enabled:= false;
 {Mise à jour des compteurs}
 Rafraichisseur.Enabled:=true;
 Locker.Enabled:=true;
end;

{Vous permet de sélectionner un CD/DVD sur la liste autorisée pendant 5 secondes
 afin de vous permettre d'enlever l'autorisation}
procedure TForm_LockDisk.Liste_AutoriseeClick(Sender: TObject);
begin
 Bloc_Autorisation.Enabled:=(Liste_Autorisee.Keys[Liste_Autorisee.Row]<>'');
 Btn_Autoriser.Enabled:=not Bloc_Autorisation.Enabled;
 Btn_Enlever.Enabled:=Bloc_Autorisation.Enabled;
 Rafraichisseur.Interval:=5000;
end;

{Autoriser un CD/DVD après avoir entrer le mode de passe de déblocage}
procedure TForm_LockDisk.Btn_AutoriserClick(Sender: TObject);
var pos:integer;
begin
 if messagedlg('Êtes vous sûr de vouloir autoriser ce CD/DVD "'+Infosdisk.Name+
               '"?',mtConfirmation,[mbYes,mbNo],0)=mrNO then
  exit;
 Btn_Enlever.Enabled:= not Btn_Enlever.Enabled;
 Btn_Autoriser.Enabled:= not Btn_Autoriser.Enabled;
 if (Liste_Autorisee.FindRow(InfosDisk.Hachage,pos)=true)or(InfosDisk.Hachage='')
    or(InfosDisk.SerialNummer=0)then exit;
 Liste_Autorisee.InsertRow(InfosDisk.Hachage,InfosDisk.Name,true);
end;

{Enlever l'autorisation d'un CD/DVD apres avoir entrer le mot de passe de déblocage}
procedure TForm_LockDisk.Btn_EnleverClick(Sender: TObject);
begin
 if messagedlg('Êtes vous sûr de vouloir enlever l''autorisation de ce CD/DVD "'+Liste_Autorisee.Cells[1,Liste_Autorisee.row]+'"?',mtConfirmation,[mbYes,mbNo],0)=mrNO then
  exit;
 Btn_Enlever.Enabled:= not Btn_Enlever.Enabled;
 Btn_Autoriser.Enabled:= not Btn_Autoriser.Enabled;
 Liste_Autorisee.DeleteRow(Liste_Autorisee.Row);
end;

{Actualise les infos du CD/DVD au changement du lecteur optique}
procedure TForm_LockDisk.SelectDriveChange(Sender: TObject);
begin
 Afficher;
end;

procedure TForm_LockDisk.FormClose(Sender: TObject; var Action: TCloseAction);
var Reg:TRegistry;
begin
 Rafraichisseur.Enabled:=false;
 Reg :=TRegistry.Create;
 try
  Reg.RootKey :=HKEY_LOCAL_MACHINE;
  Reg.Access:= KEY_ALL_ACCESS;
  if Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Run',false)then
  begin
   if (not Reg.ValueExists('LockDisk'))and StartWithWindows then
    Reg.WriteString('LockDisk','"'+ParamStr(0)+'"');
   if Reg.ValueExists('LockDisk')and (not StartWithWindows) then
    Reg.DeleteValue('LockDisk');
   Reg.CloseKey;
  end;
 finally
  Reg.Free;
 end; 
 Liste_Autorisee.InsertRow('Mdp',Valeur_mdp,True);
 Liste_Autorisee.InsertRow('Mad',booltostr(MinimiseOnstart,True),True);
 Liste_Autorisee.InsertRow('Lad',booltostr(StartWithWindows,True),True);
 Liste_Autorisee.Strings.SaveToFile('cfg.tmp');
 if CrypterF('Cfg.tmp','Cfg.kcd','Liste des CD/DVD autorisés') then
  Deletefile('Cfg.tmp');
end;

procedure TForm_LockDisk.RafraichisseurTimer(Sender: TObject);
var pos:integer;
begin
 if Rafraichisseur.Tag = 0 then
 begin
  Rafraichisseur.Tag:= 1;
 end;

 if Rafraichisseur.Interval = 5000 then
  Rafraichisseur.Interval:=1000;
 pos:= SelectDrive.ItemIndex;
 SelectDrive.Items:= GetLecteurCD;
 SelectDrive.ItemIndex:= pos;
 Afficher;
end;

procedure TForm_LockDisk.PM5Click(Sender: TObject);
begin
 close;
end;

procedure TForm_LockDisk.PM1Click(Sender: TObject);
begin
 if PMenu.Items[0].Caption = '&Afficher' then
 begin
  PMenu.Items[0].Caption:='&Cacher';
 end
 else
 begin
  PMenu.Items[0].Caption:='&Afficher';
 end;
end;

procedure TForm_LockDisk.NDTrayIcon1Minimize(Sender: TObject);
begin
 PMenu.Items[0].Caption:='&Afficher';
  Form_LockDisk.Hide;
end;

procedure TForm_LockDisk.FormShow(Sender: TObject);
begin
 PMenu.Items[0].Caption:='&Cacher';
end;

procedure TForm_LockDisk.MM1_4Click(Sender: TObject);
begin
 close;
end;

procedure TForm_LockDisk.MM1_3Click(Sender: TObject);
var Amdp:string;
    rep:integer;
begin
 rep:=mrYes;
 repeat
  Amdp:=inputbox('Changement de mot de passe','Entrez l''ancien mot de passe:','');
  if Amdp<>Valeur_mdp then
   rep:=messagedlg('Ancien mot de passe incorrect!'#10#13'Voulez vous continuer?',
                    mtError,[mbYes,mbNo],0);
 until (Amdp=Valeur_mdp)or(rep=mrNo);
 if rep=mrNO then exit;
 Valeur_mdp:=inputbox('Changement de mot de passe','Entrez le nouveau mot de passe:','');
end;

procedure TForm_LockDisk.MM1_2Click(Sender: TObject);
begin
 MM1_2.Checked:=not MM1_2.Checked;
 PM3.Checked:=not PM3.Checked;
 MinimiseOnstart:= not MinimiseOnstart;
end;

procedure TForm_LockDisk.MM1_1Click(Sender: TObject);
begin
 MM1_1.Checked:= not MM1_1.Checked;
 PM2.Checked:= not PM2.Checked;
 StartWithWindows:= not StartWithWindows;
end;

procedure TForm_LockDisk.Btn_ActiverClick(Sender: TObject);
begin
 Btn_Activer.Enabled:= not Btn_Activer.Enabled;
 Btn_Desactiver.Enabled:= not Btn_Desactiver.Enabled;
 Locker.Enabled:=true;
end;

procedure TForm_LockDisk.Btn_DesactiverClick(Sender: TObject);
begin
 if Valeur_mdp<>inputbox('Mot de passe d''accès','Entrez le mot de passe de débloquage:','') then
 begin
  messagedlg('Mot de passe de débloquage incorrect!',mtError,[mbOK],0);
  exit;
 end; 
 Btn_Activer.Enabled:= not Btn_Activer.Enabled;
 Btn_Desactiver.Enabled:= not Btn_Desactiver.Enabled;
 Locker.Enabled:=false;
end;

procedure TForm_LockDisk.LockerTimer(Sender: TObject);
var i, pos: integer;
    DriveInfos: TInfosCD;
begin
 for i:= 1 to length(DriveList) do
 begin
  DriveInfos:= GetInfosCD(DriveList[i]);
  if(not Liste_Autorisee.FindRow(DriveInfos.Hachage,pos))and(DriveInfos.SerialNummer<>0) then
  begin
   OpenDoor(DriveList[i]);
   messagedlg('Ce CD/DVD "'+DriveInfos.Name+'" est bloqué sur cet ordinateur!',mtWarning,[mbOk],0);
  end;
 end;
end;

end.
