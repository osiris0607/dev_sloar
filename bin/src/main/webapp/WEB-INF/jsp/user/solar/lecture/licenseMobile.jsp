<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

  
<script type='text/javascript'>
	var licenseList = "";
	
	$(document).ready(function() {
		$("#search_text").on("keydown", function(key) {
            //키의 코드가 13번일 경우 (13번은 엔터키)
            if (key.keyCode == 13) {
            	searchList(1);
            }
        });

		// 생태계 분류 Click
	 	$("#selector_category").change(function(){
	 		searchList(1);
		});
		
		searchList(1);
	});

	function searchList(pageNo) {
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/user/api/solar/lecture/license/search/all' />");
		comAjax.setCallback("searchListCB");

		comAjax.addParam("field", $("#selector_category option:selected").val());
		comAjax.addParam("name", $("#search_text").val());
		comAjax.ajax();
	}


	function searchListCB(data) {
		console.log(data);

		// Total은 라이센스 전체 갯수가 아니라 라이센스 종류이다.
		// 즉 에너지기상 / 전기 / 건축 등등의 종류이다.
		// commoncode에서 갯수를 가져온다. 
		var total = data.totalCount;
		var totalLicenseType = data.totalCountByLicenseType;
		
		var body = $("#ul_body");
		body.empty();
		if (total == 0) {
			var str = "조회된 결과가 없습니다.";
			body.append(str);
		} else {
			licenseList = data.result;
			
			var str = "";
			var previousField = "";
			var isFirst = true;
			for (var i=0; i<data.result.length; i++ ) {

				str += "<li>";
				str += "	<a href='javascript:void(0)' class='item-toggle'>" + data.result[i].field_name + "</a>";
				str += "	<div class='accodion-content item-hide'>";

				if (isFirst) {
					previousField = data.result[i].field;
					isFirst = false;
				}
				
				while( true ) {
					if (i == data.result.length) {
						break;
					}
					
					if ( previousField != data.result[i].field) {
						previousField = data.result[i].field;
						i--;
						break;						
					}
					else {
						str += "<p class='licenseItem'><a href='javascript:void(0)' onclick='detailPopup(\"" + data.result[i].license_id + "\")'>" + data.result[i].kor_name + "</a></p>";
						i++;
					}
				}
				str += "	</div>";
				str += "</li>";

			}
			
			body.append(str);
		}
	}

	function detailPopup(id) {
		$.each(licenseList, function(key, value) {
			if (value.license_id == id){
				// Info
				var str = "";
				var body = $("#license_info");
				body.empty();

				str += "<h2>" + value.kor_name + "</h2>";
				str += "<dl>";
				str += " <dt>자격명</dt>";
				str += " 	<dd>" + value.kor_name + "</dd>";
				str += " <dt>영문명</dt>";
				str += " 	<dd>" + value.eng_name + "</dd>";
				str += " <dt>관련부처</dt>";
				str += " 	<dd>" + value.ministry + "</dd>";
				str += " <dt>시행기간</dt>";
				str += " 	<dd>" + value.enforcement_agency + "</dd>";
				str += "</dl>";

				str += "<h3>기본정보</h3>";
				
				str += "<div class='h4_cont'>";
				str += "	<h4>개요</h4>";
				str += "	<p class='note'>" + unescapeHtml(value.summary) + "</p>";
				str += "</div>";
				
				str += "<div class='h4_cont'>";
				str += "	<h4>변천과정</h4>";
				str += "	<p class='note'>" + unescapeHtml(value.change_process) + "</p>";
				str += "</div>";

				str += "<div class='h4_cont'>";
				str += "	<h4>수행직무</h4>";
				str += "	<p class='note'>" + unescapeHtml(value.performance_job) + "</p>";
				str += "</div>";	 

				str += "<div class='h4_cont'>";
				str += "	<h4>진로 및 전망</h4>";
				str += "	<p class='note'>" + unescapeHtml(value.prospect) + "</p>";
				str += "</div>";  

				str += "<p class='guide'>시험일정, 시험정보(수수료, 출제기준) 등 자세한 사항은 자격의 모든것 Q-Net에서 확인하세요.</p>";
				str += "<div class='other'>";     
				str += "<a href='https://www.q-net.or.kr/crf005.do?id=crf00501&gSite=Q&gId=' target='_blank' class='otherLink'>자격의 모든 것, 큐넷 바로가기</a>";           
				str += "</div>";     

				body.append(str);
				
				// each break
				return false;
			}
		});
		
 	      $('.mask').css({'display':'block'});
	      $('.popup').css({'display':'block'});
	}

	
</script>


