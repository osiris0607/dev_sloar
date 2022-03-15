 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
  <div id="wrap">
    <div class="main_top_info">
	<img src="/assets/img/main_img.png" alt="태양산업 일자리 내비게이터 메인 소개 이미지" />
	<div class="main_top_info_txt">
	  <p><span class="blue_font">태양광산업</span> <br /><span class="fw_5">일자리 내비게이터</span></p>
	  <p class="main_top_info_txt_s">태양광산업 분야로의 취업 및 경력 개발을 위해<br />태양광산업의 종합적인 일자리 정보를 제공하는 플랫폼</p>
	</div>
  </div>

    <script>
      var tabThumbs = new Swiper('.swiper-thumbs', {
        // cssMode:true,
        spaceBetween: 0,
        slidesPerView: '5',
        freeMode: true,
        resistance:true
      });
      var tabContent = new Swiper('.swiper-content', {
        spaceBetween: 0,
        autoHeight: true,
        loop: false,
        effect: 'fade',
        
        hashNavigation: {
          watchState: true,
        },
        // pagination: {
        //   el: '.swiper-pagination',
        //   clickable: true,
        // },
        navigation: {
          nextEl: '.swiper-button-next',
          prevEl: '.swiper-button-prev',
        },
        thumbs: {
          swiper: tabThumbs,
        },
        swiping: true
      });
    </script>

    <section>
      <div class="intro">
        <h2>내비게이터 소개</h2>
        <p>
          태양광산업 일자리 내비게이터는 국내 태양광산업 실정과 일자리 구조에 최적화된<br />
          ‘태양광산업 직무역량 모델’을 구축합니다.
        </p>
        <ul class="introItem">
          <li>
            <div class="itemContent">
              <h3>목적</h3>
              <p>
                태양광 산업 관련 직업 선택 및<br />
                경로 설계를 위한 종합적인 일자리 정보 제공
              </p>
            </div>
            <img src="/assets/img/intro_object.png" alt="">
          </li>
          <li>
            <div class="itemContent">
              <h3>대상</h3>
              <p>태양광 산업 분야에 종사하고자 하는 고등
                학생, 대학생, 취업준비생, 직장인 등
              </p>
            </div>
            <img src="/assets/img/intro_target.png" alt="">
          </li>
          <li>
            <div class="itemContent">
              <h3>내용</h3>
              <p>태양광 산업 일자리 내비게이터, 태양광산업 직업사전, 태양광산업 일자리 지도 제공</p>
            </div>
            <img src="/assets/img/intro_content.png" alt="">
          </li>
          <li>
            <div class="itemContent">
              <h3>내비게이터 정보</h3>
              <p>
                태양광산업 생태계별, 직종별 일자리 현황<br />
                태양광산업 일자리별 필요학력/전공, 자격증, 직무역량, 연봉 등의 정보 제공<br />
                태양광산업 일자리별 관련 대표기업 정보 제공<br />
                지역별 태양광 일자리 및 기업 분포 현황
              </p>
            </div>
          </li>
        </ul>
      </div>
    </section>

    <section class="capabilityBg">
      <div class="capability">
        <h2>직무 역량 모델</h2>
        <p>
          태양광산업 일자리 내비게이터는 국내 태양광산업 실정과 일자리 구조에 최적화된<br />
          ‘태양광산업 직무역량 모델’을 구축합니다.
        </p>
        
        
        <div class="tabs">
	        <ul class="tablist home_main_tab" data-hx="h3">
	          <li class="tablist__item">
	            <a href="#tab01" class="tablist__link tabs__standard__a">개인역량</a>
	          </li>
	          <li class="tablist__item">
	            <a href="#tab02" class="tablist__link ">학업역량</a>
	          </li>
	          <li class="tablist__item">
	            <a href="#tab03" class="tablist__link">기초업무역량</a>
	          </li>
	          <li class="tablist__item">
	            <a href="#tab04" class="tablist__link">산업역량</a>
	          </li>
	          <li class="tablist__item">
	            <a href="#tab05" class="tablist__link">자격역량</a>
	          </li>
	          <li class="tablist__item">
	            <a href="#tab06" class="tablist__link">관리역량</a>
	          </li>
	        </ul>
			<script>
			  $(function () {
			    var anchor = $('.diagram > li > a'),
			        panel = $('.js-tabcontent');
			
			    anchor.on('click', function(e) {
			      e.preventDefault();
			      $target = $(this).attr('href');
			      
			      $('.tablist > li > a').attr('aria-selected','false');
			
			      panel.attr('aria-hidden','true');
			      $($target + '.js-tabcontent').attr('aria-hidden','false');
			    });
			
			    $('a[href="#tab06"]').click (function () {
			      $('.tablist > li:nth-child(6) > a').attr('aria-selected','true');
			    });
			    $('a[href="#tab05"]').click (function () {
			      $('.tablist > li:nth-child(5) > a').attr('aria-selected','true');
			    });
			    $('a[href="#tab04"]').click (function () {
			      $('.tablist > li:nth-child(4) > a').attr('aria-selected','true');
			    });
			    $('a[href="#tab03"]').click (function () {
			      $('.tablist > li:nth-child(3) > a').attr('aria-selected','true');
			    });
			    $('a[href="#tab02"]').click (function () {
			      $('.tablist > li:nth-child(2) > a').attr('aria-selected','true');
			    });
			    $('a[href="#tab01"]').click (function () {
			      $('.tablist > li:nth-child(1) > a').attr('aria-selected','true');
			    });
			  });
			</script>
        
          <div id="tab01" class="js-tabcontent">
            <ul class="tier tier01">
			   <li>
                <ul class="diagram">
                  <li>
                    <a href="#tab06">
                      <span class="tit">tier.6</span>
                      <img src="/assets/img/tier_img_06.png" alt="관리역량">
                    </a>
                  </li>
                  <li>
                    <a href="#tab05">
                      <span class="tit">tier.5</span>
                      <img src="/assets/img/tier_img_05.png" alt="관리역량">
                    </a>
                  </li>
                  <li>
                    <a href="#tab04">
                      <span class="tit">tier.4</span>
                      <img src="/assets/img/tier_img_04.png" alt="관리역량">
                    </a>
                  </li>
                  <li>
                    <a href="#tab03">
                      <span class="tit">tier.3</span>
                      <img src="/assets/img/tier_img_03.png" alt="관리역량">
                    </a>
                  </li>
                  <li>
                    <a href="#tab02">
                      <span class="tit">tier.2</span>
                      <img src="/assets/img/tier_img_02.png" alt="관리역량">
                    </a>
                  </li>
                  <li class="on">
                    <a href="#tab01">
                      <span class="tit">tier.1</span>
                      <img src="/assets/img/tier_img_01.png" alt="관리역량">
                    </a>
                  </li>
                </ul>
              </li>
              <li>
    			<em class="title_model">TIER.1 &nbsp;&nbsp;개인 역량</em>
                <ul class="tierList">
                  <li class="on">
                    <a href="#hasLayer" class="useFocus">윤리의식</a>
                    <div class="pop">
                      <em class="caret"></em>
                      도덕과 양심에 따라 행동하며 개인적인 이익보다는 조직의 가치와 기준을 수용하는 태도
                    </div>
                  </li>
                  <li>
                    <a href="#hasLayer" class="useFocus">주인의식</a>
                    <div class="pop">
                      <em class="caret"></em>
                     경영자의 입장에서 경영환경을 이해하고 전략적 방향을 판단하거나 수용하며, 자발적으로 업무상의 문제점을 발견/분석하여 해결방안을 적극 제시하고 실행하는 능력
                    </div>
                  </li>
                  <li>
                    <a href="#hasLayer" class="useFocus">성실성</a>
                    <div class="pop">
                      <em class="caret"></em>
                      모든 일에 성실·정직하여 남에게 신뢰감을 주고, 꼼꼼하며 정확하게 일을 수행하는 태도
                    </div>
                  </li>
                  <li>
                    <a href="#hasLayer" class="useFocus">진취성</a>
                    <div class="pop">
                      <em class="caret"></em>
                     적극적 사고와 자신감으로 새로운 기회를 찾아내어 주도적으로 일을 추진하고, 더 높은 성과목표를 세워 열정적으로 추진하려는 태도
                    </div>
                  </li>
                  <li>
                    <a href="#hasLayer" class="useFocus">정의성</a>
                    <div class="pop">
                      <em class="caret"></em>
                      사물의 현상과 본질을 이해하고 발상의 전환 및 적용의 변환을 통해 다양한 아이디어를 제시하여 새로운 가치를 창출하는 능력
                    </div>
                  </li>
                  <li>
                    <a href="#hasLayer" class="useFocus">정확성</a>
                    <div class="pop">
                      <em class="caret"></em>
                      업무 수행 시 업무 지침이나 업무 지시 등의 내용에 따라 세부적인 부분까지 꼼꼼하고 정확하게 확인하고 수행하고 관리하는 능력
                    </div>
                  </li>
                  <li>
                    <a href="#hasLayer" class="useFocus">의사소통</a>
                    <div class="pop">
                      <em class="caret"></em>
                      상대방을 경청하여 정확히 이해하고, 자신의 의사를 명확히 전달 및 이해시키며, 필요 시 상대방의 협조를 이끌어 내는 능력
                    </div>
                  </li>
                  <li>
                    <a href="#hasLayer" class="useFocus">자기개발</a>
                    <div class="pop">
                      <em class="caret"></em>
                      스스로 꾸준히 학습하고 개발하여 보다 나은 성과와 발전을 이루려는 태도
                    </div>
                  </li>
                </ul>
              </li>
            </ul>
          </div>
          <div id="tab02" class="js-tabcontent">
            <ul class="tier tier02">
              <li>
                <ul class="diagram">
                  <li>
                    <a href="#tab06">
                      <span class="tit">tier.6</span>
                      <img src="/assets/img/tier_img_06.png" alt="관리역량">
                    </a>
                  </li>
                  <li>
                    <a href="#tab05">
                      <span class="tit">tier.5</span>
                      <img src="/assets/img/tier_img_05.png" alt="관리역량">
                    </a>
                  </li>
                  <li>
                    <a href="#tab04">
                      <span class="tit">tier.4</span>
                      <img src="/assets/img/tier_img_04.png" alt="관리역량">
                    </a>
                  </li>
                  <li>
                    <a href="#tab03">
                      <span class="tit">tier.3</span>
                      <img src="/assets/img/tier_img_03.png" alt="관리역량">
                    </a>
                  </li>
                  <li class="on">
                    <a href="#tab02">
                      <span class="tit">tier.2</span>
                      <img src="/assets/img/tier_img_02.png" alt="관리역량">
                    </a>
                  </li>
                  <li>
                    <a href="#tab01">
                      <span class="tit">tier.1</span>
                      <img src="/assets/img/tier_img_01.png" alt="관리역량">
                    </a>
                  </li>
                </ul>
              </li>
              <li>
              <em class="title_model">TIER.2 &nbsp;&nbsp;학업역량</em>
                <ul class="tierList">
                  <li class="on">
                    <a href="#hasLayer" class="useFocus">듣기·읽기·쓰기·말하기</a>
                    <div class="pop">
                      <em class="caret"></em>
                      다른 사람들이 말하는 것을 집중해서 듣고 상대방이 말하려는 요점을 이해하거나 적절한 질문을 할 수 있는 능력
                    </div>
                  </li>
                  <li>
                    <a href="#hasLayer" class="useFocus">컴퓨터 활용</a>
                    <div class="pop">
                      <em class="caret"></em>
                      컴퓨터, IT를 활용하여 일을 효율적으로 처리하는 능력
                    </div>
                  </li>
                  <li>
                    <a href="#hasLayer" class="useFocus">영어</a>
                    <div class="pop">
                      <em class="caret"></em>
                      영어를 읽고, 쓰고, 듣고 말하는데 필요한 지식
                    </div>
                  </li>    
                  <li>
                    <a href="#hasLayer" class="useFocus">수학</a>
                    <div class="pop">
                      <em class="caret"></em>
                      연산, 대수학, 통계, 기하학의 계산 및 응용에 관한 지식
                    </div>
                  </li>    
                  <li>
                    <a href="#hasLayer" class="useFocus">공학</a>
                    <div class="pop">
                      <em class="caret"></em>
                      다양한 물건을 만들고 설계하거나 서비스를 제공하기 위해 필요한 공학적인 원리, 기법, 장비 등을 실제로 적용시키는 지식
                    </div>
                  </li>    
                  <li>
                    <a href="#hasLayer" class="useFocus">물리</a>
                    <div class="pop">
                      <em class="caret"></em>
                      공기, 물, 빛, 열, 전기이론 및 자연현상에 관한 지식
                    </div>
                  </li>    
                  <li>
                    <a href="#hasLayer" class="useFocus">건축/설계</a>
                    <div class="pop">
                      <em class="caret"></em>
                      집, 빌딩, 혹은 도로를 만들고 수리하기 위해 필요한 지식
                    </div>
                  </li>    
                  <li>
                    <a href="#hasLayer" class="useFocus">경제/경영/회계</a>
                    <div class="pop">
                      <em class="caret"></em>
                      돈의 흐름, 은행업무, 그리고 재무자료의 보고와 분석과 같은 경제 및 회계원리에 관한 지식
                    </div>
                  </li>    
                  <li>
                    <a href="#hasLayer" class="useFocus">법/행정</a>
                    <div class="pop">
                      <em class="caret"></em>
                      법의 기초 원리와 실정법의 해석에 관한 이론과 실제, 또는 정책, 인사, 재무, 조직, 지방행정 등 행정학에 대한 전반적인 지식
                    </div>
                  </li>                                    
                </ul>
              </li>
            </ul>
          </div>
          <div id="tab03" class="js-tabcontent">
            <ul class="tier tier03">
              <li>
                <ul class="diagram">
                  <li>
                    <a href="#tab06">
                      <span class="tit">tier.6</span>
                      <img src="/assets/img/tier_img_06.png" alt="관리역량">
                    </a>
                  </li>
                  <li>
                    <a href="#tab05">
                      <span class="tit">tier.5</span>
                      <img src="/assets/img/tier_img_05.png" alt="관리역량">
                    </a>
                  </li>
                  <li>
                    <a href="#tab04">
                      <span class="tit">tier.4</span>
                      <img src="/assets/img/tier_img_04.png" alt="관리역량">
                    </a>
                  </li>
                  <li class="on">
                    <a href="#tab03">
                      <span class="tit">tier.3</span>
                      <img src="/assets/img/tier_img_03.png" alt="관리역량">
                    </a>
                  </li>
                  <li>
                    <a href="#tab02">
                      <span class="tit">tier.2</span>
                      <img src="/assets/img/tier_img_02.png" alt="관리역량">
                    </a>
                  </li>
                  <li>
                    <a href="#tab01">
                      <span class="tit">tier.1</span>
                      <img src="/assets/img/tier_img_01.png" alt="관리역량">
                    </a>
                  </li>
                </ul>
              </li>
              <li>
              <em class="title_model">TIER.3 &nbsp;&nbsp;기초업무역량</em>
                <ul class="tierList">
                  <li class="on">
                    <a href="#hasLayer" class="useFocus">정보수집 및 활용 능력</a>
                    <div class="pop">
                      <em class="caret"></em>
                      필요한 정보를 지속적으로 수집하고 가공 및 관리하여 업무에 활용할 수 있는 능력
                    </div>
                  </li>
                  <li>
                    <a href="#hasLayer" class="useFocus">프레젠테이션 능력</a>
                    <div class="pop">
                      <em class="caret"></em>
                      자신의 의견이나 제안을 효과적으로 발표하고 상대방의 동의와 행동을 이끌어내는 능력
                    </div>
                  </li>
                  <li>
                    <a href="#hasLayer" class="useFocus">분석력</a>
                    <div class="pop">
                      <em class="caret"></em>
                      문제나 상황의 여러 부분을 논리적으로 생각하고, 체계적으로 업무를 처리하는 능력
                    </div>
                  </li>
                  <li>
                    <a href="#hasLayer" class="useFocus">설득력</a>
                    <div class="pop">
                      <em class="caret"></em>
                      자신의 입장과 견해를 논리적이고 설득력있는 방식으로 제시하여 타인들로부터 필요한 지지와 지원을 끌어낼 수 있으며, 효과적인 지지를 얻어내는데 필요한 정보와 데이터를 효율적으로 이용할 수 있는 능력
                    </div>
                  </li>
                  <li>
                    <a href="#hasLayer" class="useFocus">리더십</a>
                    <div class="pop">
                      <em class="caret"></em>
                      공동의 목표달성을 위해 구성원들을 동기부여시키고, 지도 및 지원하며 이끌어가는 능력
                    </div>
                  </li>
                  <li>
                    <a href="#hasLayer" class="useFocus">팀워크</a>
                    <div class="pop">
                      <em class="caret"></em>
                      팀의 일원임을 인식하고 팀 목표달성을 위해 동료들과 적극 협력하고 함께 일하려는 태도
                    </div>
                  </li>
                  <li>
                    <a href="#hasLayer" class="useFocus">조직 적응 능력</a>
                    <div class="pop">
                      <em class="caret"></em>
                      자신이 속한 조직 및 구성원들과 융화할 수 있는 능력과 주변의 급격한 환경 변화에도 적극 수용하는 융통성
                    </div>
                  </li>
                  <li>
                    <a href="#hasLayer" class="useFocus">의사 결정 능력</a>
                    <div class="pop">
                      <em class="caret"></em>
                      문제를 판단하고 쓸 수 있는 자원을 선택하여 올바른 결정을 적시에 내릴 수 있는 능력
                    </div>
                  </li>
                  <li>
                    <a href="#hasLayer" class="useFocus">응급상황 및 갈등 해결 능력</a>
                    <div class="pop">
                      <em class="caret"></em>
                      예측하지 못한 사고에 대해 합리적으로 대처하거나, 갈등 상황의 본질을 정확히 파악하여 최선의 해결책을 신속히 찾아내어 실행할 수 있는 능력
                    </div>
                  </li>
                  <li>
                    <a href="#hasLayer" class="useFocus">업무 계획 능력</a>
                    <div class="pop">
                      <em class="caret"></em>
                      업무 수행 전 활동계획을 세우고 필요한 인적·물적자원을 구성할 수 있는 능력
                    </div>
                  </li>
                  <li>
                    <a href="#hasLayer" class="useFocus">업무 이해 능력</a>
                    <div class="pop">
                      <em class="caret"></em>
                      회사와 업계의 특성, 성공요소를 파악하고 자신의 역량과 연계하여 이해하는 능력
                    </div>
                  </li>
                  <li>
                    <a href="#hasLayer" class="useFocus">업무 해결 능력</a>
                    <div class="pop">
                      <em class="caret"></em>
                      진행상황에 따라 목표달성을 위한 접근방식을 융통성있게 변경하여 업무를 해결할 수 있는 능력
                    </div>
                  </li>
                  <li>
                    <a href="#hasLayer" class="useFocus">업무 관리 능력</a>
                    <div class="pop">
                      <em class="caret"></em>
                      시간과 자원을 효율적으로 관리하며, 우선 순위에 따라 다양한 업무 요구사항을 효율적으로 처리하는 능력
                    </div>
                  </li>
                </ul>
              </li>
            </ul>
          </div>
          <div id="tab04" class="js-tabcontent">
			<ul class="tier tier04">
              <li>
                <ul class="diagram">
                  <li>
                    <a href="#tab06">
                      <span class="tit">tier.6</span>
                      <img src="/assets/img/tier_img_06.png" alt="관리역량">
                    </a>
                  </li>
                  <li>
                    <a href="#tab05">
                      <span class="tit">tier.5</span>
                      <img src="/assets/img/tier_img_05.png" alt="관리역량">
                    </a>
                  </li>
                  <li class="on">
                    <a href="#tab04">
                      <span class="tit">tier.4</span>
                      <img src="/assets/img/tier_img_04.png" alt="관리역량">
                    </a>
                  </li>
                  <li>
                    <a href="#tab03">
                      <span class="tit">tier.3</span>
                      <img src="/assets/img/tier_img_03.png" alt="관리역량">
                    </a>
                  </li>
                  <li>
                    <a href="#tab02">
                      <span class="tit">tier.2</span>
                      <img src="/assets/img/tier_img_02.png" alt="관리역량">
                    </a>
                  </li>
                  <li>
                    <a href="#tab01">
                      <span class="tit">tier.1</span>
                      <img src="/assets/img/tier_img_01.png" alt="관리역량">
                    </a>
                  </li>
                </ul>
              </li>
              <li>
              <em class="title_model">TIER.4 &nbsp;&nbsp;산업역량</em>
                <ul class="tierList">
                  <li class="on">
                    <a href="#hasLayer" class="useFocus">에너지 소재/부품/장비</a>
                    <div class="pop">
                      <em class="caret"></em>
                      에너지 생산의 원천이 되는 소재 및 부품에 대한 특성 및 공정과 이를 생산하기 위해 필요한 관련 장비에 대한 기본적인 이해
                    </div>
                  </li>
                  <li>
                    <a href="#hasLayer" class="useFocus">에너지 발전</a>
                    <div class="pop">
                      <em class="caret"></em>
                      에너지 생산에 대한 기본 지식부터 에너지 발전시스템 및 관련 설비의 설계, 설치, 운영 및 유지관리에 대한 대한 전반적인 이해
                    </div>
                  </li>
                  <li>
                    <a href="#hasLayer" class="useFocus">에너지 효율</a>
                    <div class="pop">
                      <em class="caret"></em>
                      화석연료에 대한 의존도 절감과 에너지 절약 및 에너지 효율 제고에 대한 기본적인 이해
                    </div>
                  </li>    
                  <li>
                    <a href="#hasLayer" class="useFocus">신재생에너지</a>
                    <div class="pop">
                      <em class="caret"></em>
                      태양광, 풍력 등 신재생에너지에 대한 기본 개념과 에너지가 생산되는 원리에 대한 이해
                    </div>
                  </li>    
                  <li>
                    <a href="#hasLayer" class="useFocus">법/제도/정책</a>
                    <div class="pop">
                      <em class="caret"></em>
                      에너지산업에 영향을 미치는 법/제도/정책, 규정 등에 대해 인지하고 준수하는 능력
                    </div>
                  </li>    
                  <li>
                    <a href="#hasLayer" class="useFocus">안전/보안</a>
                    <div class="pop">
                      <em class="caret"></em>
                      안전하고 건강한 에너지산업의 작업환경을 보장하는데 필요한 절차를 준수 및 관리하고, 도출된 데이터에 대한 보안의식을 보유
                    </div>
                  </li>    
                  <li>
                    <a href="#hasLayer" class="useFocus">회계/금융/경제</a>
                    <div class="pop">
                      <em class="caret"></em>
                      에너지산업과 관련된 회계, 금융, 경제에 대한 기본 이해
                    </div>
                  </li>    
                  <li>
                    <a href="#hasLayer" class="useFocus">교육/마케팅/컨설팅</a>
                    <div class="pop">
                      <em class="caret"></em>
                      에너지산업의 인력 교육 및 발전사업 관련 컨설팅, 영업/마케팅에 대한 이해
                    </div>
                  </li>            
                </ul>
              </li>
            </ul>
          </div>
          <div id="tab05" class="js-tabcontent">
			<ul class="tier tier05">
              <li>
                <ul class="diagram">
                  <li>
                    <a href="#tab06">
                      <span class="tit">tier.6</span>
                      <img src="/assets/img/tier_img_06.png" alt="관리역량">
                    </a>
                  </li>
                  <li class="on">
                    <a href="#tab05">
                      <span class="tit">tier.5</span>
                      <img src="/assets/img/tier_img_05.png" alt="관리역량">
                    </a>
                  </li>
                  <li>
                    <a href="#tab04">
                      <span class="tit">tier.4</span>
                      <img src="/assets/img/tier_img_04.png" alt="관리역량">
                    </a>
                  </li>
                  <li>
                    <a href="#tab03">
                      <span class="tit">tier.3</span>
                      <img src="/assets/img/tier_img_03.png" alt="관리역량">
                    </a>
                  </li>
                  <li>
                    <a href="#tab02">
                      <span class="tit">tier.2</span>
                      <img src="/assets/img/tier_img_02.png" alt="관리역량">
                    </a>
                  </li>
                  <li>
                    <a href="#tab01">
                      <span class="tit">tier.1</span>
                      <img src="/assets/img/tier_img_01.png" alt="관리역량">
                    </a>
                  </li>
                </ul>
              </li>
              <li>
              <em class="title_model">TIER.5 &nbsp;&nbsp;자격역량</em>
                <ul class="tierList">
                  <li class="on">
                    <a href="#hasLayer" class="useFocus">에너지/환경</a>
                    <div class="pop">
                      <em class="caret"></em>
                      에너지, 환경(폐기물)과 관련된 자격
                    </div>
                  </li>
                  <li>
                    <a href="#hasLayer" class="useFocus">전기/전자</a>
                    <div class="pop">
                      <em class="caret"></em>
                      전기, 전자와 관련된 자격
                    </div>
                  </li>
                  <li>
                    <a href="#hasLayer" class="useFocus">건축/토목</a>
                    <div class="pop">
                      <em class="caret"></em>
                      건축, 토목과 관련된 자격
                    </div>
                  </li>    
                  <li>
                    <a href="#hasLayer" class="useFocus">측정/측량</a>
                    <div class="pop">
                      <em class="caret"></em>
                      정밀 측정, 공간 측량 등과 관련된 자격
                    </div>
                  </li>    
                  <li>
                    <a href="#hasLayer" class="useFocus">기계/장비/설비</a>
                    <div class="pop">
                      <em class="caret"></em>
                      기계, 장비, 설비의 설계·제작·정비 등과 관련된 자격
                    </div>
                  </li>    
                  <li>
                    <a href="#hasLayer" class="useFocus">IT/정보</a>
                    <div class="pop">
                      <em class="caret"></em>
                      응용소프트웨어 및 정보의 처리·관리와 관련된 자격
                    </div>
                  </li>    
                  <li>
                    <a href="#hasLayer" class="useFocus">생산관리</a>
                    <div class="pop">
                      <em class="caret"></em>
                      소재·부품·장비 및 제품의 품질과 관련된 자격
                    </div>
                  </li>    
                  <li>
                    <a href="#hasLayer" class="useFocus">안전관리</a>
                    <div class="pop">
                      <em class="caret"></em>
                      산업 안전관리와 관련된 자격
                    </div>
                  </li>    
                  <li>
                    <a href="#hasLayer" class="useFocus">법률/금융</a>
                    <div class="pop">
                      <em class="caret"></em>
                      법률, 금융과 관련된 자격
                    </div>
                  </li>                    
                </ul>
              </li>
            </ul>
          </div>
          <div id="tab06" class="js-tabcontent">
			<ul class="tier tier06">
              <li>
                <ul class="diagram">
                  <li class="on">
                    <a href="#tab06">
                      <span class="tit">tier.6</span>
                      <img src="/assets/img/tier_img_06.png" alt="관리역량">
                    </a>
                  </li>
                  <li>
                    <a href="#tab05">
                      <span class="tit">tier.5</span>
                      <img src="/assets/img/tier_img_05.png" alt="관리역량">
                    </a>
                  </li>
                  <li>
                    <a href="#tab04">
                      <span class="tit">tier.4</span>
                      <img src="/assets/img/tier_img_04.png" alt="관리역량">
                    </a>
                  </li>
                  <li>
                    <a href="#tab03">
                      <span class="tit">tier.3</span>
                      <img src="/assets/img/tier_img_03.png" alt="관리역량">
                    </a>
                  </li>
                  <li>
                    <a href="#tab02">
                      <span class="tit">tier.2</span>
                      <img src="/assets/img/tier_img_02.png" alt="관리역량">
                    </a>
                  </li>
                  <li>
                    <a href="#tab01">
                      <span class="tit">tier.1</span>
                      <img src="/assets/img/tier_img_01.png" alt="관리역량">
                    </a>
                  </li>
                </ul>
              </li>
              <li>
              <em class="title_model">TIER.6 &nbsp;&nbsp;관리역량</em>
                <ul class="tierList">
                  <li class="on">
                    <a href="#hasLayer" class="useFocus">조직관리</a>
                    <div class="pop">
                      <em class="caret"></em>
                      법·제도·정책적 변화 등 급변화하는 환경속에서 조직의 비전을 연계한 업무 방향을 제시하는 능력
                    </div>
                  </li>
                  <li>
                    <a href="#hasLayer" class="useFocus">인력관리</a>
                    <div class="pop">
                      <em class="caret"></em>
                      조직 구성원/고객과 상호신뢰를 바탕으로 우호적인 협력관계를 구축하고 유지함으로써 서로의 발전을 도모하도록 유도하는 능력
                    </div>
                  </li>
                  <li>
                    <a href="#hasLayer" class="useFocus">고객관리</a>
                    <div class="pop">
                      <em class="caret"></em>
                      대외적인 문제와 관련하여 조직의 입장을 대변하고, 이해관계자들과의 네트워킹 활동을 이끄는 능력
                    </div>
                  </li>    
                  <li>
                    <a href="#hasLayer" class="useFocus">자원관리</a>
                    <div class="pop">
                      <em class="caret"></em>
                      업무 수행에 필요한 시간자원, 자본자원, 물적자원, 인적자원이 얼마나 필요한지를 전반적으로 확인하고, 이용가능한 각종 자원들을 최대한 수집하여 실제 업무에 어떻게 활용할 것인지를 계획하고 할당하는 능력 
                    </div>
                  </li>                 
                </ul>
              </li>
            </ul>
          </div>
          <script>
            $(function () {
              $('.useFocus').focus(function () {
                $(this).parent('li').addClass('on');                    
              });
              $('.useFocus').focusout(function () {
                $(this).parent('li').removeClass('on');                    
              });
            });

            $(function () {
              $('.useFocus').on('click', function () {
                if($('.pop').css('display') == 'block') {
                  $('.tierList li').removeClass('on');
                }
                $(this).parent('li').addClass('on');                    
              });
            });
          </script>
        </div>
      </div>
    </section>

    <section class="footer_banner">
	  <h2 class="hidden">슬라이드 이미지</h2>
	  <div class="swiper-button-prev swiper-button-custom"></div>
      <div class="swiper-container partner">
         
        <div class="swiper-wrapper">
          <div class="swiper-slide">
            <a href=""><img src="/assets/img/partner/simpan.png" alt=""></a>
          </div>
          <div class="swiper-slide">
            <a href=""><img src="/assets/img/partner/ris_pec.png" alt=""></a>
          </div>
          <div class="swiper-slide">
            <a href=""><img src="/assets/img/partner/korea_gov.png" alt=""></a>
          </div>
          <div class="swiper-slide">
            <a href=""><img src="/assets/img/partner/biz_info.png" alt=""></a>
          </div>
          <div class="swiper-slide">
            <a href=""><img src="/assets/img/partner/simpan.png" alt=""></a>
          </div>
          <div class="swiper-slide">
            <a href=""><img src="/assets/img/partner/ris_pec.png" alt=""></a>
          </div>
          <div class="swiper-slide">
            <a href=""><img src="/assets/img/partner/korea_gov.png" alt=""></a>
          </div>
          <div class="swiper-slide">
            <a href=""><img src="/assets/img/partner/biz_info.png" alt=""></a>
          </div>
          <div class="swiper-slide">
            <a href=""><img src="/assets/img/partner/simpan.png" alt=""></a>
          </div>
          <div class="swiper-slide">
            <a href=""><img src="/assets/img/partner/ris_pec.png" alt=""></a>
          </div>
          <div class="swiper-slide">
            <a href=""><img src="/assets/img/partner/korea_gov.png" alt=""></a>
          </div>
          <div class="swiper-slide">
            <a href=""><img src="/assets/img/partner/biz_info.png" alt=""></a>
          </div>


		  
        </div>

        
      </div>
	  <div class="swiper-button-next swiper-button-custom"></div>
      <script>
        var swiper = new Swiper('.partner', {
          spaceBetween: 0,
          slidesPerView: 'auto',
          freeMode: true,
          navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
          }
        });
      </script>
    </section>
   </div>
