INCLUDE Irvine32.inc
INCLUDE macros.inc
BUFFER_SIZE = 5000
.data
front BYTE "*************************WELCOME TO XYZ MINI SHOPPING STORE***************************** "
userMenuStart BYTE "ENJOY HAPPY SHOPPING...."
userEnd BYTE "THANKS FOR SHOPPING :)"
adminEnd BYTE "OWNER: ANAS MALIK                         TEL: 021-111-121"
stamp BYTE "........."
bill BYTE "......."
adminUsername BYTE 30 DUP(?)
adminPassword BYTE 30 DUP(?)
customerUsername BYTE 30 DUP(?)
customerPassword BYTE 30 DUP(?)
customerUsername1 BYTE 30 DUP(?)
customerPassword1 BYTE 30 DUP(?)
userInfo BYTE 1000 DUP(?)
phonenumber BYTE 30 DUP(?)
POSTAL BYTE 30 DUP(?)
itemNo DWORD 500 DUP (0)
itemQua DWORD 500 DUP (0)
itemAmount DWORD 500 DUP (0)
coupon BYTE 30 DUP(?)
coupon1 BYTE "ABCD123",0
tt DWORD 0
status DWORD ?
filename BYTE "user.txt"
fileHandle HANDLE ?
buffer BYTE BUFFER_SIZE DUP(?)
var1 DWORD ?
var2 DWORD ?
len1 DWORD ?
len2 DWORD ?
len3 DWORD ?
count BYTE 0

NewLine BYTE 0Ah

.code
main PROC
call Setcolor
mov eax,1200
call DELAY
call FrontPage
call registerflush
call MenuChoice
call CartSystem
call Discount
call addAmount
exit
main ENDP
Setcolor PROC
mov eax,White +(Blue*16)
call SetTextColor
ret
Setcolor ENDP
registerflush PROC
    mov eax, 0  
    mov ebx, 0   
    mov ecx, 0   
    mov edx, 0 
ret
registerFlush ENDP

FrontPage PROC 
  call ClrScr
   mov dh,3
   mov dl,38
   call Gotoxy
   mov esi,OFFSET front
   mov ecx,LENGTHOF front
   l1:
       mov eax,[esi]
       call WriteChar
       mov eax,20
       call Delay
       add esi,1
   loop l1
   mov dh,5
   mov dl ,41
   call gotoxy
   mWrite "                   COAL PROJECT BY: MOHAMMAD ANAS (22k-4548)                    "

ret
FrontPage ENDP
MenuChoice PROC
   mov dh,7
   mov dl,41
   call gotoxy
   mWrite " Press 1 to continue: "
   labell:
   call ReadInt
   cmp eax,1
   je p1
   jmp p2
p1:
  call MainMenu
  jmp procede
p2:
   mov dh,7
   mov dl,65
   call gotoxy
   mWrite "Invalid Input"
   jmp labell
procede:

ret
MenuChoice ENDP
MainMenu PROC
  call Clrscr
  mov dh,10
  mov dl,38
  call gotoxy 
  mWrite "              PROCEEDING TOWARDS LOG IN/UP PORTAL"                 
 mov esi,OFFSET stamp
 mov ecx,SIZEOF stamp
 lb1:
  mov eax,[esi]
  call WriteChar
  mov eax,500
  call Delay
  inc esi
loop lb1
user: 
  call userMenu

procede:
ret
MainMenu ENDP
adminMenu PROC
  



ret
adminMenu ENDP
userMenu PROC
labelStart:
   call Clrscr
   mov dh,3
   mov dl,38
   call gotoxy 
   mWrite "                   SIGN UP/IN(Press 0/1): "
   call ReadDec
   cmp eax,0
   je l1
   jmp l2
