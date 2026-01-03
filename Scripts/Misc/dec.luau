-- Decompiled with the Synapse X Luau decompiler.

local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__TweenService__3 = game:GetService("TweenService");
local l__UserInputService__4 = game:GetService("UserInputService");
local l__RunService__5 = game:GetService("RunService");
while true do
	wait();
	if _G.ClientLoaded and _G.WaitForChar and _G.GVF then
		break;
	end;
end;
_G.WaitForChar();
local l__LocalPlayer__6 = l__Players__1.LocalPlayer;
local l__mouse__7 = l__LocalPlayer__6:GetMouse();
local l__Parent__8 = script.Parent;
local v9 = l__LocalPlayer__6.Character or l__LocalPlayer__6.CharacterAdded:Wait();
local l__HumanoidRootPart__10 = v9:WaitForChild("HumanoidRootPart");
local l__Humanoid__11 = v9:WaitForChild("Humanoid");
local l__Handle1__12 = l__Parent__8:WaitForChild("Handle1");
local l__Handle2__13 = l__Parent__8:WaitForChild("Handle2");
local l__Uses__14 = l__Parent__8:WaitForChild("Uses");
local l__Event__15 = l__Parent__8:WaitForChild("Event");
local l__Remote__16 = l__Parent__8:WaitForChild("Remote");
local l__AnimsFolder__17 = l__Parent__8:WaitForChild("AnimsFolder");
local v18 = {
	Equip = l__Humanoid__11:LoadAnimation(l__AnimsFolder__17:WaitForChild("Equip")), 
	Use = l__Humanoid__11:LoadAnimation(l__AnimsFolder__17:WaitForChild("Use"))
};
local l__GUIs__19 = l__ReplicatedStorage__2:WaitForChild("Storage"):WaitForChild("GUIs");
local v20 = l__GUIs__19:WaitForChild("LP_BGUI"):Clone();
table.insert(_G.EffectsList, v20);
local l__Map__21 = workspace:WaitForChild("Map", 1000);
local v22 = l__GUIs__19:WaitForChild("LockpickGUI"):Clone();
local l__MF__23 = v22:WaitForChild("MF");
local l__LP_Frame__24 = l__MF__23:WaitForChild("LP_Frame");
function lerp(p1, p2, p3)
	return p1 + (p2 - p1) * p3;
end;
local u1 = false;
function Open()
	v22.Parent = l__LocalPlayer__6.PlayerGui;
	u1 = true;
end;
local u2 = false;
local u3 = nil;
local u4 = nil;
function Close()
	v20.Enabled = false;
	v20.Parent = nil;
	if u2 then
		u2.Enabled = true;
	end;
	if not u1 then
		return;
	end;
	u1 = false;
	v22.Parent = nil;
	if u3 then
		u3:Disconnect();
		u3 = nil;
	end;
	if u4 then
		u4:Disconnect();
		u4 = nil;
	end;
end;
local l__Attempts__5 = l__MF__23:WaitForChild("Attempts");
local u6 = l__Uses__14.Value;
local u7 = {};
local l__CurrentCamera__8 = workspace.CurrentCamera;
local function u9(p4, p5, p6, p7, p8, p9)
	local v25, v26 = workspace:FindPartOnRayWithWhitelist(Ray.new(p4, (p5.Position - p4).Unit * p6), p7, true);
	local v27 = true;
	if v25 ~= p5 then
		v27 = p8 and v25 and v25:IsDescendantOf(p5) or p9 and (v25 and v25:IsDescendantOf(p5.Parent));
	end;
	return v27;
end;
local u10 = nil;
local u11 = nil;
local u12 = 0;
local u13 = nil;
local u14 = {};
local l__Frames__15 = l__LP_Frame__24:WaitForChild("Frames");
local u16 = false;
local function u17()
	local v28 = 0;
	for v29, v30 in pairs(l__Attempts__5:GetChildren()) do
		if v30:IsA("ImageLabel") then
			local v31 = v28 < u6;
			v30.Visible = v31;
			if v31 then
				v28 = v28 + 1;
			end;
		end;
	end;
