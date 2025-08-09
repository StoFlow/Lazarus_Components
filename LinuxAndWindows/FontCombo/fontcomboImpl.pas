          { written by (copyright) StoFlow [Pseudonym] - some parts were initially taken from Lazarus example '\examples\fontenum' }
Unit
          fontcomboImpl;

          {$mode ObjFPC}{$H+}
          {$ModeSwitch typehelpers}
          {$R fontcombo_images.res}

Interface

Uses
          Classes,
          SysUtils,
          LResources,
          Forms,
          Controls,
          Graphics,
          StdCtrls,
          lclintf,
          lclType,
          Dialogs;


Type
          tFontPitch                        = ( fp_DEFAULT_PITCH= 0, fp_FIXED_PITCH= 1, fp_VARIABLE_PITCH= 2, fp_MONO_FONT= 8 );
          tPropFontPitch                    = fp_FIXED_PITCH.. fp_MONO_FONT;
          tPropFontPitches                  = Set Of tPropFontPitch;
          tAPIFontPitch                     = DEFAULT_PITCH.. MONO_FONT;

          tString                           = Class( tObject)
             Value                          : String;

             Class Function                 new( aString: String): tString;
          End;


          tHPropFontPitches                 = Type Helper For tPropFontPitches

             Function                       Contains( aFontPitch: tFontPitch): boolEan;
             Function                       IsEmpty(): boolEan;
             Function                       IsEmptyOrContains( aFontPitch: tFontPitch): boolEan;

          End;

          tWinCtrlCollItem                  = Class( tCollectionItem)
          Private
             _WinControl                    : tWinControl;

          Published

             Property                       WinControl: tWinControl Read _WinControl write _WinControl;

          End;

          tWinCtrlCollection                = Class( tOwnedCollection)

          End;

          pBitmap                           =^tBitmap;


          tFontComboPicSize                 = ( fcps_noPics, fcps_16);
          tFontComboFontType                = ( FXD, FMO, VRL, VMO, MNO, UNK);

          { tHTypeHelperCmbFntTpe }

          tHTypeHelperCmbFntTpe             = Type Helper For tFontComboFontType

             Function                       getName(): String;
             Function                       getNameLwr(): String;

          End;


          { tHTypeHelperString }

          tHTypeHelperString                = Type Helper( tStringHelper) For String

             Function                       toIntDef( aDefaultVal: intEger= 0): intEger;
             Function                       toFntCbFntTpe( aDefaultVal: tFontComboFontType= tFontComboFontType.UNK): tFontComboFontType;

          End;

          tFontCombo                        = Class( tCustomComboBox)

          Private

             BmUNK                          : tBitmap;
             BmFXD                          : tBitmap;
             BmFMO                          : tBitmap;
             BmVRL                          : tBitmap;
             BmVMO                          : tBitmap;
             BmMNO                          : tBitmap;

             Const                          cstrNoPics= 'noPics';
             Const                          cstrFoCoPX= 'FoCo';

          Protected

             _Pitches                       : tPropFontPitches;
             _DesignTime                    : boolEan;
             _ApplyChain                    : tWinCtrlCollection;
             _PreView                       : boolEan;
             _PicSize                       : tFontComboPicSize;
             _TraPrtBMC                     : tColor;

             Type

             tEnumFontData                  = Class

                Fonts                       : tStringList;
                Parent                      : tFontCombo;

             End;

             Function                       initializeEFD(): tEnumFontData;
             Procedure                      finalizeEFD( Var aEFD: tEnumFontData);

             Function                       getPicSzeTkn(): String;
             Function                       fntCboPicSzeToInt(): intEger;
             Function                       fontTypeToResName( aType: tFontComboFontType): String;
             Function                       getOneFontPic( aType: tFontComboFontType): tBitmap;
             Procedure                      loadPics();

             Procedure                      unLoadOnePic( aPic: pBitmap);
             Procedure                      unLoadPics();
             Procedure                      reLoadPics();
             Function                       checkGetDefaultPic(): tBitmap;
             Function                       getBitmapByFontType( aType: String): tBitmap;
             Function                       getBitmapByIndex( aIndex: intEger; Out aOutBtMp: tBitmap): boolEan;

             Procedure                      addAndMergeFonts( Var aExstngList: tStringList; aFontsToAdd: tStringList);
             Function                       apiReloadFonts41PAF( Var aVarSL: tStringList; aPAF: Byte): intEger; // PAF => Pitch And Family
             Function                       apiReloadFonts( Var aVarSL: tStringList): intEger;

             Procedure                      setFontPitches( aPitches: tPropFontPitches); Virtual;
             Procedure                      setDsngTme    ( aDsngTme: boolEan); Virtual;
             Procedure                      setFontToChain(); Virtual;
             Procedure                      setApplyChain ( aChain  : tWinCtrlCollection); Virtual;
             Procedure                      setPreView    ( aDoPrev : boolEan); Virtual;
             Procedure                      setPicSize    ( aPcSze  : tFontComboPicSize); Virtual;
             Procedure                      setTraBMCol   ( aNewColor: tColor);

             Function                       getHaveNoPics(): boolEan;

             Procedure                      change(); Override;

             Procedure                      drawText( aRect: tRect; Const aText: String);
             Procedure                      drawItem( aIndex: Integer; aRect: tRect; aState: tOwnerDrawState); Override;

             Procedure                      setItemIndex( Const aItmIdx: intEger); Override;

             Procedure                      freeOneItemObject( Const aCurVal: String; Const aIndex: intEger; aObj: tObject);
             Procedure                      freeItemObjects();
             Procedure                      freeItemsAndObjects();

          Public

             Procedure                      reloadFonts();
             Procedure                      conditionallyReload();
             Constructor                    create( aOwner: tComponent); Override;
             Destructor                     destroy(); Override;

             Property                       NoPics: boolEan Read getHaveNoPics;

          Published

             Property                       Align;
             Property                       Anchors;
             Property                       ArrowKeysTraverseList;
             Property                       AutoComplete;
             Property                       AutoCompleteText;
             Property                       AutoDropDown;
             Property                       AutoSelect;
             Property                       AutoSize;
             Property                       BidiMode;
             Property                       BorderSpacing;
             Property                       BorderStyle;
             Property                       CharCase;
             Property                       Color;
             Property                       Constraints;
             Property                       DoubleBuffered;
             Property                       DragCursor;
             Property                       DragKind;
             Property                       DragMode;
             Property                       DropDownCount;
             Property                       Enabled;
             Property                       Font;
             Property                       ItemHeight;
             Property                       ItemIndex;
             Property                       Items;
             Property                       ItemWidth;
             Property                       MaxLength;
             Property                       ParentBidiMode;
             Property                       ParentColor;
             Property                       ParentDoubleBuffered;
             Property                       ParentFont;
             Property                       ParentShowHint;
             Property                       PopupMenu;
             Property                       ReadOnly;
             Property                       ShowHint;
             Property                       Sorted;

             Property                       TabOrder;
             Property                       TabStop;
             Property                       Text;
             Property                       TextHint;
             Property                       Visible;

             Property                       OnChange;
             Property                       OnChangeBounds;
             Property                       OnClick;
             Property                       OnCloseUp;
             Property                       OnContextPopup;
             Property                       OnDblClick;
             Property                       OnDragDrop;
             Property                       OnDragOver;
             Property                       OnDrawItem;
             Property                       OnEndDrag;
             Property                       OnDropDown;
             Property                       OnEditingDone;
             Property                       OnEnter;
             Property                       OnExit;
             Property                       OnGetItems;
             Property                       OnKeyDown;
             Property                       OnKeyPress;
             Property                       OnKeyUp;
             Property                       OnMeasureItem;
             Property                       OnMouseDown;
             Property                       OnMouseEnter;
             Property                       OnMouseLeave;
             Property                       OnMouseMove;
             Property                       OnMouseUp;
             Property                       OnMouseWheel;
             Property                       OnMouseWheelDown;
             Property                       OnMouseWheelUp;
             Property                       OnSelect;
             Property                       OnStartDrag;
             Property                       OnUTF8KeyPress;

             Property                       Pitches               : tPropFontPitches    Read _Pitches    Write setFontPitches;
             Property                       DesignTime            : boolEan             Read _DesignTime Write setDsngTme;
             Property                       ApplyChain            : tWinCtrlCollection  Read _ApplyChain Write setApplyChain;
             Property                       PreView               : boolEan             Read _PreView    Write setPreView;
             Property                       PicSize               : tFontComboPicSize   Read _PicSize    Write setPicSize;
             Property                       TransparentBitmapColor: tColor              Read _TraPrtBMC  Write setTraBMCol;


          End;


