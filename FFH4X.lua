
-- VENOM XITERZ | AIM + ESP + RAGE
-- LocalScript: StarterPlayer > StarterPlayerScripts

local P=game:GetService("Players")
local RS=game:GetService("RunService")
local UIS=game:GetService("UserInputService")
local LP=P.LocalPlayer
local PG=LP:WaitForChild("PlayerGui")
local Cam=workspace.CurrentCamera
local ESP_DISTANCE=30000

local RED=Color3.fromRGB(235,25,30)
local BG=Color3.fromRGB(15,15,18)
local EL=Color3.fromRGB(35,35,40)
local WHITE=Color3.fromRGB(240,240,245)
local GREEN=Color3.fromRGB(0,255,80)
local GRAY=Color3.fromRGB(145,145,155)

local C={Aim=false,AimMode="Visible",ShowFOV=false,FOV=120,Line=false,Name=false,Health=false,Box=false,ScreenStop=false,ScreenStretched=false}
local function Ally(p)
 return p~=LP and LP.Team~=nil and p.Team~=nil and p.Team==LP.Team
end

local old=PG:FindFirstChild("VenomXiterz")
if old then old:Destroy() end
local GUI=Instance.new("ScreenGui")
GUI.Name="VenomXiterz"
GUI.ResetOnSpawn=false
GUI.IgnoreGuiInset=true
GUI.DisplayOrder=100
GUI.Parent=PG

local function Make(c,props,parent)
 local o=Instance.new(c)
 for k,v in pairs(props) do o[k]=v end
 o.Parent=parent
 return o
end
local function Corner(o,r)
 Make("UICorner",{CornerRadius=UDim.new(0,r or 5)},o)
end

local Main=Make("Frame",{Size=UDim2.fromOffset(430,335),Position=UDim2.new(.5,-215,.5,-167),BackgroundColor3=BG,BorderSizePixel=0},GUI)
Corner(Main,8)
Make("UIStroke",{Color=RED,Thickness=1.2},Main)
local Header=Make("Frame",{Size=UDim2.new(1,0,0,48),BackgroundColor3=Color3.fromRGB(23,23,27),BorderSizePixel=0},Main)
Corner(Header,8)
Make("TextLabel",{Position=UDim2.fromOffset(14,3),Size=UDim2.new(1,-65,0,25),BackgroundTransparency=1,Text="VENOM XITERZ",TextColor3=WHITE,Font=Enum.Font.GothamBold,TextSize=17,TextXAlignment=Enum.TextXAlignment.Left},Header)
Make("TextLabel",{Position=UDim2.fromOffset(15,27),Size=UDim2.new(1,-70,0,15),BackgroundTransparency=1,Text="AIMBOT / ESP / RAGE",TextColor3=RED,Font=Enum.Font.Gotham,TextSize=10,TextXAlignment=Enum.TextXAlignment.Left},Header)
local Min=Make("TextButton",{Position=UDim2.new(1,-38,0,7),Size=UDim2.fromOffset(29,29),Text="—",TextColor3=WHITE,BackgroundColor3=EL,Font=Enum.Font.GothamBold,TextSize=18,BorderSizePixel=0},Header)
Corner(Min,5)

-- Arrastar pelo cabeçalho
local dragging,dragStart,startPos
Header.InputBegan:Connect(function(i)
 if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
  dragging=true;dragStart=i.Position;startPos=Main.Position
 end
end)
UIS.InputChanged:Connect(function(i)
 if dragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
  local d=i.Position-dragStart
  Main.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)
 end
end)
UIS.InputEnded:Connect(function(i)
 if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=false end
end)

local Tabs=Make("Frame",{Position=UDim2.fromOffset(12,57),Size=UDim2.new(1,-24,0,34),BackgroundTransparency=1},Main)
local Content=Make("Frame",{Position=UDim2.fromOffset(12,99),Size=UDim2.new(1,-24,1,-111),BackgroundTransparency=1},Main)
local Pages={}
local function NewPage(n)
 local p=Make("Frame",{Name=n,Size=UDim2.fromScale(1,1),BackgroundTransparency=1,Visible=false},Content)
 Pages[n]=p
 return p
end
local function SelectTab(n)
 for k,p in pairs(Pages) do p.Visible=k==n end
 for _,b in ipairs(Tabs:GetChildren()) do
  if b:IsA("TextButton") then b.BackgroundColor3=b.Name==n and RED or EL end
 end
