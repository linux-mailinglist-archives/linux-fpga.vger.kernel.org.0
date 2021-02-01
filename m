Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6AB430AAA1
	for <lists+linux-fpga@lfdr.de>; Mon,  1 Feb 2021 16:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhBAPLI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 1 Feb 2021 10:11:08 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:43862 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229864AbhBAPK5 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 1 Feb 2021 10:10:57 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 111F994T000757;
        Mon, 1 Feb 2021 10:10:01 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 36dbucusdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 10:10:01 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 111FA0ZN061902
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Feb 2021 10:10:00 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Mon, 1 Feb 2021 10:09:59 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Mon, 1 Feb 2021 10:09:59 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Mon, 1 Feb 2021 10:09:59 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 111F9uRY028808;
        Mon, 1 Feb 2021 10:09:57 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <lars@metafoo.de>,
        <linux-fpga@vger.kernel.org>, <mdf@kernel.org>,
        <ardeleanalex@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3 0/4] clk: clk-axiclgen: add support for ZynqMP
Date:   Mon, 1 Feb 2021 17:12:41 +0200
Message-ID: <20210201151245.21845-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-01_06:2021-01-29,2021-02-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 clxscore=1011 suspectscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=987 spamscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010082
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

https://lore.kernel.org/linux-clk/20210126110826.24221-1-alexandru.ardelean@analog.com/

Changelog v2 -> v3:
* added HAS_IOMEM || COMPILE_TEST and OF dependencies to driver in
  Kconfig
* added patch 'clk: axi-clkgen: use devm_platform_ioremap_resource() short-hand'

Alexandru Ardelean (4):
  clk: axi-clkgen: replace ARCH dependencies with driver deps
  clk: clk-axiclkgen: add ZynqMP PFD and VCO limits
  dt-bindings: clock: adi,axi-clkgen: add compatible string for ZynqMP
    support
  clk: axi-clkgen: use devm_platform_ioremap_resource() short-hand

 .../devicetree/bindings/clock/adi,axi-clkgen.yaml |  1 +
 drivers/clk/Kconfig                               |  3 ++-
 drivers/clk/clk-axi-clkgen.c                      | 15 ++++++++++++---
 3 files changed, 15 insertions(+), 4 deletions(-)

-- 
2.17.1

