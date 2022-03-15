 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
    <head>
        <meta charset="utf-8">
	<meta name="viewport" content="width=1200">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <!--<meta name="viewport" content="width=device-width, height=device-height, initial-scale=1">-->
    <base href="../" />
    <title>일자리 내비게이터 관리자페이지</title>
    <!-- include common vendor stylesheets & fontawesome -->    
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet" /> 
    <link rel="stylesheet" type="text/css" href="/assets/css/bootstrap.css" />    
    <link rel="stylesheet" type="text/css" href="/assets/css/ace.css" />
    <!-- favicon -->
    <link rel="icon" type="image/png" href="/assets/favicon/favicon.png" />    
	<!--추가-->
	<link rel="stylesheet" type="text/css" href="/assets/css/font.css" />
	<link rel="stylesheet" type="text/css" href="/assets/css/style_anchorData.css" />
	<script src="/assets/js/jquery-1.12.3.min.js"></script>
  </head>

  <body>
      <div class="body-container error-bg">
	    <div class="container">
		  <div class="w90 clearfix" style="margin: auto;">
		    <div class="error">
			  <h1 class="error__site-logo">
			    <a href="/" class="error__site-logo-link">
					<span class="is-a11y-hidden">일자리 내비게이터</span>
					<span class="logo_error is-a11y-hidden">일자리 내비게이터<br />관리자페이지</span>
				</a>
			  </h1>
			  <section class="error__region">
			    <h1 class="error__heading">사이트 이용에 불편을 드려 죄송합니다.</h1>
			    <p class="error__paragraph">요청하신 페이지는 삭제되었거나, <br class="is-pc-hidden">변경되었거나, 혹은 주소가 잘못 입력되었습니다.<br>다른 페이지로 이동하시거나 주소를 다시 확인해 주세요.</p>
			    <div class="button-region clearfix">
				  <a href="javascript:history.go(-1);" class=" button--outline-secondary button--large fl gray-btn">이전 페이지로 가기</a>
				  <a href="/" class="button--primary button--large fl blue-btn">메인 페이지로 가기</a>
			    </div>
			  </section>
			</div>
          </div>
        </div>
      </div>    
  </body>
</html>