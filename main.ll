; ModuleID = '<string>'
source_filename = "<string>"

@main.str = global [4 x i8] c"%d\0A\00"

declare i32 @puts(i8*)

declare i32 @printf(i8*, ...)

define void @main() {
entry:
  %0 = alloca i32
  store i32 4, i32* %0
  %1 = load i32, i32* %0
  %2 = alloca i32
  store i32 %1, i32* %2
  %3 = load i32, i32* %0
  %4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @main.str, i32 0, i32 0), i32 %3)
  ret void
}