end
for i,n in ipairs({"AIM","ESP","RAGE"}) do
 local b=Make("TextButton",{Name=n,Position=UDim2.new((i-1)/3,3,0,0),Size=UDim2.new(1/3,-6,1,0),BackgroundColor3=EL,BorderSizePixel=0,Text=n,TextColor3=WHITE,Font=Enum.Font.GothamBold,TextSize=12},Tabs)
 Corner(b,5)
 b.Activated:Connect(function() SelectTab(n) end)
end
local AimPage=NewPage("AIM")
local ESPPage=NewPage("ESP")
local RagePage=NewPage("RAGE")

local function Section(p,t,y)
 Make("TextLabel",{Position=UDim2.fromOffset(5,y),Size=UDim2.new(1,-10,0,22),BackgroundTransparency=1,Text=t,TextColor3=RED,Font=Enum.Font.GothamBold,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left},p)
end
local function Toggle(p,t,k,y)
 Make("TextLabel",{Position=UDim2.fromOffset(5,y),Size=UDim2.new(1,-42,0,28),BackgroundTransparency=1,Text=t,TextColor3=WHITE,Font=Enum.Font.Gotham,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left},p)
 local b=Make("TextButton",{Position=UDim2.new(1,-25,0,y+6),Size=UDim2.fromOffset(16,16),BackgroundColor3=C[k] and RED or EL,BorderSizePixel=0,Text="",AutoButtonColor=false},p)
 Make("UIStroke",{Color=C[k] and RED or GRAY,Thickness=1},b)
 b.Activated:Connect(function()
  C[k]=not C[k]
  b.BackgroundColor3=C[k] and RED or EL
  b.UIStroke.Color=C[k] and RED or GRAY
 end)
end

-- AIM: ativação e seletor de modos
Section(AimPage,"AIMBOT SETTINGS",0)
Make("TextLabel",{Position=UDim2.fromOffset(5,27),Size=UDim2.new(1,-100,0,28),BackgroundTransparency=1,Text="Aimbot",TextColor3=WHITE,Font=Enum.Font.Gotham,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left},AimPage)
local AimToggle=Make("TextButton",{Position=UDim2.new(1,-25,0,33),Size=UDim2.fromOffset(16,16),BackgroundColor3=EL,BorderSizePixel=0,Text="",AutoButtonColor=false},AimPage)
Make("UIStroke",{Color=GRAY,Thickness=1},AimToggle)
local Arrow=Make("TextButton",{Position=UDim2.new(1,-65,0,29),Size=UDim2.fromOffset(32,24),BackgroundColor3=EL,BorderSizePixel=0,Text="▼",TextColor3=WHITE,Font=Enum.Font.GothamBold,TextSize=11,AutoButtonColor=false},AimPage)
Corner(Arrow,4)
local Menu=Make("Frame",{Position=UDim2.fromOffset(5,57),Size=UDim2.new(1,-10,0,56),BackgroundColor3=BG,BorderSizePixel=0,Visible=false,ZIndex=10},AimPage)
Corner(Menu,4)
Make("UIStroke",{Color=RED,Thickness=1},Menu)

local function UpdateAim()
 AimToggle.BackgroundColor3=C.Aim and RED or EL
 AimToggle.UIStroke.Color=C.Aim and RED or GRAY
 for _,b in ipairs(Menu:GetChildren()) do
  if b:IsA("TextButton") then
   b.BackgroundColor3=b.Name==C.AimMode and RED or EL
  end
 end
end
local function ModeButton(text,mode,y)
 local b=Make("TextButton",{Name=mode,Position=UDim2.fromOffset(4,y),Size=UDim2.new(1,-8,0,24),BackgroundColor3=EL,BorderSizePixel=0,Text=text,TextColor3=WHITE,Font=Enum.Font.Gotham,TextSize=11,TextXAlignment=Enum.TextXAlignment.Left,AutoButtonColor=false,ZIndex=11},Menu)
 Corner(b,3)
 b.Activated:Connect(function()
  C.AimMode=mode
  C.Aim=true
  UpdateAim()
  Menu.Visible=false
  Arrow.Text="▼"
 end)