l1:
   mov dh,5
   mov dl,38
   call gotoxy 
   mWrite "                    ENTER USERNAME: "
   mov edx,OFFSET filename
   call CreateOutputFile
   mov fileHandle,eax
   mov edx,OFFSET customerUsername
   mov ecx,LENGTHOF customerUsername
   call ReadString
   mov len1,eax
   mov eax,fileHandle
   mov edx,OFFSET customerUsername
   mov ecx,len1
   call WriteToFile
   mov eax,fileHandle
   mov edx,OFFSET NewLine
   mov ecx,SIZEOF NewLine
   call WriteToFile
   mov dh,7
   mov dl,38
   call gotoxy 
   mWrite "                    ENTER PASSWORD: "
   mov edx,OFFSET customerPassword
   mov ecx,LENGTHOF customerPassword
   call ReadString
   mov len2,eax
   mov eax,fileHandle
   mov edx,OFFSET customerPassword
   mov ecx,len2
   call WriteToFile
   mov eax,fileHandle
   mov edx,OFFSET NewLine
   mov ecx,SIZEOF NewLine
   call WriteToFile
   mov dh,9
   mov dl,38
   call Gotoxy
   mWrite "                    ENTER PHONE NUMBER: "
   mov edx,OFFSET phonenumber
   mov ecx,LENGTHOF phonenumber
   call ReadString
   mov len2,eax
   mov eax,fileHandle
   mov edx,OFFSET phonenumber
   mov ecx,len2
   call WriteToFile
   mov eax,fileHandle
   mov edx,OFFSET NewLine
   mov ecx,SIZEOF NewLine
   call WriteToFile
   mov dh,11
   mov dl,38
   call Gotoxy
   mWrite "                    ENTER POSTAL CODE: "
   mov edx,OFFSET POSTAL
   mov ecx,LENGTHOF POSTAL
   call ReadString
   mov len3,eax
   mov eax,fileHandle
   mov edx,OFFSET POSTAL
   mov ecx,len3
   call WriteToFile
   mov dh,14
   mov dl,38
   call Gotoxy
   mWrite"                        LOGGED UP SUCCESFULLY !"
   mov eax,2000
   call DELAY
   jmp labelStart
l2: 
   mov dh,5
   mov dl,38
   call gotoxy 
   mWrite "                   ENTER USERNAME: "
   mov edx,OFFSET customerUsername1
   mov ecx,LENGTHOF customerUsername1
   call ReadString
   mov dh,7
   mov dl,38
   call gotoxy 
   mWrite "                   ENTER PASSWORD: "
   mov edx,OFFSET customerPassword1
   mov ecx,LENGTHOF customerPassword1
   call ReadString
   INVOKE Str_compare, ADDR customerUsername,ADDR customerUsername1
   jnc l3
    mov dh,10
   mov dl,38
   mWrite"                                                     INVALID USERNAME AND PASSWORD "
   mov eax,1500
   call DELAY
   jmp labelStart
l3:
   jz l4
    mov dh,10
   mov dl,38
   mWrite"                                                     INVALID USERNAME AND PASSWORD "
   mov eax,1500
   call DELAY
   jmp labelStart
l4:
   INVOKE Str_compare, ADDR customerPassword,ADDR customerPassword1
   jnc l5
   mov dh,10
   mov dl,38
   mWrite"                                                      INVALID USERNAME AND PASSWORD "
   mov eax,1500
   call DELAY
   jmp labelStart
l5:
   jz procede
    mov dh,10
   mov dl,38
   mWrite"                                                       INVALID USERNAME AND PASSWORD "
   mov eax,1500
   call DELAY

   jmp labelStart
procede:
    mov dh,10
   mov dl,38
   mWrite"                                                          SUCCESFULLY LOGGED IN !"
   mov eax,1500
   call DELAY
   call MenuForUser
ret
userMenu ENDP
MenuForUser PROC
   call Clrscr
   mov dh,12
   mov dl,60
   call Gotoxy
   mWrite"RULES FOR SHOPPING "
   mov dh,14
   mov dl,60
   call Gotoxy
   mWrite "1: ENTER CORRECT ITEM NO "
   mov dh,16
   mov dl,60
   call Gotoxy
   mWrite "2: PRESS 0 TO PROCEED FOR BILL "
   mov eax,3000
   call DELAY
   call ClrScr
   mov dh,2
   mov dl,60
   call Gotoxy
   mov esi,OFFSET userMenuStart
   mov ecx,LENGTHOF userMenuStart
   l1:
       mov eax,[esi]
       call WriteChar
       mov eax,50
       call Delay
       add esi,1
   loop l1
   mov eax,800
   call Delay
   call ClrScr
   call ItemMenu
  
ret
MenuForUser ENDP
ItemMenu PROC
   mov dh,1
   mov dl,60
   call Gotoxy
   mWrite"    ================================="
   mov dh,2
   mov dl,60
   call Gotoxy
   mWrite"                 SHOP ITEMS" 
   mov dh,3
   mov dl,60
   call Gotoxy
   mWrite"    ================================="
   mov al,124
   mov dh,4
   mov dl,1
   mov ecx,30
