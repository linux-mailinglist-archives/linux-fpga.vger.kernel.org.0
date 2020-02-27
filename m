Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4877E171DF9
	for <lists+linux-fpga@lfdr.de>; Thu, 27 Feb 2020 15:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389452AbgB0OY1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 27 Feb 2020 09:24:27 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:8892 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731008AbgB0OY0 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 27 Feb 2020 09:24:26 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01RENHH1000905;
        Thu, 27 Feb 2020 09:24:24 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ydtrwkdj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Feb 2020 09:24:24 -0500
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 01REOMb9025697
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 27 Feb 2020 09:24:22 -0500
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 27 Feb 2020 06:24:21 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 27 Feb 2020 06:24:21 -0800
Received: from analog.ad.analog.com ([10.48.65.180])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01REOIt0030211;
        Thu, 27 Feb 2020 09:24:19 -0500
From:   Sergiu Cuciurean <sergiu.cuciurean@analog.com>
To:     <mdf@kernel.org>, <linux-fpga@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Subject: [PATCH] fpga: machxo2-spi: Use new structure for SPI transfer delays
Date:   Thu, 27 Feb 2020 16:24:14 +0200
Message-ID: <20200227142414.16547-1-sergiu.cuciurean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-27_04:2020-02-26,2020-02-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=908
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002270114
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

In a recent change to the SPI subsystem [1], a new `delay` struct was added
to replace the `delay_usecs`. This change replaces the current
`delay_usecs` with `delay` for this driver.

The `spi_transfer_delay_exec()` function [in the SPI framework] makes sure
that both `delay_usecs` & `delay` are used (in this order to preserve
backwards compatibility).

[1] commit bebcfd272df6 ("spi: introduce `delay` field for
`spi_transfer` + spi_transfer_delay_exec()")

Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
---
 drivers/fpga/machxo2-spi.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/machxo2-spi.c b/drivers/fpga/machxo2-spi.c
index 4d8a87641587..b316369156fe 100644
--- a/drivers/fpga/machxo2-spi.c
+++ b/drivers/fpga/machxo2-spi.c
@@ -157,7 +157,8 @@ static int machxo2_cleanup(struct fpga_manager *mgr)
 	spi_message_init(&msg);
 	tx[1].tx_buf = &refresh;
 	tx[1].len = sizeof(refresh);
-	tx[1].delay_usecs = MACHXO2_REFRESH_USEC;
+	tx[1].delay.value = MACHXO2_REFRESH_USEC;
+	tx[1].delay.unit = SPI_DELAY_UNIT_USECS;
 	spi_message_add_tail(&tx[1], &msg);
 	ret = spi_sync(spi, &msg);
 	if (ret)
@@ -208,7 +209,8 @@ static int machxo2_write_init(struct fpga_manager *mgr,
 	spi_message_init(&msg);
 	tx[0].tx_buf = &enable;
 	tx[0].len = sizeof(enable);
-	tx[0].delay_usecs = MACHXO2_LOW_DELAY_USEC;
+	tx[0].delay.value = MACHXO2_LOW_DELAY_USEC;
+	tx[0].delay.unit = SPI_DELAY_UNIT_USECS;
 	spi_message_add_tail(&tx[0], &msg);
 
 	tx[1].tx_buf = &erase;
@@ -269,7 +271,8 @@ static int machxo2_write(struct fpga_manager *mgr, const char *buf,
 		spi_message_init(&msg);
 		tx.tx_buf = payload;
 		tx.len = MACHXO2_BUF_SIZE;
-		tx.delay_usecs = MACHXO2_HIGH_DELAY_USEC;
+		tx.delay.value = MACHXO2_HIGH_DELAY_USEC;
+		tx.delay.unit = SPI_DELAY_UNIT_USECS;
 		spi_message_add_tail(&tx, &msg);
 		ret = spi_sync(spi, &msg);
 		if (ret) {
@@ -317,7 +320,8 @@ static int machxo2_write_complete(struct fpga_manager *mgr,
 		spi_message_init(&msg);
 		tx[1].tx_buf = &refresh;
 		tx[1].len = sizeof(refresh);
-		tx[1].delay_usecs = MACHXO2_REFRESH_USEC;
+		tx[1].delay.value = MACHXO2_REFRESH_USEC;
+		tx[1].delay.unit = SPI_DELAY_UNIT_USECS;
 		spi_message_add_tail(&tx[1], &msg);
 		ret = spi_sync(spi, &msg);
 		if (ret)
-- 
2.17.1