<div id="wrap">
    <header class="sub">
      <div class="headerSubWrap">
        <button class="prev" onclick="location.href='/user/rdt/solar/mobile/main/mainMobile';"></button>
        <h1>자격증</h1>
      </div>
    </header>

	<section>
	      <div class="innerWrap search">
	        <fieldset>
	          <legend><span>민간자격 검색</span></legend>
	          <div class="inputWrap">
	          	<select id=selector_category title="분야 선택">	
                      	<option value="">분류 선택</option>
                     	<c:forEach items="${commonCode}" var="code">
							<c:if test="${code.master_id == 'M000007'}">
								<option value="${code.detail_id}"><c:out value="${code.name}"></c:out></option>
							</c:if>
						</c:forEach>
                </select>
	            <input type="text" placeholder="자격증을 검색해 보세요." id="search_text">
	            <button type="submit" onclick="searchList(1);">검색</button>
	          </div>
	        </fieldset>
	      </div>
	      <div class="innerWrap">
	        <ul class="accodion" id="ul_body">
	          <li>
	            <a href="javascript:void(0)" class="item-toggle">에너지, 기상</a>
	            <div class="accodion-content item-hide">
	              <p class="licenseItem"><a href="">신재생에너지발전설비기능사(태양광)</a></p>
	              <p class="licenseItem"><a href="">신재생에너지발전설비기사(태양광)</a></p>
	              <p class="licenseItem"><a href="">신재생에너지발전설비산업기사(태양광)</a></p>
	            </div>
	          </li>
	          <li>
	            <a href="javascript:void(0)" class="item-toggle">전기</a>
	            <div class="accodion-content item-hide">
	              <p class="licenseItem"></p>
	            </div>
	          </li>
	          <li>
	            <a href="javascript:void(0)" class="item-toggle">건축</a>
	            <div class="accodion-content item-hide">
	              <p class="licenseItem"></p>
	            </div>
	          </li>
	          <li>
	            <a href="javascript:void(0)" class="item-toggle">전자</a>
	            <div class="accodion-content item-hide">
	              <p class="licenseItem"></p>
	            </div>
	          </li>
	          <li>
	            <a href="javascript:void(0)" class="item-toggle">기계장비설비, 설치</a>
	            <div class="accodion-content item-hide">
	              <p class="licenseItem"></p>
	            </div>
	          </li>
	          <li>
	            <a href="javascript:void(0)" class="item-toggle">기계제작</a>
	            <div class="accodion-content item-hide">
	              <p class="licenseItem"></p>
	            </div>
	          </li>
	          <li>
	            <a href="javascript:void(0)" class="item-toggle">토목</a>
	            <div class="accodion-content item-hide">
	              <p class="licenseItem"></p>
	            </div>
	          </li>
	          <li>
	            <a href="javascript:void(0)" class="item-toggle">생산관리</a>
	            <div class="accodion-content item-hide">
	              <p class="licenseItem"></p>
	            </div>
	          </li>
	          <li>
	            <a href="javascript:void(0)" class="item-toggle">환경</a>
	            <div class="accodion-content item-hide">
	              <p class="licenseItem"></p>
	            </div>
	          </li>
	          <li>
	            <a href="javascript:void(0)" class="item-toggle">화공</a>
	            <div class="accodion-content item-hide">
	              <p class="licenseItem"></p>
	            </div>
	          </li>
	          <li>
	            <a href="javascript:void(0)" class="item-toggle">경영</a>
	            <div class="accodion-content item-hide">
	              <p class="licenseItem"></p>
	            </div>
	          </li>
	        </ul>
	      </div>
    </section>
  </div>
 
<div class="mask"></div>

<div class="popup">
  <div class="wrap">
    <div class="header">
      <h1>교육/자격증 정보</h1>
    </div>

    <div class="contents">
      <div class="lisenceSec" id="license_info">
      </div>
    </div>
    <button class="btn_close"><i class="fa fa-times" aria-hidden="true"></i></button>
  </div>
</div>
<script>
  $(function() {
    $('.open').on('click', function() {
      $('.mask').css({'display':'block'});
      $('.popup').css({'display':'block'});
      $(document.body).css({'position':'fixed','overflow': 'hidden'});
      var popHeight = $('.popup .wrap').height();
      if (popHeight > 800) {
        $('.popup .wrap').css({'height': '776px'}); //padding 값 24px 제외
        $('.popup .wrap .contents').css({'height': '722px'});
      } else {
        $('.popup .wrap').css({'height': popHeight});
      }
    });
    $('.btn_close').on('click', function() {
      $('.mask').css({'display':'none'});
      $('.popup').css({'display':'none'});
      $(document.body).css({'position':'unset','overflow': 'auto'});
    });
  });
</script>