end
ModeButton("  Linha de visão","Visible",3)
ModeButton("  Através das paredes","Walls",29)
AimToggle.Activated:Connect(function() C.Aim=not C.Aim;UpdateAim() end)
Arrow.Activated:Connect(function()
 Menu.Visible=not Menu.Visible
 Arrow.Text=Menu.Visible and "▲" or "▼"
 if Menu.Visible then UpdateAim() end
end)
UpdateAim()

Toggle(AimPage,"Mostrar círculo FOV","ShowFOV",121)
local fovLabel=Make("TextLabel",{Position=UDim2.fromOffset(5,154),Size=UDim2.new(1,-10,0,22),BackgroundTransparency=1,TextColor3=WHITE,Font=Enum.Font.Gotham,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,Text="FOV: 120"},AimPage)
local Slider=Make("Frame",{Position=UDim2.fromOffset(8,188),Size=UDim2.new(1,-16,0,6),BackgroundColor3=EL,BorderSizePixel=0},AimPage)
Corner(Slider,4)
local Fill=Make("Frame",{Size=UDim2.new((C.FOV-30)/370,0,1,0),BackgroundColor3=RED,BorderSizePixel=0},Slider)
Corner(Fill,4)
local Knob=Make("TextButton",{AnchorPoint=Vector2.new(.5,.5),Position=UDim2.new((C.FOV-30)/370,0,.5,0),Size=UDim2.fromOffset(15,15),BackgroundColor3=WHITE,BorderSizePixel=0,Text="",AutoButtonColor=false},Slider)
Corner(Knob,8)
local sliding=false
local function SetFOV(x)
 local a=math.clamp((x-Slider.AbsolutePosition.X)/Slider.AbsoluteSize.X,0,1)
 C.FOV=math.floor(30+a*370)
 local v=(C.FOV-30)/370
 Fill.Size=UDim2.new(v,0,1,0)
 Knob.Position=UDim2.new(v,0,.5,0)
 fovLabel.Text="FOV: "..C.FOV
end
Knob.InputBegan:Connect(function(i)
 if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then sliding=true;SetFOV(i.Position.X) end
end)
Slider.InputBegan:Connect(function(i)
 if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then sliding=true;SetFOV(i.Position.X) end
end)
UIS.InputChanged:Connect(function(i)
 if sliding and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then SetFOV(i.Position.X) end
end)
UIS.InputEnded:Connect(function(i)
 if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then sliding=false end
end)

-- ESP
Section(ESPPage,"ESP SETTINGS",0)
Toggle(ESPPage,"ESP LINE","Line",27)
Toggle(ESPPage,"ESP NOME","Name",59)
Toggle(ESPPage,"ESP VIDA","Health",91)
Toggle(ESPPage,"ESP BOX","Box",123)

-- RAGE
Section(RagePage,"RAGE SETTINGS",0)
Toggle(RagePage,"TELA PARADA","ScreenStop",27)
Toggle(RagePage,"TELA ESTICADA","ScreenStretched",59)
Make("TextLabel",{Position=UDim2.fromOffset(5,94),Size=UDim2.new(1,-10,0,42),BackgroundTransparency=1,Text="Tela esticada: aproximação visual pela câmera; não altera a resolução do aparelho.",TextColor3=GRAY,Font=Enum.Font.Gotham,TextSize=11,TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Left},RagePage)
SelectTab("AIM")

-- Minimizar
local minimized=false
Min.Activated:Connect(function()
 minimized=not minimized
 Tabs.Visible=not minimized
 Content.Visible=not minimized
 Main.Size=minimized and UDim2.fromOffset(190,48) or UDim2.fromOffset(430,335)
 Min.Text=minimized and "+" or "—"
end)

-- Círculo FOV
local FOVCircle=Make("Frame",{Name="FOVCircle",AnchorPoint=Vector2.new(.5,.5),Position=UDim2.fromScale(.5,.5),Size=UDim2.fromOffset(C.FOV*2,C.FOV*2),BackgroundTransparency=1,BorderSizePixel=0,Visible=C.ShowFOV},GUI)
Make("UICorner",{CornerRadius=UDim.new(.5,0)},FOVCircle)
Make("UIAspectRatioConstraint",{AspectRatio=1},FOVCircle)
Make("UIStroke",{Color=RED,Thickness=1.5},FOVCircle)