Procedure
          Register;

Implementation

Uses
          typInfo;

Procedure
          Register;
Begin
          {$I fontcomboIcons.lrs}
          registerComponents( 'StoFlow',[ tFontCombo]);
End;

Class Function
          tString.new( aString: String): tString;
Begin
          Result:= tString.create();
          Result.Value:= aString;
End;

          { tHTypeHelperString }

Function
          tHTypeHelperString.toIntDef( aDefaultVal: intEger= 0): intEger;
Begin
          Result:= strToIntDef( Self, aDefaultVal);
End;

Function
          tHTypeHelperString.toFntCbFntTpe( aDefaultVal: tFontComboFontType= tFontComboFontType.UNK): tFontComboFontType;
Var
          vtFCT1                            : tFontComboFontType;
          vStS2L                            : String;
Begin
          Result:= aDefaultVal;
          If ( ''= Self)
             Then
             Exit;

          vStS2L:= Self.toLower();

          For vtFCT1 In tFontComboFontType
              Do
              Begin
                   If ( vStS2L= vtFCT1.getNameLwr())
                      Then
                      Begin
                           Result:= vtFCT1;
                           Exit;
                   End;
          End;
End;

          { tHPropFontPitches }

Function
          tHPropFontPitches.Contains( aFontPitch: tFontPitch): boolEan;