l1:
  call Gotoxy
  call WriteChar
  inc dh
  mov al,124
loop l1
  mov dh,4
  mov dl,20
  call Gotoxy
  mWrite "MEN COLLECTION"
  mov dh,5
  mov dl,20
  call Gotoxy
  mWrite"---------------"
  mov al,124
  mov dh,4
  mov dl,83
  mov ecx,30
l2:
  call Gotoxy
  call Writechar
  inc dh
  mov al,124
loop l2
  mov dh,4
  mov dl,102
  call Gotoxy
  mWrite "WOMEN COLLECTION"
  mov dh,5
  mov dl,102
  call Gotoxy
  mWrite"-----------------"
  mov dh,6
  mov dl,3
  call Gotoxy
  mWrite"  1: SHALWAR KAMEEZ   /800Rs"
  mov dh,6
  mov dl,40
  call Gotoxy
  mWrite "   2: 3 PEICE   /1000Rs"
  mov dh,9
  mov dl,3
  call Gotoxy
  mWrite"  3: SHOES ADDIDAS   /5000Rs"
  mov dh,9
  mov dl,40
  call Gotoxy
  mWrite "   4: T SHIRT    /500Rs"
  mov dh,12
  mov dl,3
  call Gotoxy
  mWrite"  5:  GLASSES  /1000Rs"
  mov dh,12
  mov dl,40
  call Gotoxy
  mWrite "   6: CASUAL PANTS   /1500Rs"
  mov dh,15
  mov dl,3
  call Gotoxy
  mWrite"  7:  LEATHER WALLET  /2000Rs"
  mov dh,15
  mov dl,40
  call Gotoxy
  mWrite "   8: SMART WATCH   /3500Rs"
  mov dh,18
  mov dl,3
  call Gotoxy
  mWrite"  9: FORMAL PLAIN SHIRT   /1000Rs"
  mov dh,18
  mov dl,40
  call Gotoxy
  mWrite "   10: FORMAL TIE   /300Rs"
  mov dh,21
  mov dl,3
  call Gotoxy
  mWrite"  11: SOCKS   /200Rs"
  mov dh,21
  mov dl,40
  call Gotoxy
  mWrite "   12: SIMPLE WATCH   /1200Rs"
  mov dh,24
  mov dl,3
  call Gotoxy
  mWrite"  13: SHORTS   /500Rs"
  mov dh,24
  mov dl,40
  call Gotoxy
  mWrite "   14: TROUSER   /1000Rs"
  mov dh,27
  mov dl,3
  call Gotoxy
  mWrite"  15: TRACK SUIT   /1500Rs"
  mov dh,27
  mov dl,40
  call Gotoxy
  mWrite "   16: JACKET  /3000Rs"
  mov dh,6
  mov dl,86
  call Gotoxy
  mWrite"17: KURTI  /1500Rs"
  mov dh,6
  mov dl,123
  call Gotoxy
  mWrite"18: EARINGS  /500Rs"
   mov dh,9
  mov dl,86
  call Gotoxy
  mWrite"19: MAKEUP KIT  /15000Rs"
  mov dh,9
  mov dl,123
  call Gotoxy
  mWrite"20: SKIN CARE KIT /10000Rs"
   mov dh,12
  mov dl,86
  call Gotoxy
  mWrite"21: SANDALS  /5500Rs"
  mov dh,12
  mov dl,123
  call Gotoxy
  mWrite"22: HEELS  /4000Rs"
   mov dh,15
  mov dl,86
  call Gotoxy
  mWrite"23: BRACELETS  /800Rs"
  mov dh,15
  mov dl,123
  call Gotoxy
  mWrite"24: ANKLETS  /500Rs"
   mov dh,18
  mov dl,86
  call Gotoxy
  mWrite"25: RINGS  /1500Rs"
  mov dh,18
  mov dl,123
  call Gotoxy
  mWrite"26: SKIRTS /2000Rs"
   mov dh,21
  mov dl,86
  call Gotoxy
  mWrite"27: CARDIGAN  /5000Rs"
  mov dh,21
  mov dl,123
  call Gotoxy
  mWrite"28: LONG COATS  /4500Rs"
   mov dh,24
  mov dl,86
  call Gotoxy
  mWrite"29: ABAYA  /4000Rs"
  mov dh,24
  mov dl,123
  call Gotoxy
  mWrite"30: HAIRPINS  /200Rs"
   mov dh,27
  mov dl,86
  call Gotoxy
  mWrite"31: BANGLES  /500Rs"
  mov dh,27
  mov dl,123
  call Gotoxy
  mWrite"32: LENS   /1000Rs"
