Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A004753132C
	for <lists+linux-fpga@lfdr.de>; Mon, 23 May 2022 18:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbiEWNpm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 23 May 2022 09:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236497AbiEWNpk (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 23 May 2022 09:45:40 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86075537F;
        Mon, 23 May 2022 06:45:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfKGm8J2fVXUrtaCJE8LAHqTyFqBOSMEwb2QrpDpCRpitpOpuBWNwqcI+TePSTfjWK4hDUFMohr+K8qWx5IO0S69dBirezlldl8UpwO4jlc23deKsY1jDjPRD3Mx6MyMYw8D7E6mnvbosfe00EVUioO30PVGYebLHgGKb6kZ/hdbQlbv2dDNQ9xnPB8TOJXntoATsBrcr+bkOtOirSKKXJoWtbIcoe+7ruDrcVzzuK6UJjjH1WC0tHr8d1N/dOpC4onK5NMBwhsDztjzYOjjUz6lEzHsNfBx22/g+1B2r6rNqf8rAbZ4Fy70acP/OKvX7/QBjWQd7616fmRA3ECzsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7JTE8l5I9B5I8zU6yAaYqjihb+4c44fEKgWyxjZU6fI=;
 b=QT1w2Ara+/ywD6I5N/fLOcoYqaGFHMLFZ6roe+v6Dht9JNPUbK9+JmoNqn6eHEHHpl8+b8R38PSI/Iw9Gi0hQc1/yOINELkgx+qcNAVSNBJ3Eozsdg+yyMfWDEdfTDIQv9ikSVnp0GJ1hLoxQEVzoghqHXDIc2r+LhJWJo85NoGcXBv3SuZK00Qil5RI+52PnF4z6ulu72KCAltcr/VKVcNOKBFTHAhN1VQq24jpgPaoYtmFqtv72e577xviIj5dOGawSy7yj3Zwjk7TxGik4bW2Hv+/Xf6Stcp9KXxEEgo1LVY+1A6w2ONj4xxb7IBTaXhYzYwLp0cDAXmxvEI3IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JTE8l5I9B5I8zU6yAaYqjihb+4c44fEKgWyxjZU6fI=;
 b=kKMlY9F2U3bh2PujmB2AoIG/5lEteBUglFCB5zbDC+GRH/qRtWG5bCNV3Iim3Qyxd37zwMucwuqpOLThOmDvB278rp9Ld0PJ4gTr3xI2dK1ULB/NHUf9fJ+2EbmMYxVtJh4fp87Hpe5daMQ1I6wUS3GgLkpL5IG+YOpxjBVKah4=
Received: from BN0PR03CA0040.namprd03.prod.outlook.com (2603:10b6:408:e7::15)
 by SA1PR02MB8495.namprd02.prod.outlook.com (2603:10b6:806:1fa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Mon, 23 May
 2022 13:45:36 +0000
Received: from BN1NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::32) by BN0PR03CA0040.outlook.office365.com
 (2603:10b6:408:e7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15 via Frontend
 Transport; Mon, 23 May 2022 13:45:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT014.mail.protection.outlook.com (10.13.2.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Mon, 23 May 2022 13:45:36 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 23 May 2022 06:45:34 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 23 May 2022 06:45:34 -0700
Envelope-to: git@xilinx.com,
 mdf@kernel.org,
 hao.wu@intel.com,
 yilun.xu@intel.com,
 trix@redhat.com,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 linux-fpga@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 robh@kernel.org
Received: from [10.140.6.60] (port=57798 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1nt8NK-000GwK-0X; Mon, 23 May 2022 06:45:34 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <michal.simek@xilinx.com>,
        <nava.manne@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>
CC:     Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: zynqmp: Add new PD_PL macro
Date:   Mon, 23 May 2022 19:15:15 +0530
Message-ID: <20220523134517.4056873-2-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220523134517.4056873-1-nava.manne@xilinx.com>
References: <20220523134517.4056873-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05ac98b4-cd6b-4b2e-ed92-08da3cc28417
X-MS-TrafficTypeDiagnostic: SA1PR02MB8495:EE_
X-Microsoft-Antispam-PRVS: <SA1PR02MB849554C4E9DB70CEB695439BC2D49@SA1PR02MB8495.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FAVgqIHayUuzlD9IfICs+fXXTx0hy/uTNtwvpEZk1+jsj0RAVK+asBw0cDXJS0a97MWP9PgaX0/qDrVvqTBQlEyBNBjoLYPDV6jMQfhd9Ems+RSYyQjCjIj6tCVFWxMnPwCeMVATcBq9cxnG66PwINZZtD9d7KUqvjRXpSaXGDhyaCmc+Or5aD5P6fdXicxzs4Iq2dc1oXhiY/ROr+j2FIoTNNqVhzwmBcTWtK8E5ZdOQXpdocZabyo49wTDFINyrUXBB09TFJaK0t5kWGslsjJT0ca7DbSZo7HsQ39tv2gtk0ObmwPIrO6fPnaohxUurWcBNhMZOb8LxHLAzMnQ3M8O7MQVWcsyGDFwLa4imdpEnui+K1LFZoRzfj+h7LyaO5EgNKd9FOb+olr+gcwpqw8X76wLqUWyxJGXmFmHBT9H8mP4l3pPet/vQ0s2Gy+97kvjF3DIRC0Jt0/KDOTj6xRBguf4u76EBUgc7aJsl8VX2dIh1oLkr1NR/qtnVpbERQY0ts6+LlIqFzMVjprHhQ0GBZDaqT4163yj7EcGFY/VMJO75n+0dcsW4anKhzhz2rDZuMe7qlz3m4Ghdaz0hQLPW2tq5YL9VPjohM99pxPH2LFk/Id4Hs6CPIqu4793wWdZ2/DxvjHVI6oJuY0/gZvt+YecQjwML/fvn/Kws4ALl3nhyYE06kiWSqFcxRinPk1JoqxtX5ep8aahcd2kmqfGg2wgkRHtwk2BUF6PQh8Gz1zz2RHWrNbYB4DgrORztjL3ocFMcpmAaWRg0u934A==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(356005)(6666004)(40460700003)(508600001)(921005)(6636002)(7636003)(2906002)(70586007)(4326008)(110136005)(70206006)(8676002)(7696005)(82310400005)(316002)(5660300002)(2616005)(36756003)(36860700001)(47076005)(426003)(336012)(4744005)(186003)(26005)(9786002)(1076003)(8936002)(7416002)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 13:45:36.2423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ac98b4-cd6b-4b2e-ed92-08da3cc28417
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT014.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8495
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add new power domain for PL region.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes for v2:
              - None.

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
2.25.1

