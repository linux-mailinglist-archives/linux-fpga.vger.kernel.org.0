Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3874276B8C
	for <lists+linux-fpga@lfdr.de>; Thu, 24 Sep 2020 10:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbgIXIPV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 24 Sep 2020 04:15:21 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:48884 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727187AbgIXIPV (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 24 Sep 2020 04:15:21 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08O6jNIc021669;
        Thu, 24 Sep 2020 02:50:36 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 33r5u9b1sg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Sep 2020 02:50:36 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 08O6oYwZ063828
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 24 Sep 2020 02:50:34 -0400
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 23 Sep 2020 23:50:32 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 23 Sep 2020 23:50:01 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 23 Sep 2020 23:50:32 -0700
Received: from saturn.ad.analog.com ([10.48.65.107])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08O6oSlR022302;
        Thu, 24 Sep 2020 02:50:29 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-clk@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>, <mdf@kernel.org>,
        <ardeleanalex@gmail.com>, <mircea.caprioru@analog.com>,
        <alexandru.ardelean@analog.com>
Subject: [PATCH v3 0/6] clk: axi-clk-gen: misc updates to the driver
Date:   Thu, 24 Sep 2020 09:50:06 +0300
Message-ID: <20200924065012.59605-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-24_02:2020-09-24,2020-09-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 impostorscore=0 mlxlogscore=992 suspectscore=0 clxscore=1011
 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240052
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

Changelog v2 -> v3:
* for patch 'include: fpga: adi-axi-common.h: add definitions for supported FPGAs'
  - fix whitespace found by checkpatch
  - add 'Acked-by: Moritz Fischer <mdf@kernel.org>'

Changelog v1 -> v2:
- in patch 'include: fpga: adi-axi-common.h: add definitions for supported FPGAs'
  * converted enums to #define
  * added Intel FPGA definitions
  * added Device-Package definitions
  * added INTEL / XILINX in the define names
 definitions according to:
 https://github.com/analogdevicesinc/hdl/blob/4e438261aa319b1dda4c593c155218a93b1d869b/library/scripts/adi_intel_device_info_enc.tcl
 https://github.com/analogdevicesinc/hdl/blob/4e438261aa319b1dda4c593c155218a93b1d869b/library/scripts/adi_xilinx_device_info_enc.tcl

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
 include/linux/fpga/adi-axi-common.h | 103 +++++++++++
 3 files changed, 302 insertions(+), 56 deletions(-)

-- 
2.25.1

