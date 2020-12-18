unit main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Ani,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TForm1 = class(TForm)
    Rectangle_background1: TRectangle;
    Rectangle_background2: TRectangle;
    FloatAnimation_background1: TFloatAnimation;
    FloatAnimation_background2: TFloatAnimation;
    Rectangle_player: TRectangle;
    Rectangle_missile: TRectangle;
    FloatAnimation_player_y: TFloatAnimation;
    FloatAnimation_missile: TFloatAnimation;
    Button_up: TButton;
    Button_down: TButton;
    Button_missile: TButton;
    Rectangle_Startscene: TRectangle;
    Button_Start: TButton;
    ColorAnimation1: TColorAnimation;
    FloatAnimation_player_x: TFloatAnimation;
    Text1: TText;
    Rectangle_Enm1: TRectangle;
    BitmapAnimation_Enm1: TBitmapAnimation;
    Timer_Enms: TTimer;
    FloatAnimation_Enm1: TFloatAnimation;
    Rectangle_Enm2: TRectangle;
    BitmapAnimation_Enm2: TBitmapAnimation;
    FloatAnimation_Enm2: TFloatAnimation;
    Rectangle_Enm3: TRectangle;
    BitmapAnimation_Enm3: TBitmapAnimation;
    FloatAnimation_Enm3: TFloatAnimation;
    Rectangle_enm_laserbeam: TRectangle;
    FloatAnimation_Enm_laserbeam: TFloatAnimation;
    Timer_Enms_laserBeam: TTimer;
    Timer_gameover: TTimer;
    Label_score: TLabel;
    procedure FloatAnimation_background2Finish(Sender: TObject);
    procedure FloatAnimation_background1Finish(Sender: TObject);
    procedure Button_upClick(Sender: TObject);
    procedure Button_downClick(Sender: TObject);
    procedure Button_missileClick(Sender: TObject);
    procedure FloatAnimation_missileFinish(Sender: TObject);
    procedure Button_StartClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer_EnmsTimer(Sender: TObject);
    procedure FloatAnimation_Enm1Finish(Sender: TObject);
    procedure FloatAnimation_Enm2Finish(Sender: TObject);
    procedure FloatAnimation_Enm3Finish(Sender: TObject);
    procedure Timer_Enms_laserBeamTimer(Sender: TObject);
    procedure FloatAnimation_Enm_laserbeamFinish(Sender: TObject);
    procedure Timer_gameoverTimer(Sender: TObject);
    procedure FloatAnimation_player_xFinish(Sender: TObject);


    //procedure BitmapAnimation_Enm2Finish(Sender: TObject);
    //procedure Rectangle_StartsceneClick(Sender: TObject);
  private
    { private �錾 }
  procedure game_reset;

  public
    { public �錾 }
  end;

var
  Form1: TForm1;
  KanokeBuf:TRectangle=nil;
  FiTotal: Integer = 0;
  FdtPlay : TDatetime = 0;

implementation

{$R *.fmx}
const missile_max = 900;

procedure TForm1.Button_missileClick(Sender: TObject);
var
 iExPos: Single;
 iTemp : Single;
 IEnmX: Single;
 i : integer;   //loop
 em_buf_ : TRectangle;
 ///�O���ɓG�����邩���肷��֐�
 function EnmExist(enm: TRectangle): Single;
 begin
   Result := missile_max;
   if enm.Visible and (enm.Position.X > (Rectangle_player.Position.X + Rectangle_player.Width)) then
      if ((enm.Position.Y-10) <= Rectangle_missile.Position.Y) and
        ((enm.Position.Y + (enm.Height*enm.Scale.X))+10 >= Rectangle_missile.Position.Y) then
      begin
        Result      := enm.Position.X;
      end;
 end;

