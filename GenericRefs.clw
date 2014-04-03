  PROGRAM

  MAP
  END

                              ITEMIZE
VariableType:String             EQUATE
VariableType:Byte               EQUATE
VariableType:Short              EQUATE
VariableType:Long               EQUATE
VariableType:Real               EQUATE
VariableType:Date               EQUATE
VariableType:Time               EQUATE
                              END

VariableFactory               CLASS,TYPE
Type                            BYTE
StringRef                       &STRING
ByteRef                         &BYTE
ShortRef                        &SHORT
LongRef                         &LONG
RealRef                         &REAL
DateRef                         &DATE
TimeRef                         &TIME
Construct                       PROCEDURE
Destruct                        PROCEDURE
Allocate                        PROCEDURE(BYTE Type,<LONG Length>),*?
Deallocate                      PROCEDURE
GetRef                          PROCEDURE,*?
                              END

Variable                      VariableFactory

WINDOW                        WINDOW('Caption'),AT(,,260,100),GRAY,SYSTEM
                                BUTTON('Button1'),AT(91,64),USE(?BUTTON1)
                              END
FEQ                           SIGNED
  CODE
  OPEN(Window)
  FEQ = CREATE(0, CREATE:Entry)
  SETPOSITION(FEQ, 10, 10, 80, 10)
  FEQ{PROP:Use} = Variable.Allocate(VariableType:String, 20)
  UNHIDE(FEQ)
  ACCEPT
    IF EVENT() = EVENT:Accepted
      MESSAGE('Value is '& CLIP(CONTENTS(FEQ)))
    END
  END
  
VariableFactory.Construct     PROCEDURE
  CODE
  
VariableFactory.Destruct          PROCEDURE
  CODE
  SELF.Deallocate
  
VariableFactory.Allocate      PROCEDURE(BYTE Type,<LONG Length>)!,*?
NullRef                         &BYTE
  CODE
  SELF.Deallocate
  SELF.Type = Type
  CASE SELF.Type
    ;OF VariableType:String;  SELF.StringRef &= NEW STRING(Length);  RETURN SELF.StringRef
    ;OF VariableType:Byte  ;  SELF.ByteRef   &= NEW BYTE          ;  RETURN SELF.ByteRef
    ;OF VariableType:Short ;  SELF.ShortRef  &= NEW SHORT         ;  RETURN SELF.ShortRef
    ;OF VariableType:Long  ;  SELF.LongRef   &= NEW LONG          ;  RETURN SELF.LongRef
    ;OF VariableType:Real  ;  SELF.RealRef   &= NEW REAL          ;  RETURN SELF.RealRef
    ;OF VariableType:Date  ;  SELF.DateRef   &= NEW DATE          ;  RETURN SELF.DateRef
    ;OF VariableType:Time  ;  SELF.TimeRef   &= NEW TIME          ;  RETURN SELF.TimeRef
    ;ELSE                  ;  ;              ;; ;   ;             ;  RETURN      NullRef
  END

VariableFactory.Deallocate    PROCEDURE
  CODE
  CASE SELF.Type
    ;OF VariableType:String;  DISPOSE(SELF.StringRef)
    ;OF VariableType:Byte  ;  DISPOSE(SELF.ByteRef  )
    ;OF VariableType:Short ;  DISPOSE(SELF.ShortRef )
    ;OF VariableType:Long  ;  DISPOSE(SELF.LongRef  )
    ;OF VariableType:Real  ;  DISPOSE(SELF.RealRef  )
    ;OF VariableType:Date  ;  DISPOSE(SELF.DateRef  )
    ;OF VariableType:Time  ;  DISPOSE(SELF.TimeRef  )
  END
  
VariableFactory.GetRef        PROCEDURE!,*?
NullRef                         &BYTE
  CODE
  CASE SELF.Type
    ;OF VariableType:String;  RETURN SELF.StringRef
    ;OF VariableType:Byte  ;  RETURN SELF.ByteRef
    ;OF VariableType:Short ;  RETURN SELF.ShortRef
    ;OF VariableType:Long  ;  RETURN SELF.LongRef
    ;OF VariableType:Real  ;  RETURN SELF.RealRef
    ;OF VariableType:Date  ;  RETURN SELF.DateRef
    ;OF VariableType:Time  ;  RETURN SELF.TimeRef
    ;ELSE                  ;  RETURN NullRef
  END
