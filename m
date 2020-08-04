Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D392323BA34
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Aug 2020 14:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgHDMX3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 Aug 2020 08:23:29 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:63986 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726398AbgHDMXZ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 4 Aug 2020 08:23:25 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 074B3JZc013155;
        Tue, 4 Aug 2020 07:05:37 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 32n6cjsqj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Aug 2020 07:05:37 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 074B5aMu005191
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 4 Aug 2020 07:05:36 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 4 Aug 2020 07:05:35 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 4 Aug 2020 07:05:34 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 4 Aug 2020 07:05:34 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 074B5VDs005208;
        Tue, 4 Aug 2020 07:05:32 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-clk@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>, <mdf@kernel.org>,
        "Alexandru Ardelean" <alexandru.ardelean@analog.com>
Subject: [PATCH 0/6] clk: axi-clk-gen: misc updates to the driver
Date:   Tue, 4 Aug 2020 14:06:52 +0300
Message-ID: <20200804110658.40911-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-04_03:2020-08-03,2020-08-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1011 mlxlogscore=773 bulkscore=0 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008040083
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

These patches synchronize the driver with the current state in the
Analog Devices Linux tree:
  https://github.com/analogdevicesinc/linux/

They have been in the tree for about 2-3, so they did receive some
testing.

Highlights are:
* Add support for fractional dividers (Lars-Peter Clausen)
* Enable support for ZynqMP (UltraScale) (Dragos Bogdan)
* Support frequency limits for ZynqMP (Mathias Tausen)
  - And continued by Mircea Caprioru, to read them from the IP cores

Dragos Bogdan (1):
  clk: axi-clkgen: add support for ZynqMP (UltraScale)

Lars-Peter Clausen (2):
  clk: axi-clkgen: Add support for fractional dividers
  clk: axi-clkgen: Set power bits for fractional mode

Mathias Tausen (1):
  clk: axi-clkgen: Respect ZYNQMP PFD/VCO frequency limits

Mircea Caprioru (2):
  include: fpga: adi-axi-common.h: add definitions for supported FPGAs
  clk: axi-clkgen: Add support for FPGA info

 drivers/clk/Kconfig                 |   2 +-
 drivers/clk/clk-axi-clkgen.c        | 253 ++++++++++++++++++++++------
 include/linux/fpga/adi-axi-common.h |  37 ++++
 3 files changed, 236 insertions(+), 56 deletions(-)

-- 
2.17.1