begin
//missile����
  Button_Missile.Enabled :=False;
  KanokeBuf  :=nil;
  FloatAnimation_missile.StopValue := missile_max;
  FloatAnimation_missile.StartValue := Rectangle_player.Position.X +20;
  Rectangle_missile.Position.Y := Rectangle_player.Position.Y +25;
  iExPos := missile_max;
  iEnmX := missile_max;
   for i := 0 to 2 do  {���[�v�œG3�����ԂɌ��j�\�����ׂ�}
  begin
    case i of
    0:em_buf_ := Rectangle_Enm1;
    1:em_buf_ := Rectangle_Enm2;
    2:em_buf_ := Rectangle_Enm3;
    end;
    iTemp   := EnmExist(em_buf_);
    if (iTemp < missile_max) and (iEnmX > em_buf_.Position.X)  then
    begin   {�G�̑O�ɓG������ꍇ, ��O�̓G��D��}
      iExPos      := iTemp;
      KanokeBuf  := em_buf_;
    end;
    if Assigned(KanokeBuf) then  {���j�o����G�ϐ��ɑ��݂��邩�m�F}
      iEnmX := KanokeBuf.Position.X;
  end;

  if iExPos < (Rectangle_player.Position.X + Rectangle_player.Width) then
    iExPos := missile_max;  {�G���v���[���[�����ɂ���ꍇ�W�I����O��}

  FloatAnimation_missile.StopValue  := iExPos;  {�~�T�C���̖ڕW�l���Z�b�g}

  Rectangle_missile.Visible := True;            {�~�T�C����\��}
  FloatAnimation_missile.Start;                 {�~�T�C������}




end;

procedure TForm1.game_reset;
begin //�Q�[�����Z�b�g
  Button_up.Visible                 := False; //�{�^��Up��\��
  Button_down.Visible               := False; //�{�^��Down��\��
  Button_missile.Visible            := False; //�{�^���~�T�C����\��
  Timer_Enms.Enabled                := False; //�G�o���^�C�}�[�X�g�b�v
  Timer_Enms_laserbeam.Enabled      := False; //�G���[�U�[�r�[���^�C�}�[�X�g�b�v
  Timer_gameover.Enabled            := False; //�v���[���[�ƓG�ڐG����^�C�}�[�X�g�b�v
  Rectangle_Enm1.Visible            := False; //�G1��\��
  Rectangle_Enm2.Visible            := False; //�G2��\��
  Rectangle_Enm3.Visible            := False; //�G3��\��
  Rectangle_Enm_laserbeam.Visible   := False; //�G���[�U�[�r�[����\��
  Rectangle_startscene.Visible  := True;      //�X�^�[�g�V�[���\��
end;


procedure TForm1.Button_StartClick(Sender: TObject);
begin
  Rectangle_player.Visible :=True;
  Rectangle_Startscene.Visible := False;
  FloatAnimation_player_x.Start;

end;


procedure TForm1.Button_downClick(Sender: TObject);
begin
  FloatAnimation_player_y.StartValue := Rectangle_player.position.Y;
  if Rectangle_player.Position.Y+50 <(Self.Height -Rectangle_player.Height-50) then
  begin
    FloatAnimation_player_y.StopValue := RectAngle_player.Position.Y +50;
  end
  else
  begin
    FloatAnimation_player_y.StopValue := Self.Height - Rectangle_player.Height - 50;

  end;
    FloatAnimation_player_y.Start;


end;

procedure TForm1.Button_upClick(Sender: TObject);
begin
  FloatAnimation_player_y.StartValue := Rectangle_player.position.Y;
  if Rectangle_player.Position.Y-50>0 then
  begin
    FloatAnimation_player_y.StopValue := RectAngle_player.Position.Y -50;
  end
  else
  begin
    FloatAnimation_player_y.StopValue := 0;

  end;
    FloatAnimation_player_y.Start;
end;


procedure TForm1.FloatAnimation_Enm1Finish(Sender: TObject);
begin
  Rectangle_Enm1.Visible :=False;
end;
procedure TForm1.FloatAnimation_Enm2Finish(Sender: TObject);
begin
  Rectangle_Enm2.Visible :=False;
end;
procedure TForm1.FloatAnimation_Enm3Finish(Sender: TObject);
begin
  Rectangle_Enm3.Visible :=False;
end;

procedure TForm1.FloatAnimation_Enm_laserbeamFinish(Sender: TObject);
begin
  Rectangle_enm_laserbeam.Visible := false;
end;

procedure TForm1.FloatAnimation_background1Finish(Sender: TObject);
begin
  case Round(Rectangle_background1.Position.X)of
    0:begin
      FloatAnimation_background1.startvalue :=0;
      FloatAnimation_background1.stopvalue := -Self.Width;
    end;
    else
    begin
      FloatAnimation_backGround1.Startvalue := self.Width;
      FloatAnimation_background1.stopvalue := 0;
    end;

  end;
  FloatAnimation_background2.Start;
end;

procedure TForm1.FloatAnimation_background2Finish(Sender: TObject);
begin
  case Round(Rectangle_background2.Position.X)of
    0:begin
      FloatAnimation_background2.startvalue :=0;
      FloatAnimation_background2.stopvalue := -Self.Width;
    end;
    else
    begin
      FloatAnimation_backGround2.Startvalue := self.Width;
      FloatAnimation_background2.stopvalue := 0;
    end;

  end;
  FloatAnimation_background2.Start;
end;

procedure TForm1.FloatAnimation_missileFinish(Sender: TObject);
begin
  Button_missile.Enabled := True;
  Rectangle_missile.Visible := false;
  if Assigned(KanokeBuf) then
  begin
  Inc(Fitotal);
    KanokeBuf.Visible := False;
  end;
    KanokeBuf :=nil;
  end;


procedure TForm1.FloatAnimation_player_xFinish(Sender: TObject);
begin
  Button_missile.Visible        := True;
  Button_up.Visible             := True;
  Button_down.Visible           := True;
  Timer_Enms.Enabled            := True;
  Timer_Enms_laserbeam.Enabled  := True;
  FdtPlay                       := Now;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Rectangle_player.Visible :=false;
  Rectangle_missile.Visible :=false;
  Rectangle_Enm1.Visible := false;
  Rectangle_Enm2.Visible := false;
  Rectangle_Enm3.Visible := false;
  Rectangle_enm_laserbeam.Visible := false;

end;

procedure TForm1.Timer_EnmsTimer(Sender: TObject);
Var
  iEnm : Integer;
  iEnm_y :Integer;
  ////////////////////////�G�̏o���֐�
  Procedure enm_start(enm: TRectangle; ani:TFloatAnimation; bani: TBitmapAnimation);
  begin
    if not enm.Visible  then  //�G���ҋ@���Ă���Ȃ��
    begin
        enm.Position.Y := iEnm_y;
        enm.Visible := True;
        ani.StartValue := Width +10;
        ani.StopValue := -enm.Width - 10;
        ani.Start;
        bani.Start;
    end;
  end;

begin
  iEnm := Random(5);
  iEnm_y := Random(self.Height -100);
  case iEnm of
    1:enm_start(rectangle_Enm1, FloatAnimation_Enm1, BitmapAnimation_Enm1);
    2:enm_start(rectangle_Enm2, FloatAnimation_Enm2, BitmapAnimation_Enm2);
    3:enm_start(rectangle_Enm3, FloatAnimation_Enm3, BitmapAnimation_Enm3);
  end;


end;

procedure TForm1.Timer_Enms_laserBeamTimer(Sender: TObject);
Var
 iEnm :Integer;
 /////Missile start �֐�
 Procedure MissileStart(enm: TRectangle);
 begin
  if(not Rectangle_enm_laserbeam.Visible) and enm.Visible then
  begin
    Rectangle_enm_laserbeam.Position.Y := enm.Position.Y +25;
    Rectangle_enm_laserbeam.Visible := true;
    FloatAnimation_Enm_laserbeam.StartValue := enm.position.X -20;
    FloatAnimation_Enm_laserbeam.StopValue := FloatAnimation_Enm_laserbeam.StartValue-(Self.Width+50);
    FloatAnimation_Enm_laserbeam.Start;
  end;
 end;

begin
  iEnm := Random(5);
  case iEnm of
  1: MissileStart(Rectangle_Enm1);
  2: MissileStart(Rectangle_Enm2);
  3: MissileStart(Rectangle_Enm3);
  end;
    Label_score.Text  := Format('Time %s / Total Score %0.9d', [
      FormatDateTime('hh:nn:ss', Now - FdtPlay), FiTotal
    ]);

end;

procedure TForm1.Timer_gameoverTimer(Sender: TObject);
var
  i: Integer;
  atari_: Boolean;                                            //�v���[���[�퓬�@�ƓG���ڐG�����ꍇTrue
  function hantei(r1, r2: TRectF): Boolean;                   //�l�p�ǂ������d�Ȃ��Ă��邩����
  begin
    Result  := False;
    if (r1.Left < r2.Right) and
      (r1.Right > r2.Left)  and
      (r1.Top < r2.Bottom)  and
      (r1.Bottom > r2.Top) then
    begin
      Result  := True;
    end;
  end;
  function Rect_hantei(rect1, rect2: TRectangle): Boolean;    //TRectangle�ǂ������d�Ȃ��Ă��邩����
  begin
    if rect2.Visible then
    begin
      Result  := Hantei(
        TRectF.Create(rect1.Position.X, rect1.Position.Y,
        rect1.Position.X + rect1.Width, rect1.Position.Y + rect1.Height
        ),
        TRectF.Create(rect2.Position.X, rect2.Position.Y,
        rect2.Position.X + rect2.Width, rect2.Position.Y + rect2.Height
        ));
    end
    else
      Result  := False;
  end;
begin
  atari_  := False;
  Timer_gameover.Enabled  := False;
  for i := 0 to 3 do  //�G1�`3��laserbeam���퓬�@�ƐڐG�������𔻒�
    case i of
    0: begin
      atari_  := Rect_hantei(Rectangle_player, Rectangle_Enm1);
      if atari_ then Break; end;
    1: begin
      atari_  := Rect_hantei(Rectangle_player, Rectangle_Enm2);
      if atari_ then Break; end;
    2: begin
      atari_  := Rect_hantei(Rectangle_player, Rectangle_Enm3);
      if atari_ then Break; end;
    3: begin
      atari_  := Rect_hantei(Rectangle_player, Rectangle_Enm_laserbeam);
      if atari_ then Break; end;
    end;
  if atari_ then
  begin
    Rectangle_player.Visible  := False;
    ShowMessage('�Q�[���I�[�o�[');
    game_reset; //�Q�[�������Z�b�g����
  end
  else
    Timer_gameover.Enabled  := True;

end;

end.
