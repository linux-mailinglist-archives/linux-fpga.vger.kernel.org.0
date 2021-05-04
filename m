Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B42A3728BB
	for <lists+linux-fpga@lfdr.de>; Tue,  4 May 2021 12:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhEDKXn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 May 2021 06:23:43 -0400
Received: from mail-bn8nam12on2065.outbound.protection.outlook.com ([40.107.237.65]:63841
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230153AbhEDKXl (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 4 May 2021 06:23:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnWtwXGdOSCuJFZKZA6jZ3I012iFrzMVzhK/fPZp5fhEvyYe7+R5h2j79StVq/M4axipRQdr7VkG+fE/cW+j++p9JXPj52dtNCtdFxMMn6rCMjg0M/tFiZ6wYjGvc2WDUmRle4gQkT/bLSV0WdWOIzEVQOe8kzPcTSnTiPVWujCDD4Trb4zRql0dRBvWMXR+GBcDL4/Dt3n35xgzrxWGCFfooWxqxTaJSbbgbapvHnK0qoq4n3jEpHM0s0tPftdeMA5LPqMM/fglZyPIHsV6MuSnfSmsXun+KR56vsOE4ETKgeQktTYzc4DExiusFDIO7oG1ovY6YJctJhs/IBEtQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvYFb+CxhUBn7Qj3wKU6yp2ZATWNaPZZhODtcKPyoCQ=;
 b=CtGIcpasPgkqG9SXb9yRbKlw3JdN11BfQFhCJW6quThTt6gdMSVdZN82hrS3FeoDoLmsKeSVh13acAdyiIJfmXA/crybk7HDmdz5jCb4G0iG43CS8au1l5dcKpcJ/qYXAWNG7X04V+iOc6ChqU4+YVSKLRS1NPQ6eUChDersvNi2B5rnxzNgI2GWanQA0XoPoukuGSnAHy6M6bgj37EY/mUQltd2UBMHtlyhBxuVkX0+dhDZhSsYhtH3OWifMtIXHfA7yww9YKB4KjIqlDGCCgKirZeqDr7Zhl5EySMU4i875RBSZe4yOW5+nWTZxe9hbOV0Nu7WFSRfoSZsK2g17w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvYFb+CxhUBn7Qj3wKU6yp2ZATWNaPZZhODtcKPyoCQ=;
 b=K4iuRcA5UfHNcLl94km0GMH/3XujOcsxxrJIY6BGuVpH1Y2VUcS9iG67NRXXK8JQCp7uWnhUz6+PTDmUAExrQZUvuf4IWWtHVy6mxJvz50WGH5Hm5ZyCdWlL9mvklj3Or/CIJRC4+uQCQewIlQyh3CZej3YID9/Tm+u2vb9H9IQ=
Received: from SN4PR0501CA0103.namprd05.prod.outlook.com
 (2603:10b6:803:42::20) by PH0PR02MB7799.namprd02.prod.outlook.com
 (2603:10b6:510:5d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.40; Tue, 4 May
 2021 10:22:43 +0000
Received: from SN1NAM02FT042.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:42:cafe::a9) by SN4PR0501CA0103.outlook.office365.com
 (2603:10b6:803:42::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.8 via Frontend
 Transport; Tue, 4 May 2021 10:22:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT042.mail.protection.outlook.com (10.152.73.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Tue, 4 May 2021 10:22:43 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 4 May 2021 03:22:36 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 4 May 2021 03:22:36 -0700
Envelope-to: git@xilinx.com,
 mdf@kernel.org,
 trix@redhat.com,
 robh+dt@kernel.org,
 arnd@arndb.de,
 gregkh@linuxfoundation.org,
 linus.walleij@linaro.org,
 zou_wei@huawei.com,
 linux-fpga@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 chinnikishore369@gmail.com
Received: from [10.140.6.60] (port=35290 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1ldsCJ-000192-HZ; Tue, 04 May 2021 03:22:35 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <trix@redhat.com>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>, <arnd@arndb.de>,
        <rajan.vaja@xilinx.com>, <gregkh@linuxfoundation.org>,
        <linus.walleij@linaro.org>, <amit.sunil.dhamne@xilinx.com>,
        <tejas.patel@xilinx.com>, <zou_wei@huawei.com>,
        <manish.narani@xilinx.com>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>, <nava.manne@xilinx.com>,
        <wendy.liang@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>,
        <chinnikishore369@gmail.com>
Subject: [RFC PATCH 0/4]Fpga: adds support to load the user-key encrypted FPGA Image loading
Date:   Tue, 4 May 2021 15:52:23 +0530
Message-ID: <20210504102227.15475-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f550406-5945-4804-1f10-08d90ee68dcf
X-MS-TrafficTypeDiagnostic: PH0PR02MB7799:
X-Microsoft-Antispam-PRVS: <PH0PR02MB77999187901B814955732F44C25A9@PH0PR02MB7799.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DorDjRf7dK3OAdMtyENUVhvmZKmEQZW1jk5kAyr+v4oqim9oYZWKc68Sabc4LC2KSHYW6UF7CdaH700S8EzfzqdaR9DL9yKSMtuJSt62TJ0PYMK5/eQ0fbJFAg0gFGzcK3bj9zXo/aIenp8kfof5f5KBgIH+ts5v1KVPXlxn306L/AUNHxwTRgN6cJx9jvR2I14pxUCZ2+76GWaEpjIThjpDsXkl+ryUen9gJmiIHEoDqRud/Z84kN3vQyEf9tgqzJ3huFxrXBxg1oQ9nQBcrjb8mDyOgRVR9Mw+jMcJGLf6DHtRCiO5Cf5Ud/XtxhH0yD6PnLBhMH2s+2PBQCWXGkfIaYHKGBCQsR5UPduCs+VCQhLhkl3Z3xVtDtKgQrap4Cv9EEsNU9ksjeLs0ytN6wgQo20FNpgjFrKgq00PJRZaY9xdH3I9MxOTmKEkK1+gvcYwRGHnxawjUHMcY5yru8n/plDPhR542NlEOPITy27iaOoyo4xh8TU5KofT0LpRyio5th3Gu+avmiAEiearoCNhs478A+PH2hBuO2+i4MBrC8mEbPeOYX9NrecLa1CmP9a2nBe7PdY052M+JSEEcQc1CcwD7d/EjKBShVV4MyUv38UyhFbFUvO1GkXS4MvlI2XcEvhtZth2QTJyWaGfCNouH1W1FGOR4RFM0v4p6I8E7ttymIB8KYPUlYioI6K6v7bq29FivHFKjciDNQjwiUU5BUZYLWtOWimxn/L/e/4NOOjVq5g1xwthy6E6r/aA
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(36840700001)(46966006)(7416002)(336012)(5660300002)(8676002)(82310400003)(7636003)(36860700001)(8936002)(26005)(1076003)(4744005)(36906005)(2906002)(316002)(2616005)(356005)(36756003)(70206006)(47076005)(478600001)(9786002)(7696005)(110136005)(82740400003)(186003)(70586007)(83380400001)(921005)(426003)(6666004)(102446001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 10:22:43.3260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f550406-5945-4804-1f10-08d90ee68dcf
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT042.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7799
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch series adds supports user-key encrypted FPGA Image loading using
FPGA Manager framework.

Nava kishore Manne (4):
  drivers: firmware: Add user encrypted key load API support
  fpga: Add new properties to support user-key encrypted bitstream
    loading
  drivers: fpga: Add user-key encrypted FPGA Image loading support
  fpga: zynqmp: Add user-key encrypted FPGA Image loading support

 .../devicetree/bindings/fpga/fpga-region.txt  |  5 ++++
 drivers/firmware/xilinx/zynqmp.c              | 17 +++++++++++++
 drivers/fpga/fpga-mgr.c                       | 15 ++++++++++++
 drivers/fpga/of-fpga-region.c                 | 13 ++++++++++
 drivers/fpga/zynqmp-fpga.c                    | 24 +++++++++++++++++--
 include/linux/firmware/xlnx-zynqmp.h          |  9 +++++++
 include/linux/fpga/fpga-mgr.h                 |  7 ++++++
 7 files changed, 88 insertions(+), 2 deletions(-)

-- 
2.17.1