ret
ItemMenu ENDP
CartSystem PROC
  mov esi,OFFSET itemAmount
  mov ebx,OFFSET itemNo
  mov edi,OFFSET itemQua
label1:
  mov dh,35
  mov dl,75
  call Gotoxy
  mWrite" ENTER ITEM NO: "
  call ReadDec
  mov dh,35
  mov dl,75
  call Gotoxy             
  mWrite"                      "
  cmp eax,0
  je outt
  cmp eax,1
  je l1
  cmp eax,2
  je l2
  cmp eax,3
  je l3
  cmp eax,4
  je l4
  cmp eax,5
  je l5
  cmp eax,6
  je l6
  cmp eax,7
  je l7
  cmp eax,8
  je l8
  cmp eax,9
  je l9
  cmp eax,10
  je l10
  cmp eax,11
  je l11
  cmp eax,12
  je l12
  cmp eax,13
  je l13
  cmp eax,14
  je l14
  cmp eax,15
  je l15
  cmp eax,16
  je l16
  cmp eax,17
  je l17
  cmp eax,18
  je l18
  cmp eax,19
  je l19
  cmp eax,20
  je l20
  cmp eax,21
  je l21
  cmp eax,22
  je l22
  cmp eax,23
  je l23
  cmp eax,24
  je l24
  cmp eax,25
  je l25
  cmp eax,26
  je l26
  cmp eax,27
  je l27
  cmp eax,28
  je l28
  cmp eax,29
  je l29
  cmp eax,30
  je l30
  cmp eax,31
  je l31
  cmp eax,32
  je l32
  mov dh,35
  mov dl,75
  call Gotoxy            
  mWrite"   INVALID INPUT     "
  mov eax,500
  call Delay
  mov dh,35
  mov dl,75
  call Gotoxy   
  mWrite"                             "
  jmp label1
l1:
  mov edx,800
  mov [esi],edx
  add esi,TYPE itemAmount
  mov [ebx],eax
  add ebx,TYPE itemNO
  jmp quantity
 
l2:
  mov edx,1000
  mov [esi],edx
  add esi,TYPE itemAmount
  mov [ebx],eax
  add ebx,TYPE itemNO
  jmp quantity
  

l3:
  mov edx,5000
  mov [esi],edx
  add esi,TYPE itemAmount
  mov [ebx],eax
  add ebx,TYPE itemNO
  jmp quantity
l4:
  mov edx,500
  mov [esi],edx
  add esi,TYPE itemAmount
  mov [ebx],eax
  add ebx,TYPE itemNO
  jmp quantity

  
l5:
mov edx,1000
  mov [esi],edx
  add esi,TYPE itemAmount
  mov [ebx],eax
  add ebx,TYPE itemNO
  jmp quantity
l6:
mov edx,1500
  mov [esi],edx
  add esi,TYPE itemAmount
  mov [ebx],eax
  add ebx,TYPE itemNO
  jmp quantity
l7:
mov edx,2000
  mov [esi],edx
  add esi,TYPE itemAmount
  mov [ebx],eax
  add ebx,TYPE itemNO
  jmp quantity
l8:
mov edx,3500
  mov [esi],edx
  add esi,TYPE itemAmount
  mov [ebx],eax
  add ebx,TYPE itemNO
  jmp quantity
l9:
mov edx,1000
  mov [esi],edx
  add esi,TYPE itemAmount
  mov [ebx],eax
  add ebx,TYPE itemNO
  jmp quantity
l10:
 mov edx,300
  mov [esi],edx
  add esi,TYPE itemAmount
  mov [ebx],eax
  add ebx,TYPE itemNO
  jmp quantity
l11:
mov edx,200
  mov [esi],edx
  add esi,TYPE itemAmount
  mov [ebx],eax
  add ebx,TYPE itemNO
  jmp quantity
l12:
mov edx,1200
  mov [esi],edx
  add esi,TYPE itemAmount
  mov [ebx],eax
  add ebx,TYPE itemNO
  jmp quantity
l13:
mov edx,500
  mov [esi],edx
 add esi,TYPE itemAmount
  mov [ebx],eax
  add ebx,TYPE itemNO
  jmp quantity