end;
local l__Line__18 = l__LP_Frame__24:WaitForChild("Line");
function MainHandler(p10)
	if u1 then
		return;
	end;
	local v32 = l__Remote__16:InvokeServer("S", u10, u11);
	if not v32 then
		return;
	end;
	u12 = v32;
	if u3 then
		u3:Disconnect();
		u3 = nil;
	end;
	if u4 then
		u4:Disconnect();
		u4 = nil;
	end;
	if u13 then
		u13:Cancel();
		u13 = nil;
	end;
	l__LP_Frame__24.BackgroundColor3 = Color3.new(1, 1, 1);
	local u19 = {};
	local u20 = nil;
	local u21 = nil;
	local function u22()
		u3:Disconnect();
		u4:Disconnect();
		if u13 then
			u13:Cancel();
			u13 = nil;
		end;
		l__LP_Frame__24.BackgroundColor3 = Color3.new(1, 1, 1);
		u13 = l__TweenService__3:Create(l__LP_Frame__24, TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
			BackgroundColor3 = Color3.new(1, 0, 0), 
			BackgroundTransparency = 0.8
		});
		u13:Play();
		local v33, v34, v35 = pairs(u19);
		while true do
			local v36, v37 = v33(v34, v35);
			if v36 then

			else
				break;
			end;
			if u14[v37] then
				u14[v37]:Cancel();
				u14[v37] = nil;
			end;
			if v37 == u21 then
				v37.Bar.Selection.ImageColor3 = Color3.fromRGB(255, 50, 50);
				v37.Bar.ImageColor3 = Color3.fromRGB(255, 50, 50);
				l__TweenService__3:Create(v37.Bar.Selection, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {
					ImageColor3 = Color3.fromRGB(143, 143, 143)
				}):Play();
				l__TweenService__3:Create(v37.Bar, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {
					ImageColor3 = Color3.fromRGB(143, 143, 143)
				}):Play();
			else
				v37.Bar.Selection.ImageColor3 = Color3.fromRGB(143, 143, 143);
				v37.Bar.ImageColor3 = Color3.fromRGB(143, 143, 143);
			end;		
		end;
		wait(1);
		Close();
	end;
	local function u23()
		local function v38(p11, p12)
			local l__Bar__39 = p11.Bar;
			if u14[p11] then
				u14[p11]:Cancel();
				u14[p11] = nil;
			end;
			if u14[p11.Bar.Selection] then
				u14[p11.Bar.Selection]:Cancel();
				u14[p11.Bar.Selection] = nil;
			end;
			local l__Value__40 = l__Bar__39.PosV.Value;
			l__Bar__39.Position = UDim2.new(l__Bar__39.Position.X.Scale, l__Bar__39.Position.X.Offset, l__Bar__39.Position.Y.Scale, -l__Value__40);
			local v41 = l__TweenService__3:Create(l__Bar__39, TweenInfo.new(p12, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, math.huge, true), {
				Position = UDim2.new(l__Bar__39.Position.X.Scale, l__Bar__39.Position.X.Offset, l__Bar__39.Position.Y.Scale, l__Value__40)
			});
			u14[p11] = v41;
			v41:Play();
		end;
		local v42 = 1 - 1;
		while true do
			local v43 = l__Frames__15["B" .. v42];
			table.insert(u19, v43);
			v43.Visible = true;
			v43.Bar.ImageColor3 = Color3.new(1, 1, 1);
			if v42 == 1 then
				v43.Bar.ImageColor3 = Color3.new(0, 1, 0);
			else
				v43.Bar.ImageColor3 = Color3.new(1, 1, 1);
			end;
			local v44 = 0.5;
			if v42 == 2 then
				v44 = 0.45;
			elseif v42 == 3 then
				v44 = 0.4;
			end;
			if _G.DeviceType == 3 then
				v44 = v44 * 1.3;
			end;
			v38(v43, v44);
			if 0 <= 1 then
				if v42 < p10 then

				else
					break;
				end;
			elseif p10 < v42 then

			else
				break;
			end;
			v42 = v42 + 1;		
		end;
		u20 = 1;
		u21 = u19[u20];
	end;
	local function u24()
		u16 = true;
		delay(2, function()
			u16 = false;
		end);
		v18.Use:Play();
		u3:Disconnect();
		u4:Disconnect();
		l__Remote__16:InvokeServer("D", u10, u11, u12);
		local v45, v46, v47 = pairs(l__Attempts__5:GetChildren());
		while true do
			local v48, v49 = v45(v46, v47);
			if v48 then

			else
				break;
			end;
			v47 = v48;
			if v49:IsA("ImageLabel") then
				v49.Visible = false;
			end;		
		end;
		if u13 then
			u13:Cancel();
			u13 = nil;
		end;
		l__LP_Frame__24.BackgroundColor3 = Color3.new(1, 1, 1);
		u13 = l__TweenService__3:Create(l__LP_Frame__24, TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
			BackgroundColor3 = Color3.new(0, 1, 0), 
			BackgroundTransparency = 0.8
		});
		u13:Play();
		wait(1);
		Close();
	end;
	u6 = l__Uses__14.Value;
	u23();
	if _G.CheckIfMobile then
		if _G.CheckIfMobile() then
			l__MF__23.Position = UDim2.new(l__MF__23.Position.X.Scale, l__MF__23.Position.X.Offset, 0.37, 0);
			l__MF__23.UIScale.Scale = 0.45;
		else
			l__MF__23.Position = UDim2.new(l__MF__23.Position.X.Scale, l__MF__23.Position.X.Offset, 0.525, 0);
			l__MF__23.UIScale.Scale = 1;
		end;
	else
		l__MF__23.Position = UDim2.new(l__MF__23.Position.X.Scale, l__MF__23.Position.X.Offset, 0.525, 0);
		l__MF__23.UIScale.Scale = 1;
	end;
	Open();
	wait();
	if u1 then
		local function u25(p13)
			u21.Bar.ImageColor3 = Color3.fromRGB(100, 255, 100);
			u21.Bar.Selection.ImageColor3 = Color3.fromRGB(100, 255, 100);
			if u14[u21] then
				u14[u21]:Cancel();
			end;
			u14[u21] = l__TweenService__3:Create(u21.Bar, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {
				ImageColor3 = Color3.fromRGB(143, 143, 143)
			});
			u14[u21]:Play();
			if u14[u21.Bar.Selection] then
				u14[u21.Bar.Selection]:Cancel();
			end;
			u14[u21.Bar.Selection] = l__TweenService__3:Create(u21.Bar.Selection, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {
				ImageColor3 = Color3.fromRGB(143, 143, 143)
			});
			u14[u21.Bar.Selection]:Play();
			u21.Bar.Position = p13;
			if p10 <= u20 then
				u24();
				return;
			end;
			if u13 then
				u13:Cancel();
				u13 = nil;
			end;
			l__LP_Frame__24.BackgroundColor3 = Color3.new(1, 1, 1);
			u13 = l__TweenService__3:Create(l__LP_Frame__24, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, true), {
				BackgroundColor3 = Color3.new(0, 1, 0), 
				BackgroundTransparency = 0.8
			});
			u13:Play();
			u20 = u20 + 1;
			u21 = u19[u20];
		end;
		local u26 = false;
		local function u27()
			u6 = u6 + 1;
			spawn(function()
				l__Remote__16:InvokeServer("E");
			end);
			v18.Use:Play();
			u17();
			if l__Uses__14.MaxValue <= u6 then
				u22();
				return;
			end;
			if u13 then
				u13:Cancel();
				u13 = nil;
			end;
			l__LP_Frame__24.BackgroundColor3 = Color3.new(1, 1, 1);
			u13 = l__TweenService__3:Create(l__LP_Frame__24, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, true), {
				BackgroundColor3 = Color3.new(1, 0, 0), 
				BackgroundTransparency = 0.8
			});
			u13:Play();
			local v50, v51, v52 = pairs(u19);
			while true do
				local v53, v54 = v50(v51, v52);
				if v53 then

				else
					break;
				end;
				if u14[v54] then
					u14[v54]:Cancel();
					u14[v54] = nil;
				end;
				if v54 == u21 then
					v54.Bar.Selection.ImageColor3 = Color3.fromRGB(255, 50, 50);
					v54.Bar.ImageColor3 = Color3.fromRGB(255, 50, 50);
					l__TweenService__3:Create(v54.Bar.Selection, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {
						ImageColor3 = Color3.fromRGB(255, 255, 255)
					}):Play();
					l__TweenService__3:Create(v54.Bar, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {
						ImageColor3 = Color3.fromRGB(255, 255, 255)
					}):Play();
				else
					v54.Bar.Selection.ImageColor3 = Color3.fromRGB(255, 255, 255);
					v54.Bar.ImageColor3 = Color3.fromRGB(255, 255, 255);
				end;			
			end;
			u23();
		end;
		local function u28()
			local l__Bar__55 = u21.Bar;
			local l__AbsolutePosition__56 = l__Line__18.AbsolutePosition;
			local v57 = l__AbsolutePosition__56 + l__Line__18.AbsoluteSize;
			local l__AbsolutePosition__58 = l__Bar__55.AbsolutePosition;
			local v59 = l__AbsolutePosition__58 + l__Bar__55.AbsoluteSize;
			local v60 = false;
			if l__AbsolutePosition__56.x < v59.x then
				v60 = false;
				if l__AbsolutePosition__58.x < v57.x then
					v60 = false;
					if l__AbsolutePosition__56.y < v59.y then
						v60 = l__AbsolutePosition__58.y < v57.y;
					end;
				end;
			end;
			if v60 then

			else
				u27();
				u26 = true;
				delay(0.25, function()
					u26 = false;
				end);
				return;
			end;
			u25(u21.Bar.Position);
			u26 = true;
			delay(0.25, function()
				u26 = false;
			end);
		end;
		u3 = l__UserInputService__4.InputBegan:Connect(function(p14, p15)
			if not p15 then
				if u26 then
					return;
				end;
			else
				return;
			end;
			if p14.UserInputType ~= Enum.UserInputType.MouseButton1 then
				if p14.KeyCode == Enum.KeyCode.ButtonR2 then
					u28();
				end;
			else
				u28();
			end;
		end);
		u4 = l__MF__23.MobileButton.MouseButton1Down:Connect(u28);
	end;