-- ESP dos jogadores
local Drawings={}
local function NewESP(p)
 local folder=Make("Folder",{Name="ESP_"..p.UserId},GUI)
 local box=Make("Frame",{BackgroundTransparency=1,BorderSizePixel=0,Visible=false},folder)
 Make("UIStroke",{Color=WHITE,Thickness=1.3},box)
 local hb=Make("Frame",{BackgroundColor3=Color3.fromRGB(45,45,45),BorderSizePixel=0,Visible=false},folder)
 local health=Make("Frame",{BackgroundColor3=GREEN,BorderSizePixel=0,AnchorPoint=Vector2.new(0,1),Position=UDim2.fromScale(0,1),Size=UDim2.fromScale(1,1)},hb)
 local name=Make("TextLabel",{BackgroundTransparency=1,TextColor3=WHITE,TextStrokeTransparency=.2,Font=Enum.Font.GothamBold,TextSize=12,Visible=false},folder)
 local line=Make("Frame",{AnchorPoint=Vector2.new(.5,.5),BackgroundColor3=WHITE,BorderSizePixel=0,Visible=false},folder)
 Drawings[p]={Folder=folder,Box=box,HealthBG=hb,Health=health,Name=name,Line=line}
end
local function HideESP(d)
 d.Box.Visible=false
 d.HealthBG.Visible=false
 d.Name.Visible=false
 d.Line.Visible=false
end
local function IsVisible(char,part)
 local rp=RaycastParams.new()
 rp.FilterType=Enum.RaycastFilterType.Exclude
 rp.FilterDescendantsInstances={LP.Character}
 local result=workspace:Raycast(Cam.CFrame.Position,part.Position-Cam.CFrame.Position,rp)
 return result~=nil and result.Instance:IsDescendantOf(char)
end

-- BOX: cabeça, tronco e pernas; braços ignorados para não alargar a caixa
local function GetScreenBounds(char)
 local parts={"Head","Torso","UpperTorso","LowerTorso","Left Leg","Right Leg","LeftUpperLeg","RightUpperLeg","LeftLowerLeg","RightLowerLeg","LeftFoot","RightFoot"}
 local minX,minY=math.huge,math.huge
 local maxX,maxY=-math.huge,-math.huge
 local visible,found=false,false
 for _,n in ipairs(parts) do
  local part=char:FindFirstChild(n)
  if part and part:IsA("BasePart") then
   found=true
   local h=part.Size/2
   for sx=-1,1,2 do
    for sy=-1,1,2 do
     for sz=-1,1,2 do
      local corner=part.CFrame:PointToWorldSpace(Vector3.new(h.X*sx,h.Y*sy,h.Z*sz))
      local pt,on=Cam:WorldToViewportPoint(corner)
      if pt.Z>0 then
       minX=math.min(minX,pt.X);minY=math.min(minY,pt.Y)
       maxX=math.max(maxX,pt.X);maxY=math.max(maxY,pt.Y)
       if on then visible=true end
      end
     end
    end
   end
  end
 end
 if not found or not visible or minX==math.huge then return nil end
 local w,h=maxX-minX,maxY-minY
 if w<2 or h<2 then return nil end
 return minX,minY,w,h
end

for _,p in ipairs(P:GetPlayers()) do if p~=LP then NewESP(p) end end
P.PlayerAdded:Connect(function(p) if p~=LP then NewESP(p) end end)
P.PlayerRemoving:Connect(function(p)
 local d=Drawings[p]
 if d then d.Folder:Destroy() end
 Drawings[p]=nil
end)

-- Mira: a opção Walls dispensa o teste de visibilidade.
-- Para jogos próprios, controle alvos e permissões no servidor.
local function GetTarget()
 local center=Cam.ViewportSize/2
 local best,bd=nil,C.FOV
 for _,p in ipairs(P:GetPlayers()) do
  if p~=LP and not Ally(p) then
   local char=p.Character
   local head=char and char:FindFirstChild("Head")
   local hum=char and char:FindFirstChildOfClass("Humanoid")
   if head and hum and hum.Health>0 then
    local pos,on=Cam:WorldToViewportPoint(head.Position)
    local dist=(Vector2.new(pos.X,pos.Y)-center).Magnitude
    local visible=C.AimMode=="Walls" or IsVisible(char,head)
    if on and dist<bd and visible then best=head;bd=dist end
   end
  end
 end
 return best
end

