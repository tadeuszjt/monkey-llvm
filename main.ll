; ModuleID = '<string>'
source_filename = "<string>"

@main.func.str = global [4 x i8] c"%d\0A\00"

declare i32 @puts(i8*)

declare i32 @printf(i8*, ...)

define void @main() {
entry:
  %0 = alloca i32
  store i32 4, i32* %0
  %1 = alloca void ()*
  store void ()* @main.func, void ()** %1
  %2 = load void ()*, void ()** %1
  call void %2()
  ret void
}

define void @main.func() {
entry:
  %0 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @main.func.str, i32 0, i32 0), i32 2)
  ret void
}

