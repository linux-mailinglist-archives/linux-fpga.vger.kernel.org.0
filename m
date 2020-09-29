Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A668627D175
	for <lists+linux-fpga@lfdr.de>; Tue, 29 Sep 2020 16:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgI2OkP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 29 Sep 2020 10:40:15 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:57388 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731244AbgI2OkP (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 29 Sep 2020 10:40:15 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08TEbOp4004134;
        Tue, 29 Sep 2020 10:40:13 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33t2j4kegy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 10:40:12 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08TEeBLa041934
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 29 Sep 2020 10:40:11 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 29 Sep
 2020 10:40:04 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 29 Sep 2020 10:40:04 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08TEdkc1028450;
        Tue, 29 Sep 2020 10:40:07 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-clk@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>, <mdf@kernel.org>,
        <ardeleanalex@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v4 0/7] clk: axi-clk-gen: misc updates to the driver
Date:   Tue, 29 Sep 2020 17:44:10 +0300
Message-ID: <20200929144417.89816-9-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929144417.89816-1-alexandru.ardelean@analog.com>
References: <20200929144417.89816-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-29_07:2020-09-29,2020-09-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009290130
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

Changelog v3 -> v4:
* added patch 'clk: axi-clkgen: wrap limits in a struct and keep copy on the state object'
  this resets the rest of the patch-set to adapt to adjusting the limits
  on per-clock instance versus being global to the entire driver
  Recommended-by: Moritz Fischer <mdf@kernel.org>
    https://lore.kernel.org/linux-clk/20200924142108.GA60306@archbook/

Changelog v2 -> v3:
* https://lore.kernel.org/linux-clk/20200924065012.59605-1-alexandru.ardelean@analog.com/
* for patch 'include: fpga: adi-axi-common.h: add definitions for supported FPGAs'
  - fix whitespace found by checkpatch
  - add 'Acked-by: Moritz Fischer <mdf@kernel.org>'

Changelog v1 -> v2:
- https://lore.kernel.org/linux-clk/20200804110658.40911-1-alexandru.ardelean@analog.com/
- in patch 'include: fpga: adi-axi-common.h: add definitions for supported FPGAs'
  * converted enums to #define
  * added Intel FPGA definitions
  * added Device-Package definitions
  * added INTEL / XILINX in the define names
 definitions according to:
 https://github.com/analogdevicesinc/hdl/blob/4e438261aa319b1dda4c593c155218a93b1d869b/library/scripts/adi_intel_device_info_enc.tcl
 https://github.com/analogdevicesinc/hdl/blob/4e438261aa319b1dda4c593c155218a93b1d869b/library/scripts/adi_xilinx_device_info_enc.tcl


Alexandru Ardelean (1):
  clk: axi-clkgen: wrap limits in a struct and keep copy on the state
    object

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
 drivers/clk/clk-axi-clkgen.c        | 283 ++++++++++++++++++++++------
 include/linux/fpga/adi-axi-common.h | 103 ++++++++++
 3 files changed, 326 insertions(+), 62 deletions(-)

-- 
2.17.1