l14:
mov edx,1000
  mov [esi],edx
  add esi,TYPE itemAmount
  mov [ebx],eax
  add ebx,TYPE itemNO
  jmp quantity
l15:
mov edx,1500
  mov [esi],edx
  add esi,TYPE itemAmount
  mov [ebx],eax
  add ebx,TYPE itemNO
  jmp quantity 
l16:
mov edx,3000
  mov [esi],edx
  add esi,TYPE itemAmount
  mov [ebx],eax
  add ebx,TYPE itemNO
  jmp quantity
l17:
mov edx,1500
  mov [esi],edx
  add esi,TYPE itemAmount
  mov [ebx],eax
  add ebx,TYPE itemNO
  jmp quantity
l18:
mov edx,500
  mov [esi],edx
  add esi,TYPE itemAmount
  mov [ebx],eax
  add ebx,TYPE itemNO
  jmp quantity
l19:
mov edx,15000   
  mov [esi],edx
  add esi,TYPE itemAmount
  mov [ebx],eax
  add ebx,TYPE itemNO
  jmp quantity
l20:
mov edx,10000
  mov [esi],edx
  add esi,TYPE itemAmount
  mov [ebx],eax
  add ebx,TYPE itemNO
  jmp quantity
l21:
mov edx,5500
  mov [esi],edx
  add esi,TYPE itemAmount
  mov [ebx],eax
  add ebx,TYPE itemNO
  jmp quantity
l22:
mov edx,4000
  mov [esi],edx
  add esi,TYPE itemAmount
  mov [ebx],eax
  add ebx,TYPE itemNO
  jmp quantity
l23:
mov edx,800
  mov [esi],edx
  add esi,TYPE itemAmount
  mov [ebx],eax
  add ebx,TYPE itemNO
  jmp quantity
l24:
mov edx,500
  mov [esi],edx
  add esi,TYPE itemAmount
  mov [ebx],eax
  add ebx,TYPE itemNO
  jmp quantity
l25:
mov edx,1500
  mov [esi],edx
  add esi,TYPE itemAmount
  mov [ebx],eax
  add ebx,TYPE itemNO
  jmp quantity
l26:
mov edx,2000
  mov [esi],edx
  add esi,TYPE itemAmount
  mov [ebx],eax
  add ebx,TYPE itemNO
  jmp quantity
l27:
mov edx,5000
  mov [esi],edx
  add esi,TYPE itemAmount
  mov [ebx],eax
  add ebx,TYPE itemNO
  jmp quantity
l28:
mov edx,4500
  mov [esi],edx
  add esi,TYPE itemAmount
  mov [ebx],eax
  add ebx,TYPE itemNO
  jmp quantity
l29:
mov edx,4000
  mov [esi],edx
  add esi,TYPE itemAmount
  mov [ebx],eax
  add ebx,TYPE itemNO
  jmp quantity
l30:
mov edx,200
  mov [esi],edx
  add esi,TYPE itemAmount
  mov [ebx],eax
  add ebx,TYPE itemNO
  jmp quantity
l31:
mov edx,500
  mov [esi],edx
  add esi,TYPE itemAmount
  mov [ebx],eax
  add ebx,TYPE itemNO
  jmp quantity
l32:
mov edx,1000
  mov [esi],edx
  add esi,TYPE itemAmount
  mov [ebx],eax
  add ebx,TYPE itemNO
  jmp quantity

  
quantity:
  mov dh,35
  mov dl,75
  call Gotoxy
  mWrite" ENTER QUANTITY: "
  call ReadDec
  mov [edi],eax
  add edi,TYPE itemQua
  mov dh,35
  mov dl,75
  call Gotoxy             
  mWrite"                      "
  jmp label1

outt:
  
ret
CartSystem ENDP

Discount PROC
label1:
call ClrScr
mov dh,12
mov dl,38
call Gotoxy
mWrite "              DO YOU HAVE DISCOUNT COUPON?(0(NO)/1(YES)): "
call ReadDec
cmp eax,1
je inputt
cmp eax,0
je outt
mov dh,14
mov dl,65
call Gotoxy
mWrite"INVALID INPUT                         "
mov eax,1000
call DELAY
jmp label1
inputt:
mov dh,17
mov dl,55
call Gotoxy
mWrite"ENTER COUPON: "
mov edx,OFFSET coupon
mov ecx,LENGTHOF coupon
call ReadString
INVOKE Str_compare, ADDR coupon,ADDR coupon1
jnc l1
mov dh,17
mov dl,55
call Gotoxy
mWrite"             INVALID COUPON                         "
mov status,0
mov eax,1000
call DELAY
jmp label1
l1:
  jz l2
  mov dh,17
  mov dl,55
  call Gotoxy
  mWrite"           INVALID COUPON                       "
  mov status,0
  mov eax,1000
  call DELAY
  jmp label1
