Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938FA303B1D
	for <lists+linux-fpga@lfdr.de>; Tue, 26 Jan 2021 12:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404999AbhAZLHW (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 26 Jan 2021 06:07:22 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:61968 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404978AbhAZLG3 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 26 Jan 2021 06:06:29 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10QB1JIl001769;
        Tue, 26 Jan 2021 06:05:33 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 368hk9hnpr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jan 2021 06:05:33 -0500
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 10QB5V4F032142
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 26 Jan 2021 06:05:32 -0500
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 26 Jan 2021 03:05:30 -0800
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Tue, 26 Jan 2021 03:05:30 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Tue, 26 Jan 2021 03:05:30 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 10QB5PQc007159;
        Tue, 26 Jan 2021 06:05:26 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <lars@metafoo.de>,
        <linux-fpga@vger.kernel.org>, <mdf@kernel.org>,
        "Alexandru Ardelean" <alexandru.ardelean@analog.com>
Subject: [PATCH v2 0/3] clk: clk-axiclgen: add support for ZynqMP
Date:   Tue, 26 Jan 2021 13:08:23 +0200
Message-ID: <20210126110826.24221-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-26_06:2021-01-25,2021-01-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=717 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101260058
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Previous set:
 https://lore.kernel.org/linux-clk/20201221144224.50814-1-alexandru.ardelean@analog.com/

Changelog v1 -> v2:
* split patch 'clk: axi-clkgen: add support for ZynqMP (UltraScale)'
  into:
   - clk: axi-clkgen: remove ARCH dependency in Kconfig
   - clk: clk-axiclkgen: add ZynqMP PFD and VCO limits
* essentially removed the 'adi,zynq-axi-clkgen-2.00.a' compat string
* removed architecture dependency on build for driver; the driver should
  be usable also on PCIe setups

Alexandru Ardelean (3):
  clk: axi-clkgen: remove ARCH dependency in Kconfig
  clk: clk-axiclkgen: add ZynqMP PFD and VCO limits
  dt-bindings: clock: adi,axi-clkgen: add compatible string for ZynqMP
    support

 .../devicetree/bindings/clock/adi,axi-clkgen.yaml     |  1 +
 drivers/clk/Kconfig                                   |  1 -
 drivers/clk/clk-axi-clkgen.c                          | 11 +++++++++++
 3 files changed, 12 insertions(+), 1 deletion(-)

-- 
2.17.1