end;
local u29 = false;
local function u30()
	local v61, v62 = (function()
		if not l__HumanoidRootPart__10 or not l__HumanoidRootPart__10.Parent then
			return;
		end;
		local v63 = workspace:FindPartsInRegion3WithWhiteList(Region3.new(l__HumanoidRootPart__10.Position - Vector3.new(4, 2, 4), l__HumanoidRootPart__10.Position + Vector3.new(4, 2, 4)), u7, 30);
		if #v63 <= 0 then
			return;
		end;
		local v64 = "";
		local v65 = nil;
		local v66 = math.huge;
		local v67, v68, v69 = pairs(v63);
		while true do
			local v70, v71 = v67(v68, v69);
			if not v70 then
				break;
			end;
			if v71:IsDescendantOf(workspace.Map.Doors) then
				local v72 = "d";
			else
				v72 = "s";
			end;
			local l__DoorBase__73 = v71.Parent:FindFirstChild("DoorBase");
			if v72 ~= "d" or not (not l__DoorBase__73) then
				local l__Magnitude__74 = (l__HumanoidRootPart__10.Position - (v72 == "d" and l__DoorBase__73 or v71).CFrame.Position).Magnitude;
				if l__Magnitude__74 < v66 then
					v66 = l__Magnitude__74;
					v65 = v71;
					v64 = v72;
				end;
			end;		
		end;
		if not v65 then
			return nil;
		end;
		if v64 ~= "d" then
			return v65.Parent, v64;
		end;
		if v65.Parent:FindFirstChild("IsGarageDoor") or v65.Parent:FindFirstChild("IsElevator1") then
			return nil;
		end;
		if not v65.Parent:FindFirstChild("Knob1") then
			return;
		end;
		local l__Knob1__75 = v65.Parent.Knob1;
		local l__Knob2__76 = v65.Parent.Knob2;
		if (l__Knob1__75.P.WorldPosition - l__HumanoidRootPart__10.Position).Magnitude < (l__Knob2__76.P.WorldPosition - l__HumanoidRootPart__10.Position).Magnitude then
			local v77 = l__Knob1__75;
		else
			v77 = l__Knob2__76;
		end;
		local v78 = false;
		if v77 == v65.Parent.Knob2 then
			v78 = v65.Parent;
		end;
		return v78, v64;
	end)();
	if v61 then
		local v79 = v62 == "d" and v61.Knob2 or v61.PosPart;
		local v80, v81 = l__CurrentCamera__8:WorldToScreenPoint(v79.Position);
		if v81 or u1 then
			if (Vector2.new(l__mouse__7.X, l__mouse__7.Y) - Vector2.new(v80.X, v80.Y)).Magnitude > 100 and not u1 then
				return;
			end;
			if u9(l__HumanoidRootPart__10.Position, v79, 4, { workspace.Map }) then
				return v61, v62;
			end;
		end;
	end;
	return nil;