l2:
  mov dh,20
  mov dl,65
  call Gotoxy
  mWrite"      COUPON ACCEPTED !"
  mov eax,2000
  call Delay
  mov status,1
outt:
mov eax,Black+(White*16)
call SetTextColor
call Billing
ret
Discount ENDP
Billing PROC
call ClrScr
mov dh,13
mov dl,60
call Gotoxy
mWrite" YOUR BILL IS GENERATING "
mov dh,13
mov dl,85
mov esi,OFFSET bill
mov ecx,SIZEOF bill
l1:
      call Gotoxy
      mov eax,[esi]
      call WriteChar
      mov eax,1000
      call DELAY
      inc esi
      inc dl
loop l1
call ClrScr
mov dh,2
mov dl,62
call Gotoxy
mWrite" BILLING STATEMENT"
mov dh,3
mov dl,37
mov ecx,34
l2:
  call Gotoxy
  mov eax,124
  call WriteChar
  mov eax,40
  call DELAY
  inc dh
loop l2
mov dh,3
mov dl,100
mov ecx,34
l3:
  call Gotoxy
  mov eax,124
  call WriteChar
  mov eax,40
  call DELAY
  inc dh
loop l3
mov dh,3
mov dl,38
mov ecx,62
l4:
  call Gotoxy
  mov eax,45
  call WriteChar
  mov eax,40
  call DELAY
  inc dl
loop l4
mov dh,36
mov dl,38
mov ecx,62
l5:
  call Gotoxy
  mov eax,45
  call WriteChar
  mov eax,40
  call DELAY
  inc dl
loop l5
call AddItemBill
ret
Billing ENDP
AddItemBill PROC
mov dh,5
mov dl,62
call Gotoxy
mWrite"  CUSTOMER INFO"
mov dh,6
mov dl,38
call gotoxy
mWrite"______________________________________________________________"
mov dh,7
mov dl,38
call gotoxy
mWrite"USERNAME: "
mov dh,7
mov dl,48
call Gotoxy
mov edx,OFFSET customerUsername
mov ecx,SIZEOF customerUsername
call WriteString
mov dh,7
mov dl,55
call gotoxy
mWrite"                      POSTAL CODE: "
mov dh,7
mov dl,90
call gotoxy
mov edx,OFFSET POSTAL
mov ecx,SIZEOF POSTAL
call WriteString
mov dh,8
mov dl,38
call gotoxy
mWrite"PHONE NUMBER: "
mov dh,8
mov dl,52
call Gotoxy
mov edx,OFFSET phonenumber
mov ecx,SIZEOF phonenumber
call WriteString
mov dh,9
mov dl,38
call Gotoxy
mWrite"______________________________________________________________"
mov dh,10
mov dl,38
call Gotoxy
mWrite"ITEM NAME"
mov dh,10
mov dl,55
call Gotoxy
mWrite"          QUANTITY"
mov dh,10
mov dl,90
call Gotoxy
mWrite"TOTAL"
mov dh,11
mov dl,38
call Gotoxy
mWrite"______________________________________________________________"
call itemAdd
ret
AddItemBill ENDP