Begin
          Result:= aFontPitch In Self;
End;

Function
          tHPropFontPitches.IsEmpty(): boolEan;
Begin
          Result:= ( []= Self);
End;

Function
          tHPropFontPitches.IsEmptyOrContains( aFontPitch: tFontPitch): boolEan;
Begin
          Result:= IsEmpty() Or Contains( aFontPitch);
End;

Function
          tHTypeHelperCmbFntTpe.getName(): String;
Begin
          Result:= getEnumName( typeInfo( tFontComboFontType), Ord( Self));
End;

Function
          tHTypeHelperCmbFntTpe.getNameLwr(): String;
Begin
          Result:= getName().toLower();
End;


          { Common }
Function
          lfPAF2PitchName( aPAF: Byte): String;
Begin
          Result:= tFontComboFontType.UNK.getName();

          If ( 49= ( aPAF And 49))               // Fixed Mono       => found under my W11
             Then
             Result:= tFontComboFontType.FMO.getName()
          Else
             If ( 50= ( aPAF And 50))            // Variable Mono    => found under my W11
                Then
                Result:= tFontComboFontType.VMO.getName()
             Else
                If ( 08= ( aPAF And 08))         // Only Mono ?      => not found under my W11
                   Then
                   Result:= tFontComboFontType.MNO.getName()
                Else
                   If ( 01= ( aPAF And 01))      // Only Fixed       => not found under my W11
                      Then
                      Result:= tFontComboFontType.FXD.getName()
                   Else
                      If ( 02= ( aPAF And 02))   // Only Variable    => found under my W11
                         Then
                         Result:= tFontComboFontType.VRL.getName()

End;

          {$hints off}