end;
local u31 = false;
local l__Doing__32 = l__Parent__8:WaitForChild("Doing");
l__Parent__8.Equipped:Connect(function()
	u29 = true;
	pcall(function()
		l__Parent__8.Tool6D1.Part0 = v9["Right Arm"];
	end);
	pcall(function()
		l__Parent__8.Tool6D2.Part0 = v9["Left Arm"];
	end);
	v18.Equip:Play();
	u6 = l__Uses__14.Value;
	u17();
	while u29 do
		wait();
		if l__Uses__14.MaxValue <= u6 and not u1 then
			break;
		end;
		if _G.CheckIfCan(v9, "Any") and not _G.CheckIfFlinching(v9, true) then
			local v82, v83 = u30();
			u10 = v82;
			u11 = v83;
			local v84 = u10 and u10.Values;
			if u11 == "d" then
				if u10 and not v84.Broken.Value and v84.Locked.Value and not v84.CantLockpick.Value then
					v20.Frame.ImageLabel.ImageTransparency = 0;
					v20.Frame.ImageLabel.Visible = true;
					if not u16 and v84.CanLock.Value and not v84.Busy.Value and not v84.Busy2.Value and not v84.Busy2_5.Value then
						v20.Frame.Label.TextColor3 = Color3.new(0, 1, 0);
						v20.Frame.ImageLabel.ImageColor3 = Color3.new(0, 1, 0);
						u31 = true;
					else
						v20.Frame.Label.TextColor3 = Color3.new(0.65, 0.65, 0.65);
						v20.Frame.ImageLabel.ImageColor3 = Color3.new(0.65, 0.65, 0.65);
						u31 = false;
					end;
					v20.StudsOffset = Vector3.new(0, -0.55, 0);
					v20.Parent = l__CurrentCamera__8;
					v20.Adornee = u10.Knob2;
					v20.Enabled = not u1;
				else
					v20.Parent = nil;
					v20.Enabled = false;
					u10 = nil;
					u31 = false;
				end;
			elseif u10 and not v84.Broken.Value and u10.Type.Value > 1 then
				u2 = u10.PosPart.BGUI;
				v20.Frame.ImageLabel.ImageTransparency = 0;
				v20.Frame.ImageLabel.Visible = true;
				if not u16 then
					v20.Frame.Label.TextColor3 = Color3.new(0, 1, 0);
					v20.Frame.ImageLabel.ImageColor3 = Color3.new(0, 1, 0);
					u31 = true;
				else
					v20.Frame.Label.TextColor3 = Color3.new(0.65, 0.65, 0.65);
					v20.Frame.ImageLabel.ImageColor3 = Color3.new(0.65, 0.65, 0.65);
					u31 = false;
				end;
				v20.StudsOffset = Vector3.new(0, 0, 0);
				v20.Parent = l__CurrentCamera__8;
				v20.Adornee = u10.PosPart;
				v20.Enabled = not u1;
				u2.Enabled = false;
			else
				v20.Parent = nil;
				v20.Enabled = false;
				u10 = nil;
				u31 = false;
				if u2 then
					u2.Enabled = true;
				end;
			end;
		else
			v20.Parent = nil;
			v20.Enabled = false;
			u10 = nil;
			u31 = false;
			if u2 then
				u2.Enabled = true;
			end;
		end;
		if not u31 then
			Close();
			if l__Doing__32.Value then
				l__Doing__32.Value = nil;
				spawn(function()
					l__Remote__16:InvokeServer("C");
				end);
			end;
		end;	
	end;
	Close();
end);
l__Parent__8.Unequipped:Connect(function()
	u29 = false;
	u31 = false;
	Close();
end);
l__Parent__8.Activated:Connect(function()
	if u29 and not u1 and u6 < 30 and u10 and u31 then
		MainHandler(u10.Values.LockpickBars.Value, u10);
	end;
end);
l__ReplicatedStorage__2.Events2.InputTypeChanged.Event:Connect(function(p16)
	if p16 == 3 then
		l__MF__23.MobileButton.Visible = true;
		return;
	end;
	l__MF__23.MobileButton.Visible = false;
end);
if _G.InputType == 3 then
	l__MF__23.MobileButton.Visible = true;