itemAdd PROC
mov dh,12
mov dl,38
mov ebx,OFFSET itemQua
mov edi,OFFSET itemNo
mov ecx,LENGTHOF itemNo
label0:
  cmp ecx,0
  je label1
  mov eax,[edi]
  cmp eax,0
  je label1
  cmp eax,1
  je l1
  cmp eax,2
  je l2
  cmp eax,3
  je l3
  cmp eax,4
  je l4
  cmp eax,5
  je l5
  cmp eax,6
  je l6
  cmp eax,7
  je l7
  cmp eax,8
  je l8
  cmp eax,9
  je l9
  cmp eax,10
  je l10
  cmp eax,11
  je l11
  cmp eax,12
  je l12
  cmp eax,13
  je l13
  cmp eax,14
  je l14
  cmp eax,15
  je l15
  cmp eax,16
  je l16
  cmp eax,17
  je l17
  cmp eax,18
  je l18
  cmp eax,19
  je l19
  cmp eax,20
  je l20
  cmp eax,21
  je l21
  cmp eax,22
  je l22
  cmp eax,23
  je l23
  cmp eax,24
  je l24
  cmp eax,25
  je l25
  cmp eax,26
  je l26
  cmp eax,27
  je l27
  cmp eax,28
  je l28
  cmp eax,29
  je l29
  cmp eax,30
  je l30
  cmp eax,31
  je l31
  cmp eax,32
  je l32 
  l1:
      call Gotoxy
      mWrite"SHALWAR KAMEEZ"
      inc dh
      add edi,4
      jmp procede
  l2:
      call Gotoxy
      mWrite"3-PEICE"
      inc dh
      add edi,4
      jmp procede
  l3:
     call Gotoxy
      mWrite"SHOES ADDIDAS"
      inc dh
      add edi,4
      jmp procede
  l4:
  call Gotoxy
      mWrite"T-SHIRT"
      inc dh
      add edi,4
      jmp procede
  l5:
  call Gotoxy
      mWrite"GLASSES"
      inc dh
      add edi,4
      jmp procede
  l6:
  call Gotoxy
      mWrite"CASUAL PANTS"
      inc dh
      add edi,4
      jmp procede
  l7:
  call Gotoxy
      mWrite"LEATHER WALLET"
      inc dh
      add edi,4
      jmp procede
  l8:
  call Gotoxy
      mWrite"SMART WATCH"
      inc dh
      add edi,4
      jmp procede
  l9:
  call Gotoxy
      mWrite"FORMAL SHIRT"
      inc dh
      add edi,4
      jmp procede

  l10:
   call Gotoxy
      mWrite"FORMAL TIE"
      inc dh
      add edi,4
      jmp procede
  l11:
   call Gotoxy
      mWrite"SOCKS"
      inc dh
      add edi,4
      jmp procede
  l12:
   call Gotoxy
      mWrite"SIMPLE WATCH"
      inc dh
      add edi,4
      jmp procede
  l13:
   call Gotoxy
      mWrite"SHIRTS"
      inc dh
      add edi,4
      jmp procede
  l14:
   call Gotoxy
      mWrite"TROUSERS"
      inc dh
      add edi,4
      jmp procede
  l15:
   call Gotoxy
      mWrite"TRACK SUIT"
      inc dh
      add edi,4
      jmp procede
  l16:
   call Gotoxy
      mWrite"JACKET"
      inc dh
      add edi,4
      jmp procede
  l17:
   call Gotoxy
      mWrite"KURTI"
      inc dh
      add edi,4
      jmp procede
  l18:
   call Gotoxy
      mWrite"EARINGS"
      inc dh
      add edi,4
      jmp procede
  l19:
   call Gotoxy
      mWrite"MAKEUP KIT"
      inc dh
      add edi,4
      jmp procede
  l20:
   call Gotoxy
      mWrite"SKIN CARE KIT"
      inc dh
      add edi,4
      jmp procede
  l21:
     call Gotoxy
      mWrite"SANDALS"
      inc dh
      add edi,4
      jmp procede

  l22:
     call Gotoxy
      mWrite"HEELS"
      inc dh
      add edi,4
      jmp procede
  l23:
     call Gotoxy
      mWrite"BRACELETS"
      inc dh
      add edi,4
      jmp procede
  l24:
     call Gotoxy
      mWrite"ANKLETS"
      inc dh
      add edi,4
      jmp procede
  l25:
     call Gotoxy
      mWrite"RINGS"
      inc dh
      add edi,4
      jmp procede
  l26:
     call Gotoxy
      mWrite"SKIRTS"
      inc dh
      add edi,4
      jmp procede
  l27:
     call Gotoxy
      mWrite"CARDIGANS"
      inc dh
      add edi,4
      jmp procede
  l28:
     call Gotoxy
      mWrite"LONG COATS"
      inc dh
      add edi,4
      jmp procede
  l29:
     call Gotoxy
      mWrite"ABAYA"
      inc dh
      add edi,4
      jmp procede
  l30:
     call Gotoxy
      mWrite"HAIRPIN"
      inc dh
      add edi,4
      jmp procede
  l31:
      call Gotoxy
      mWrite"BANGLES "
      inc dh
      add edi,4
      jmp procede
  l32:
      call Gotoxy
      mWrite"LENS"
      inc dh
      add edi,4
      jmp procede
  procede:
      sub ecx,1