Procedure
          _nOp( Const aAOC: Array Of Const);
Begin
          //
End;
          {$hints on}

Function
          enumDistinctFontNames( Var aLogFont: tEnumLogFontEx; Var aMetric: tNewTextMetricEx; aFontType: Longint; aData: lParam): longInt; Stdcall;
Var
          vtEFD1                            : tFontCombo.tEnumFontData;
          vStFntNme                         : String;
          vStFntPtch                        : String;
Begin
          _nOp( [ @aMetric, aFontType]);

          If ( 0= aData)
             Then
             Exit;

          Try
             vtEFD1:= tFontCombo.tEnumFontData( ptrInt( aData));
             vStFntNme  := aLogFont.elfLogFont.lfFaceName;
             vStFntPtch := lfPAF2PitchName( aLogFont.elfLogFont.lfPitchAndFamily);

             If vtEFD1.Parent.Pitches.IsEmpty
                Or
                ( ( 01= ( aLogFont.elfLogFont.lfPitchAndFamily And 01)) And vtEFD1.Parent.Pitches.IsEmptyOrContains( fp_FIXED_PITCH))
                Or
                ( ( 02= ( aLogFont.elfLogFont.lfPitchAndFamily And 02)) And vtEFD1.Parent.Pitches.IsEmptyOrContains( fp_VARIABLE_PITCH))
                Or
             {$ifdef Windows}
                ( ( 48= ( aLogFont.elfLogFont.lfPitchAndFamily And 48)) And vtEFD1.Parent.Pitches.IsEmptyOrContains( fp_MONO_FONT))
             {$Else}
                ( ( 08= ( aLogFont.elfLogFont.lfPitchAndFamily And 08)) And vtEFD1.Parent.Pitches.IsEmptyOrContains( fp_MONO_FONT))
             {$EndIf}
                Then
                If ( 0> vtEFD1.Fonts.IndexOf( vStFntNme))
                   Then
                   Begin
                        vtEFD1.Fonts.addObject( vStFntNme, tString.new( vStFntPtch));
                End;

             Result:= 1;
          Except
             Result:= 0;
          End;
End;


Function
          tFontCombo.initializeEFD(): tEnumFontData;
Begin
          Result       := tEnumFontData.create();
          Result.Fonts := tStringList.create();
          Result.Parent:= Self;
End;

Procedure
          tFontCombo.finalizeEFD( Var aEFD: tEnumFontData);
Begin
          aEFD.Parent:= Nil;
          aEFD.Fonts.clear();
          freeAndNil( aEFD.Fonts);
          freeAndNil( aEFD);
End;

Function
          tFontCombo.getPicSzeTkn(): String;
Var
          vStBasName                        : String;
          aosParts                          : tStringArray;
Begin
          Result:= cstrNoPics.toLower();

          vStBasName:= getEnumName( typeInfo( tFontComboPicSize), Ord( PicSize));

          aosParts:= vStBasName.Split( '_');
          If ( 2= length( aosParts))
             Then
             Result:= aosParts[ length( aosParts)- 1];

          aosParts:= [];

End;

Function
          tFontCombo.getHaveNoPics(): boolEan;
Begin
          Result:= ( cstrNoPics.toLower()= getPicSzeTkn());
End;


Function
          tFontCombo.fntCboPicSzeToInt(): intEger;
Var
          vStResSize                        : String;
Begin

          Result    := 1; // smalle gappe
          vStResSize:= getPicSzeTkn();
          Result    := vStResSize.toIntDef( Result);
End;


Function
          tFontCombo.fontTypeToResName( aType: tFontComboFontType): String;
Var
          vStBasName                        : String;
          vStTkn                            : String;
Begin
          Result:= '';
          vStTkn:= getPicSzeTkn();
          If vStTkn.toLower()= cstrNoPics.toLower()
             Then
             Exit;

          vStBasName:= aType.getName();
          Result:= vStBasName+ vStTkn;
