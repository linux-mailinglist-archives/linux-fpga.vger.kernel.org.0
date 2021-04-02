Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FB03528AD
	for <lists+linux-fpga@lfdr.de>; Fri,  2 Apr 2021 11:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbhDBJ27 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 2 Apr 2021 05:28:59 -0400
Received: from mail-dm6nam12on2065.outbound.protection.outlook.com ([40.107.243.65]:14720
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229722AbhDBJ26 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 2 Apr 2021 05:28:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WogvL01blSWVo7eQt+TLgbTjNGXU/wqLCHFFwKl+EcA3dCErD9zQ7XZ1N8AB+doctZWFStbHlRQXkgX2vZwD0sWSXojbpDrCRjcWcDV0oGeF8lF08P0++x7czVshLRlrsPK1c+3/KVc/P6EZu8OP9YtorjoQT3UyWMc8gag76UcdbZgDaPZ9Wp2OFaNZRV0dSrtA7kFSYhhgsuQKcFIb4Scu4QcEhpVma1Xj8+60ko9jSEI8O0NayoAza4Dat0y2mXb5mIWgZIn6Ypy0ASB7Tzuw6rbKkusyc7VSzurxZsBLhZZNwgE6b6kSPnSIVfM0xXBG73+LKiWx71jkGpbBHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voYHjumQwb/oY/ReHTNrQLtg56PzwhZNGF/hV/wwJcQ=;
 b=ZfmtHL2Wr+xvQT03Necoy0uOn//a591uywF81KIbS1OFdknNvqEcdILXaPmatDfT20YMVvLRS6a4NejS/x7XGlCK/UEj8NDSxWvtrUS50FW2pgtwDUGlYFELCAkxDD2fnDnOVPNcSMJUXvilq0UwIuzecNEtDrIMFm51lQS2la+YBYu+e0m8eUppVeOgx/Hivde12c8M026iCNqdxj2QZG6kuBlveqBGAlmD/nWj5WiyI+YrZIxOjWIgfTHQxHPejxnLJMibB3+YKGxoIt09c5UbpwjGl6wgnefgBVi3cMV3bChyFRcWkuYWsKRVnXwFIW7ZXudBBJlj9TXkhNGt0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voYHjumQwb/oY/ReHTNrQLtg56PzwhZNGF/hV/wwJcQ=;
 b=fKe7OmJbWULibMYn1feQhv+aV3TSh9b2aeXaxLXLvHqmvNHpVGniPr0pOCmx8Mh13RNl2GJioX/oxNtDAPjRgGWnuLEirP1t0RxkFHZwK3wJCXNWSPhCz/Qbqe+mz4UX6T9C5je50rmB9lJOFjmPN0Hfv20cAQSPjdMoaNt/TGQ=
Received: from SN7PR04CA0018.namprd04.prod.outlook.com (2603:10b6:806:f2::23)
 by BL0PR02MB5635.namprd02.prod.outlook.com (2603:10b6:208:82::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Fri, 2 Apr
 2021 09:28:53 +0000
Received: from SN1NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:f2:cafe::75) by SN7PR04CA0018.outlook.office365.com
 (2603:10b6:806:f2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28 via Frontend
 Transport; Fri, 2 Apr 2021 09:28:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT006.mail.protection.outlook.com (10.152.72.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3999.28 via Frontend Transport; Fri, 2 Apr 2021 09:28:53 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 2 Apr 2021 02:28:48 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Fri, 2 Apr 2021 02:28:48 -0700
Envelope-to: git@xilinx.com,
 mdf@kernel.org,
 trix@redhat.com,
 robh+dt@kernel.org,
 linux-fpga@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.140.6.60] (port=58326 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1lSG6g-0005gX-VA; Fri, 02 Apr 2021 02:28:47 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <trix@redhat.com>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>, <nava.manne@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>
Subject: [PATCH 1/3] dt-bindings: zynqmp: Add new PD_PL macro
Date:   Fri, 2 Apr 2021 14:50:47 +0530
Message-ID: <20210402092049.479-2-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210402092049.479-1-nava.manne@xilinx.com>
References: <20210402092049.479-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc6b5ac7-2bf4-4572-504f-08d8f5b9bb55
X-MS-TrafficTypeDiagnostic: BL0PR02MB5635:
X-Microsoft-Antispam-PRVS: <BL0PR02MB563593181DC0E92D8B774FD6C27A9@BL0PR02MB5635.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mg6qeLjzMkNqDZ89TkgnricjslQBdk6TLLHYJ7upyOk8sQm+ffqqmTtzGY+DMgj2fOkYV+66BL9NFrdQPtY6Kd+0GyI///W7ZE+PhQr34cRwXxk7CZxVeMZILzWMsaG3KAp6wjmFzabpcP/WC8j+G2DkmJ+GI5OZafghCWfPl6mJmThRhJVhK8GuwEW8BCgexUfYNqLDRxiIfNoPK02nqGgU3ctgiSA2xVCAPDSr00GXxpS6d9IsvG4Zn5uV+zbuxpoW2KeChSx6ZCHVlQZP0JWEj1o3Lv7pKIi+1upm2ieGANcXUP5E8JVMOplQBtBUcChNEHARhl5eHyTQ5pb//3D+OpSGuCYOskOCVHDVcC0h/jwncvCUI6WD5mbEocbB8PrMCoPRYNJBKBcXcWHYI/yo+5yyuP0SBqu/+uYfCuLsm8brsPTTCnGqZD685bckxXDz1TsblFNMvATOfEXKDbSizBfsP6QDDlUMZQyIjU1LTAW2yAzuKCUT5xP+iKx/C5YfSDIVSjGjZvLOnIpxypWSFsrKdcK255wKSmZQnAaoBU4boiuf+6UcrVMAN5P+HMkzn0uFHfZ2HKC/cUZZ3qu+pbz9bq7Tp2OHJOTq1sa1abfHI7THyB7y298eZ9hmkkT6/mOPP3mr6J7bhRhgORKePhNEEMXnRQWTeYRw+QHAb4hV+St2xeDeqbmElH34eONxp29wkn1sbqbkTeCcoOyR5AI/PWDIax+c6TCMaUPtekzjDHBt75CvVE92G5Af
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(46966006)(36840700001)(2616005)(4744005)(336012)(8676002)(921005)(36860700001)(36756003)(316002)(7696005)(36906005)(8936002)(26005)(5660300002)(7636003)(82740400003)(70586007)(426003)(6636002)(9786002)(82310400003)(478600001)(70206006)(47076005)(356005)(186003)(1076003)(2906002)(110136005)(102446001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 09:28:53.2800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6b5ac7-2bf4-4572-504f-08d8f5b9bb55
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT006.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5635
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add new power domain for PL region.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
 include/dt-bindings/power/xlnx-zynqmp-power.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/power/xlnx-zynqmp-power.h b/include/dt-bindings/power/xlnx-zynqmp-power.h
index 0d9a412fd5e0..5f718759c38f 100644
--- a/include/dt-bindings/power/xlnx-zynqmp-power.h
+++ b/include/dt-bindings/power/xlnx-zynqmp-power.h
@@ -35,5 +35,6 @@
 #define		PD_CAN_1	48
 #define		PD_GPU		58
 #define		PD_PCIE		59
+#define		PD_PL		69
 
 #endif
-- 
2.18.0