local lastHumanoid,lastAutoRotate,OriginalCameraFOV
RS.RenderStepped:Connect(function()
 Cam=workspace.CurrentCamera
 if not Cam then return end
 local viewport=Cam.ViewportSize
 FOVCircle.Position=UDim2.fromOffset(viewport.X/2,viewport.Y/2)
 FOVCircle.Size=UDim2.fromOffset(C.FOV*2,C.FOV*2)
 FOVCircle.Visible=C.ShowFOV

 if C.ScreenStretched then
  if not OriginalCameraFOV then OriginalCameraFOV=Cam.FieldOfView end
  Cam.FieldOfView=85
 elseif OriginalCameraFOV then
  Cam.FieldOfView=OriginalCameraFOV
  OriginalCameraFOV=nil
 end

 local char=LP.Character
 local hum=char and char:FindFirstChildOfClass("Humanoid")
 local root=char and char:FindFirstChild("HumanoidRootPart")
 if C.ScreenStop and hum and root then
  if lastHumanoid~=hum then
   if lastHumanoid and lastAutoRotate~=nil then lastHumanoid.AutoRotate=lastAutoRotate end
   lastHumanoid=hum;lastAutoRotate=hum.AutoRotate
  end
  hum.AutoRotate=false
  local dir=hum.MoveDirection
  if dir.Magnitude>.05 then
   local flat=Vector3.new(dir.X,0,dir.Z)
   root.CFrame=CFrame.lookAt(root.Position,root.Position+flat)
  end
 elseif lastHumanoid then
  lastHumanoid.AutoRotate=lastAutoRotate
  lastHumanoid=nil;lastAutoRotate=nil
 end

 if C.Aim then
  local target=GetTarget()
  if target then Cam.CFrame=CFrame.lookAt(Cam.CFrame.Position,target.Position) end
 end

 -- Distância da ESP: máximo de 30.000 studs
 local myRoot=char and char:FindFirstChild("HumanoidRootPart")
 for p,d in pairs(Drawings) do
  local targetChar=p.Character
  local targetRoot=targetChar and targetChar:FindFirstChild("HumanoidRootPart")
  local head=targetChar and targetChar:FindFirstChild("Head")
  local th=targetChar and targetChar:FindFirstChildOfClass("Humanoid")
  local distance=myRoot and targetRoot and (myRoot.Position-targetRoot.Position).Magnitude or math.huge

  if Ally(p) or not targetChar or not head or not th or th.Health<=0 or distance>ESP_DISTANCE then
   HideESP(d)
   continue
  end

  local x,y,w,h=GetScreenBounds(targetChar)
  if not x then HideESP(d);continue end

  if C.Box then
   d.Box.Visible=true
   d.Box.Position=UDim2.fromOffset(x,y)
   d.Box.Size=UDim2.fromOffset(w,h)
  else d.Box.Visible=false end

  if C.Health then
   d.HealthBG.Visible=true
   d.HealthBG.Position=UDim2.fromOffset(x-6,y)
   d.HealthBG.Size=UDim2.fromOffset(4,h)
   d.Health.Size=UDim2.new(1,0,math.clamp(th.Health/th.MaxHealth,0,1),0)
  else d.HealthBG.Visible=false end

  if C.Name then
   d.Name.Visible=true
   d.Name.Text=p.DisplayName
   d.Name.Position=UDim2.fromOffset(x,y-20)
   d.Name.Size=UDim2.fromOffset(w,18)
  else d.Name.Visible=false end

  if C.Line then
   local pos,on=Cam:WorldToViewportPoint(head.Position)
   d.Line.Visible=on and pos.Z>0
   if d.Line.Visible then
    local a=Vector2.new(viewport.X/2,0)
    local b=Vector2.new(pos.X,pos.Y)
    local delta=b-a
    d.Line.Position=UDim2.fromOffset((a.X+b.X)/2,(a.Y+b.Y)/2)
    d.Line.Size=UDim2.fromOffset(delta.Magnitude,1)
    d.Line.Rotation=math.deg(math.atan2(delta.Y,delta.X))
   end
  else d.Line.Visible=false end
 end
end)

GUI.Destroying:Connect(function()
 if lastHumanoid and lastAutoRotate~=nil then lastHumanoid.AutoRotate=lastAutoRotate end
 if Cam and OriginalCameraFOV then Cam.FieldOfView=OriginalCameraFOV end
end)