End;


Function
          tFontCombo.getOneFontPic( aType: tFontComboFontType): tBitmap;
Var
          vStResName                        : String;
Begin
          Result:= tBitmap.create();
          Try
             vStResName:= fontTypeToResName( aType);
             If ( ''<> vStResName)
                Then
                Result.loadFromResourceName( hINSTANCE, cstrFoCoPX+ vStResName);
          Except
          End;
End;


Procedure
          tFontCombo.loadPics();
Begin
          BmUNK:= getOneFontPic( tFontComboFontType.UNK);
          BmFXD:= getOneFontPic( tFontComboFontType.FXD);
          BmFMO:= getOneFontPic( tFontComboFontType.FMO);
          BmVRL:= getOneFontPic( tFontComboFontType.VRL);
          BmVMO:= getOneFontPic( tFontComboFontType.VMO);
          BmMNO:= getOneFontPic( tFontComboFontType.MNO);
End;

Procedure
          tFontCombo.unLoadOnePic( aPic: pBitmap);
Begin
          If Nil= aPic
             Then
             Exit;

          If not assigned( aPic^)
             Then
             Exit;

          Try
             aPic^.freeImage();
             aPic^.clear();
          Finally
             Try
                aPic^:= Nil;
             Except End;
          End;
End;

Procedure
          tFontCombo.unLoadPics();
Begin
          unLoadOnePic( @BmMNO);
          unLoadOnePic( @BmFXD);
          unLoadOnePic( @BmFMO);
          unLoadOnePic( @BmVRL);
          unLoadOnePic( @BmVMO);
          unLoadOnePic( @BmUNK);
End;

Procedure
          tFontCombo.reLoadPics();
Begin
          unLoadPics();
          loadPics();
End;


Function
          tFontCombo.checkGetDefaultPic(): tBitmap;
Begin
          If ( Nil= BmUNK)
             Then
             BmUnk:= getOneFontPic( tFontComboFontType.UNK);

          If ( Nil= BmUnk)
             Then
             BmUnk:= tBitmap.create();

          Result:= BmUnk;
End;

Function  // just returns a cached BMs
          tFontCombo.getBitmapByFontType( aType: String): tBitmap;
Var
          vStFCPx                           : String;
Begin
          Result := BmUnk;
          vStFCPx:= cstrFoCoPX.toLower();

          If ( aType.toLower()= ( vStFCPx+ FXD.getNameLwr()))
             Then
             Result:= BmFXD;

          If ( aType.toLower()= ( vStFCPx+ FMO.getNameLwr()))
             Then
             Result:= BmFMO;

          If ( aType.toLower()= ( vStFCPx+ VRL.getNameLwr()))
             Then
             Result:= BmVRL;

          If ( aType.toLower()= ( vStFCPx+ VMO.getNameLwr()))
             Then
             Result:= BmVMO;

          If ( aType.toLower()= ( vStFCPx+ MNO.getNameLwr()))
             Then
             Result:= BmMNO;

End;


Function
          tFontCombo.getBitmapByIndex( aIndex: intEger; Out aOutBtMp: tBitmap): boolEan;
Var
          vtSt1                             : tString;
          vStFTpe                           : String;
Begin
          aOutBtMp:= Nil;
          Result  := False;

          vtSt1   := Items.Objects[ aIndex] As tString;
          If ( Nil= vtSt1)
             Then
             Exit;

          Try
             vStFTpe:= cstrFoCoPX+ vtSt1.Value;
             aOutBtMp:= getBitmapByFontType( vStFTpe);
          Except End;

          If Nil= aOutBtMp
             Then
             aOutBtMp:= checkGetDefaultPic();

          Result:= ( Nil<> aOutBtMp);
End;

Procedure
          tFontCombo.addAndMergeFonts( Var aExstngList: tStringList; aFontsToAdd: tStringList);
