<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>갤러리 글작성</title>
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
	<link href="https://fonts.googleapis.com/css?family=Montserrat:200,300,400,500,600,700,800&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
 
    <link rel="stylesheet" href="css/animate.css">
    
    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <link rel="stylesheet" href="css/owl.theme.default.min.css">
    <link rel="stylesheet" href="css/magnific-popup.css">


    <link rel="stylesheet" href="css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="css/jquery.timepicker.css">

    <link rel="stylesheet" href="css/flaticon.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Gugi&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Nanum+Brush+Script&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Sunflower:wght@300&display=swap" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
	
	
	
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
   	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet"> 
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
	<script src=" https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
	<script>
	$(window).on("beforeunload",function(){
		$.ajax({
			url:"resolveFiles.galImg"
			
		});
	})
	
	
	</script>
	
	
	<script>
  $(function(){
    $(".nav-search").on("click",function(){
      
      $("#searchBox").attr("style","visibility:visible");

    })
    $("#searchBox").keydown(function(key){
      if (key.keyCode == 13) {
                  location.href="http://www.naver.com";
              }
      

    })
    $("#searchBox").focusout(function(){
      
      $(this).attr("style","visibility:hidden");
      

    })
    
    $(".imgFile").on("click",".delFile",function(){
		$(this).parent().remove();
		
	})
    
    let fileCount = 1;
    $("#addFile").on("click",function(){
    	
		let fileLine = $("<div>");
		
		let inputFile = $("<input>");
		inputFile.attr("type","file");
		inputFile.attr("name","file"+fileCount++);
		inputFile.attr("required","required");
		inputFile.attr("accept","image/jpeg,.png");
		
		
		
		let btnDelete = $("<button>");
		btnDelete.addClass("delFile");
		btnDelete.attr("type","button");
		btnDelete.attr("id","del");
		
		btnDelete.text("-");
		
		
		fileLine.append(inputFile);
		fileLine.append(btnDelete);
		
		$(".imgFile").append(fileLine);
		
		
	});

    
   


  })



</script>

<script>
        $(function(){
        	
        	
            $('#summernote').summernote({
                lang: 'ko-KR',          // default: 'en-US'
                height: 300,            // set editor height
                minHeight: null,        // set minimum height of editor
                maxHeight: null,        // set maximum height of editor
                tabsize: 2,
                callbacks:{
                	onImageUpload:function(files){
                		
                		let editor = this; //SummerNote 인스턴스의 주소를 editor 변수에 저장
                		
                		let file = files[0]; // 업로드해야 하는 파일 인스턴스
                		
                		let form = new FormData();
                		form.append("file",file); // input타입에 name속성이 ""안쪽에 들어간다.
           				    		            		
                		
                		$.ajax({
                			data: form,
                			type: "post",
                			url:"upload.galImg",
                			contentType:false,
                			processData:false,
                		}).done(function(resp){
                			$(editor).summernote('insertImage',"${pageContext.request.contextPath}"+resp);
                			 
                			//editor 인스턴스의 insertImage 기능으로 이미지를 화면에 출력
                			
                			
                		});
                		
                	}
                	
                }
                
            });
            
          

            var a = $("#summernote");
            // 수정버튼 
            $("#edit").on("click",function(){
               a.summernote({ focus: true });
            })
            // 수정 종료 
            var save = function () { 
               var markup = a.summernote('code');
               a.summernote('destroy'); 
           };

        });
 </script>
	<style>
		.container1 {
			max-width: 900px;
			margin: 50px auto;

		}

		.title {
			overflow: hidden;
			padding-bottom: 10px;
			border-bottom: 1px solid #ddd;
		}

		.title .seq {
			float: left;
			display: block;
			padding: 8px 10px;
			font-size: 15px;
		}

		.title h3 {
			float: left;
			width: calc(100% - 100px);
			font-size: 2rem;
		}

		.title h3 input {
			border: none;
		}

		.title h3 input:focus {
			outline: none;
		}

		.title:after {
			display: block;
			clear: both;
			content: '';
		}

		.imgFile {
			overflow: hidden;
			
			border-bottom: 1px solid #ddd;
			
		}
		ul {
			padding: 0;
			margin: 0;
		}

		ul li {
			list-style: none;
			font-size: 13px;
			float: left;
			position: relative;
			margin-right: 11px;
			color: #666;
		}

		ul li:last-child {
			margin-right: 0;
		}

		ul li:after {
			display: block;
			width: 1px;
			height: 12px;
			background-color: #ddd;
			content: '';
			position: absolute;
			top: 50%;
			margin-top: -6px;
			margin-left: -5px;
		}

		.contents {
			padding: 20px;
			min-height: 300px;
		}

		.contents textarea {
			padding: 5px;
			width: 100%;
			height: 100%;
			border-color: #fff;
			resize: none;
			transition: all ease .3s;
		}

		.contents textarea:focus {
			outline: none;
			border-color: #f2f2f2;
		}

		.btn_wrap {
			padding-top: 10px;
			border-top: 1px solid #ddd;
		}
		
		#searchBox{width:200px;transition:all .5s ease; visibility: hidden;}
      #searchBox:focus{width:200px}
  
  
  
  .nav-search:hover{
    cursor: pointer;
  }
  
  
  *{
    font-family: 'Sunflower';
  }
	</style>
</head>

<body>
	

	<div class="container1">
		<h2 class="text-center mb-3">새 글</h2>
		<form action="${pageContext.request.contextPath}/galWrite.gal" method="post" enctype="multipart/form-data">
			<div class="contents_box">
				<div class="title">
					<h3>
						<input type="text" name="title"placeholder="제목" style="width:800px;" required>
					</h3>
				</div>
				<div class="imgFile">
						<input type="file" name="file" accept="image/jpeg,.png" required>
						<button id=addFile type=button class="btn btn-outline-success btn-sm">+</button>
						(업로드 파일은 이미지파일만 가능합니다.)
				</div>
				<div class="contents">
					<textarea name="contents" cols="60" rows="10"
						placeholder="내용을 입력하세요." required></textarea>
				</div>
				<div class="btn_wrap text-right">
					<input type="submit" class="btn btn-primary" value="등록하기">
					<a href="javascript:history.back()" class="btn btn-secondary">목록으로</a>
				</div>
			</div>
		</form>

	</div>

</body>

</html>