else
	l__MF__23.MobileButton.Visible = false;
end;
(function()
	local function v85(p17)
		if not p17:WaitForChild("DFrame", 2) then
			warn("No DFrame in door!");
			return;
		end;
		local l__DFrame__86 = p17.DFrame;
		table.insert(u7, l__DFrame__86);
		local u33 = nil;
		u33 = l__DFrame__86.AncestryChanged:Connect(function(p18, p19)
			if not p19 then
				for v87, v88 in pairs(u7) do
					if v88 == l__DFrame__86 then
						table.remove(u7, v87);
					end;
				end;
				u33:Disconnect();
			end;
		end);
	end;
	for v89, v90 in pairs(l__Map__21.Doors:GetChildren()) do
		v85(v90);
	end;
	l__Map__21.Doors.ChildAdded:Connect(v85);
	local function v91(p20)
		if not p20:WaitForChild("MainPart", 2) then
			warn("No DFrame in door!");
			return;
		end;
		local l__MainPart__92 = p20.MainPart;
		table.insert(u7, l__MainPart__92);
		local u34 = nil;
		u34 = l__MainPart__92.AncestryChanged:Connect(function(p21, p22)
			if not p22 then
				for v93, v94 in pairs(u7) do
					if v94 == l__MainPart__92 then
						table.remove(u7, v93);
					end;
				end;
				u34:Disconnect();
			end;
		end);
	end;
	for v95, v96 in pairs(l__Map__21.BredMakurz:GetChildren()) do
		v91(v96);
	end;
	l__Map__21.BredMakurz.ChildAdded:Connect(v91);
end)();