Var
          vIn1                              : intEger;
          vIn2                              : intEger;

          vStOneFnt                         : String;

          vtObjPtch                         : tObject;
          vtStPtch                          : tString;

          vInHit                            : intEger;
          vtObjHit                          : tObject;
          vtStHit                           : tString;
Begin
          If ( Nil= aExstngList)
             Or
             ( Nil= aFontsToAdd)
             Then
             Exit;

          vIn2:= aFontsToAdd.Count;
          For vIn1:= 0 To ( vIn2- 1)
              Do
              Begin
                   vStOneFnt:= aFontsToAdd        [ vIn1];
                   vtObjPtch:= aFontsToAdd.Objects[ vIn1];
                   vInHit:= aExstngList.IndexOf( vStOneFnt);
                   If ( 0> vInHit)
                      Then
                      Begin
                           aExstngList.addObject( vStOneFnt, vtObjPtch);
                           conTinue;
                   End;

                   vtObjHit:= aExstngList.Objects[ vInHit];
                   If ( Nil=  vtObjPtch)
                      Or
                      ( Nil=  vtObjHit)
                      Or
                      ( Not ( vtObjPtch Is tString))
                      Or
                      ( Not ( vtObjHit  Is tString))
                      Then
                      conTinue;

                   vtStPtch:= vtObjPtch As tString;
                   vtStHit := vtObjHit  As tString;

                   If ( vtStPtch.Value= vtStHit.Value)
                      Then
                      conTinue;

                   If ( vtStPtch.Value.toFntCbFntTpe()= tFontComboFontType.UNK)
                      Or
                      (  vtStHit.Value.toFntCbFntTpe()= tFontComboFontType.UNK)
                      Then
                      conTinue;

                   If ( ( vtStPtch.Value.toFntCbFntTpe()= tFontComboFontType.FXD) And (  vtStHit.Value.toFntCbFntTpe()= tFontComboFontType.MNO))
                      Or
                      ( ( vtStPtch.Value.toFntCbFntTpe()= tFontComboFontType.MNO) And (  vtStHit.Value.toFntCbFntTpe()= tFontComboFontType.FXD))
                      Then
                      vtStHit.Value:= tFontComboFontType.FMO.getName();

                   If ( ( vtStPtch.Value.toFntCbFntTpe()= tFontComboFontType.VRL) And (  vtStHit.Value.toFntCbFntTpe()= tFontComboFontType.MNO))
                      Or
                      ( ( vtStPtch.Value.toFntCbFntTpe()= tFontComboFontType.MNO) And (  vtStHit.Value.toFntCbFntTpe()= tFontComboFontType.VRL))
                      Then
                      vtStHit.Value:= tFontComboFontType.VMO.getName();

          End;
End;

Function
          tFontCombo.apiReloadFonts41PAF( Var aVarSL: tStringList; aPAF: Byte): intEger;
Var
          vhDC1                             : hDC;
          vtLf1                             : tLogFont;
          vtEFD1                            : tEnumFontData;
Begin
          Result:= -1;
          Try

             vtLf1.lfCharSet       := DEFAULT_CHARSET;
             vtLf1.lfFaceName      := '';
             vtLf1.lfPitchAndFamily:= aPAF;

             vhDC1                 := getDC( 0);

             vtEFD1                := initializeEFD();

             enumFontFamiliesEX( vhDC1, @vtLf1, @enumDistinctFontNames, lParam( vtEFD1), 0);
             If ( Nil<> vtEFD1.Fonts)
                Then
                //aVarSL.AddStrings( vtEFD1.Fonts);
                addAndMergeFonts( aVarSL, vtEFD1.Fonts);

          Finally

             releaseDC( 0, vhDC1);
             finalizeEFD( vtEFD1);

          End;
End;

Function
          tFontCombo.apiReloadFonts( Var aVarSL: tStringList): intEger;
Var
          vByPAF                            : tPropFontPitch;