jmp label0

label1:
mov dh,12
mov dl,68
mov ecx,LENGTHOF itemQua
label2: 
   cmp ecx,0
   je label3
   mov eax,[ebx]
   cmp eax,0
   je label3
   call Gotoxy
   call WriteDec
   inc dh
   add ebx,4
   sub ecx,1
jmp label2
label3:



   
   

ret
itemAdd ENDP
addAmount PROC
mov esi,OFFSET itemAmount
mov edi,OFFSET itemQua
mov ebx,0
mov dh,12
mov dl,90
mov ecx,LENGTHOF itemAmount
label1: 
    mov eax,[esi]
    cmp ecx,0
    je outt
    cmp eax,0
    je outt
    call Gotoxy
    mov count,dh
    inc count
    mov ebx,[edi]
    mul ebx
    call WriteDec
    mWrite"Rs"
    mov dh,count
    mov dl,90
    sub ecx,1
    add edi,TYPE itemQua
    add esi,TYPE itemAmount
    mov ebx,0
    mov eax,0
jmp label1
outt:
mov dh,dh
mov dl,38
call gotoxy
mWrite"______________________________________________________________"
call registerflush
call discountlabel




ret 
addAmount ENDP
discountlabel PROC
inc count
mov dh,count
mov dl,38
call gotoxy
mWrite"DISCOUNT "
mov ebx,status
cmp ebx,0

je l1
cmp ebx,1
je l2
jmp procede
l1:
  mov dh,count
  mov dl,55
  call gotoxy
  mWrite"             0%"
  mov dh,count
  mov dl,90
  call Gotoxy
  mWrite"0.00Rs"
  jmp outt1
l2:
  mov dh,count
  mov dl,55
  call gotoxy
  mWrite"             10%"
mov dh,count
mov dl,90
call Gotoxy
cld
mov edi,OFFSET itemQua
mov esi,OFFSET itemAmount
mov ecx,LENGTHOF itemAmount
l3:
  lodsd
  mov ebx,[edi]
  mul ebx
  add tt,eax
  add edi,4
loop l3
mov edx,0
mov ecx,tt
mov eax,tt
mov ebx,10
mul ebx
mov ebx,100
div ebx
mov ebx,eax
call WriteDec
mWrite"Rs"
outt:
inc count
mov dh,count
mov dl,38
call Gotoxy
mWrite"______________________________________________________________"
inc count
inc count
mov dh,count
mov dl,38
call Gotoxy
mWrite"YOUR TOTAL AMOUNT IS: TOTAL - DISCOUNT= "
mov eax,tt
mov var1,eax
call WriteDec
mWrite"-"
mov eax,ebx
mov var2,eax
call WriteDec
mov eax,var1
mov ebx,var2
sub eax,ebx
mWrite"= "
call WriteDec
mWrite"Rs"


jmp procede

outt1:
inc count
mov dh,count
mov dl,38
call Gotoxy
mWrite"______________________________________________________________"
inc count
inc count
mov dh,count
mov dl,38
call Gotoxy
mWrite"YOUR TOTAL AMOUNT IS: TOTAL - DISCOUNT= "
cld
mov edi,OFFSET itemQua
mov esi,OFFSET itemAmount
mov ecx,LENGTHOF itemAmount
l4:
  lodsd
  mov ebx,[edi]
  mul ebx
  add tt,eax
  add edi,4
loop l4
mov eax,tt
call WriteDec
mWrite"-"
mWrite"0"
mWrite" =   "
call WriteDec
mWrite"Rs"
procede:


inc count
mov dh,count
mov dl,38
call Gotoxy

mWrite"______________________________________________________________"

inc count
inc count 
inc count
mov dh,count
mov dl,60
call Gotoxy
mov esi,OFFSET userEnd
mov ecx,SIZEOF userEnd
l5:
  mov al,[esi]
  call WriteChar
  mov eax,40
  call Delay
  inc esi
loop l5
inc count
inc count
inc count
mov dl,38
mov dh,count
call Gotoxy
mov edi,OFFSET adminEnd
mov ecx,SIZEOF adminEnd
l6:
  mov al,[edi]
  call WriteChar
  mov eax,40
  call Delay
  inc edi
loop l6
mov dh,100
mov dl,1
call Gotoxy
mWrite" "
ret

discountlabel ENDP
END main

















