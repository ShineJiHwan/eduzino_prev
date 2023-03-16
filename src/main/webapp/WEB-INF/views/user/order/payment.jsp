<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <title>결제하기</title>
  <script src="https://js.tosspayments.com/v1/payment"></script>
</head>
<body>
  <script>
    var clientKey = 'test_ck_MGjLJoQ1aVZaJN7QeyA3w6KYe2RN'
    var tossPayments = TossPayments(clientKey) // 클라이언트 키로 초기화하기
  
    tossPayments.requestPayment('카드', { // 결제 수단 파라미터
    	  // 결제 정보 파라미터
    	  amount: 15000,
    	  orderId: 'MNprnPRH0LEGq1CA837vT',
    	  orderName: '토스 티셔츠 외 2건',
    	  customerName: '박토스',
    	  successUrl: 'http://localhost:8080/success',
    	  failUrl: 'http://localhost:8080/fail',
    	})
    	.catch(function (error) {
    	  if (error.code === 'USER_CANCEL') {
    	    // 결제 고객이 결제창을 닫았을 때 에러 처리
    	  } else if (error.code === 'INVALID_CARD_COMPANY') {
    	    // 유효하지 않은 카드 코드에 대한 에러 처리
    	  }
    	})

  
    </script>
</body>
</body>
</html>