Begin
          Result:= -1;
          Try
             aVarSL:= tStringList.create();
             If ( Pitches.IsEmpty) // works good wth Win11, not that good wth (my) Lnxs
                Then
                apiReloadFonts41PAF( aVarSL, 0)
             Else
                For vByPAF In Pitches
                    Do
                    Begin
                         apiReloadFonts41PAF( aVarSL, Byte( vByPAF));
                End;

             Result:= aVarSL.Count;

          Except End;
End;

Procedure
          tFontCombo.reloadFonts();
Var
          vtSl1                             : tStringList;
Begin

          Items.beginUpdate();
          Try
             Items.clear();
             vtSl1:= Nil;
             If ( 0< apiReloadFonts( vtSl1))
                Then
                Begin
                     If Sorted And ( Nil<> vtSl1)
                        Then
                        Begin
                             vtSl1.Sort();
                             Items.addStrings( vtSl1);
                     End;
             End;
          Finally
             Try
                vtSl1.clear();
                freeAndNil( vtSl1);
             Except End;
             Items.endUpdate();
          End;
End;

Procedure
          tFontCombo.conditionallyReload();
Begin
          If ( csDesigning in ComponentState) And ( Not DesignTime)
             Then
             Begin
                  Items.clear();
                  Exit;
          End;
          reloadFonts();
End;

Procedure
          tFontCombo.setFontPitches( aPitches: tPropFontPitches);
Begin
          If ( _Pitches= aPitches)
             Then
             Exit;

          _Pitches:= aPitches;
          conditionallyReload();

End;

Procedure
          tFontCombo.setDsngTme( aDsngTme: boolEan);
Begin
          If ( _DesignTime= aDsngTme)
             Then
             Exit;

          _DesignTime:= aDsngTme;
          conditionallyReload();

End;

Procedure
          tFontCombo.setFontToChain();
Var
          vtCItm                            : tCollectionItem;
          vtWcI                             : tWinCtrlCollItem;
Begin
          For vtCItm In _ApplyChain
              Do
              Begin
                   Try
                      If Not assigned( vtCItm)
                         Then
                         conTinue;

                      vtWcI:= vtCItm As tWinCtrlCollItem;
                      If assigned( vtWcI.WinControl)
                         And
                         ( ''<> Self.Text)
                         And
                         ( Self.Text<> vtWcI.WinControl.Font.Name)
                         Then
                         vtWcI.WinControl.Font.Name:= Self.Text;

                   Except End;
          End;
End;

Procedure
          tFontCombo.setApplyChain( aChain: tWinCtrlCollection);
Begin
          If _ApplyChain= aChain
             Then
             Exit;

          _ApplyChain:= aChain;
          setFontToChain();
End;

Procedure
          tFontCombo.setPreView( aDoPrev: boolEan);
Begin
          If _PreView= aDoPrev
             Then
             Exit;

          _PreView:= aDoPrev;
          rePaint();
End;

Procedure
          tFontCombo.setPicSize( aPcSze  : tFontComboPicSize);
Begin
          If ( _PicSize= aPcSze)
             Then
             Exit;

          _PicSize:= aPcSze;
          reLoadPics();
          rePaint();
End;

Procedure
          tFontCombo.setTraBMCol( aNewColor: tColor);
Begin
          If ( aNewColor= _TraPrtBMC)
             Then
             Exit;

          _TraPrtBMC:= aNewColor;
          rePaint();
End;


Procedure
          tFontCombo.change();
Begin
          Inherited change();
          setFontToChain();
End;

Procedure
          tFontCombo.drawText( aRect: tRect; Const aText: String);
Var
          OldBrushStyle                     : tBrushStyle;
          OldTextStyle                      : tTextStyle;
          NewTextStyle                      : tTextStyle;
