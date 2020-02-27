Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FADB1716D2
	for <lists+linux-fpga@lfdr.de>; Thu, 27 Feb 2020 13:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbgB0MJp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 27 Feb 2020 07:09:45 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:55500 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728856AbgB0MJo (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 27 Feb 2020 07:09:44 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01RC7DvE020906;
        Thu, 27 Feb 2020 07:09:43 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ydtrwk1cj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Feb 2020 07:09:43 -0500
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 01RC9gGu002110
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 27 Feb 2020 07:09:42 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 27 Feb 2020 07:09:41 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 27 Feb 2020 07:09:41 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 27 Feb 2020 07:09:41 -0500
Received: from analog.ad.analog.com ([10.48.65.180])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01RC9cSB030193;
        Thu, 27 Feb 2020 07:09:39 -0500
From:   Sergiu Cuciurean <sergiu.cuciurean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>
CC:     <mdf@kernel.org>, Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Subject: [PATCH] fpga: ice40-spi: Use new structure for SPI transfer delays
Date:   Thu, 27 Feb 2020 14:09:32 +0200
Message-ID: <20200227120932.12542-1-sergiu.cuciurean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-27_03:2020-02-26,2020-02-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=966
 suspectscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002270099
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
 drivers/fpga/ice40-spi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/ice40-spi.c b/drivers/fpga/ice40-spi.c
index 56e112e14a10..8d689fea0dab 100644
--- a/drivers/fpga/ice40-spi.c
+++ b/drivers/fpga/ice40-spi.c
@@ -46,10 +46,16 @@ static int ice40_fpga_ops_write_init(struct fpga_manager *mgr,
 	struct spi_message message;
 	struct spi_transfer assert_cs_then_reset_delay = {
 		.cs_change   = 1,
-		.delay_usecs = ICE40_SPI_RESET_DELAY
+		.delay = {
+			.value = ICE40_SPI_RESET_DELAY,
+			.unit = SPI_DELAY_UNIT_USECS
+		}
 	};
 	struct spi_transfer housekeeping_delay_then_release_cs = {
-		.delay_usecs = ICE40_SPI_HOUSEKEEPING_DELAY
+		.delay = {
+			.value = ICE40_SPI_HOUSEKEEPING_DELAY,
+			.unit = SPI_DELAY_UNIT_USECS
+		}
 	};
 	int ret;
 
-- 
2.17.1