Begin
          OldBrushStyle                  := Canvas.Brush.Style;
          OldTextStyle                   := Canvas.TextStyle;

          Canvas.Brush.Style             := bsClear;

          NewTextStyle                   := OldTextStyle;
          NewTextStyle.Layout            := tlCenter;
          NewTextStyle.RightToLeft       := UseRightToLeftReading;

          NewTextStyle.SystemFont        := False;

          If UseRightToLeftAlignment
             Then
             Begin
                  NewTextStyle.Alignment := taRightJustify;
                  aRect.Right            := ARect.Right - 2;
             End
          Else
             Begin
                  NewTextStyle.Alignment := taLeftJustify;
                  aRect.Left             := aRect.Left + 2;
          End;

          Canvas.TextStyle               := NewTextStyle;

          If ( ''<> aText) And PreView
             Then
             Canvas.Font.Name            := aText;

          Canvas.TextRect( aRect, ARect.Left, ARect.Top, aText);

          Canvas.Brush.Style             := OldBrushStyle;
          Canvas.TextStyle               := OldTextStyle;
End;


Procedure
          tFontCombo.drawItem( aIndex: Integer; aRect: tRect; aState: tOwnerDrawState);
Var
          vtBm1                             : tBitmap;
          vInPicW                           : Integer;
          vtRe1                             : tRect;
          vStItmTxt                         : String;
Begin
          Self.Canvas.FillRect( aRect);
          vInPicW  := fntCboPicSzeToInt();
          If getBitmapByIndex( aIndex, vtBm1)
             Then
             Begin
                  vInPicW := vtBm1.Width;
                  Self.Canvas.brushCopy(
                       bounds( aRect.Left+ 2, ( aRect.Top+ aRect.Bottom- vtBm1.Height) Div 2, vtBm1.Width, vtBm1.Height),
                       vtBm1,
                       bounds( 0, 0, vtBm1.Width, vtBm1.Height),
                       TransparentBitmapColor
                  );
          End;
          vtRe1        := aRect;
          vtRe1.Left   := vtRe1.Left + vInPicW+ 4;
          vtRe1.Width  := vtRe1.Width- vInPicW- 4;

          vStItmTxt:= Items[ aIndex];
          //If ( Nil<> vtBmDrv)
          //   And
          //   (  ''<> vtBmDrv.DrvDscr)
          //   Then
          //   vStItmTxt+= ' ('+ vtBmDrv.DrvDscr+ ')';


          If Not ( odBackgroundPainted in aState)
             Then
             Self.Canvas.fillRect( vtRe1);

          drawText( vtRe1, vStItmTxt);
End;

Procedure
          tFontCombo.setItemIndex( Const aItmIdx: intEger);
Begin
          If ( ItemIndex= aItmIdx)
             Then
             Exit;

          Inherited SetItemIndex( aItmIdx);
          change();
End;


Procedure
          tFontCombo.freeOneItemObject( Const aCurVal: String; Const aIndex: intEger; aObj: tObject);
Var
          vtObjFree                         : tObject;
Begin
          _nOp( [ aCurVal, aIndex]);

          vtObjFree:= aObj;
          If ( Nil= vtObjFree)
             Then
             Exit;

          freeAndNil( vtObjFree)
End;
          {$hints on}

Procedure
          tFontCombo.freeItemObjects();
Begin
          Items.ForEach( @freeOneItemObject);
End;

Procedure
          tFontCombo.freeItemsAndObjects();
Begin
          ItemIndex:= -1;
          freeItemObjects();
          Items.clear();
End;


Destructor
          tFontCombo.destroy();
Begin
          freeItemsAndObjects();
          unLoadPics();
          Inherited destroy();
End;



Constructor
          tFontCombo.create( aOwner: tComponent);
Begin
          Inherited create( aOwner);
          setStyle     ( csOwnerDrawFixed);
          setSorted    ( True);
          setDsngTme   ( False);
          setPreView   ( False);
          setPicSize   ( fcps_noPics);
          setTraBMCol  ( clBlue);

          loadPics();

          _ApplyChain:= tWinCtrlCollection.create( Self, tWinCtrlCollItem);
End;

End.
