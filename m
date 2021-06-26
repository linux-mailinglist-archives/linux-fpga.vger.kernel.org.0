Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61BD43B4F50
	for <lists+linux-fpga@lfdr.de>; Sat, 26 Jun 2021 17:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhFZPzv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 26 Jun 2021 11:55:51 -0400
Received: from mail-mw2nam12on2068.outbound.protection.outlook.com ([40.107.244.68]:31585
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230104AbhFZPzu (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 26 Jun 2021 11:55:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hy92E6YzyqtxDSE/XjOvsm2GZs97WOm9YGggzzBIdRyUiiIKZ2LiLtbmKUwrQroQCdIFsCuhA1AhRviKJZop+bxR2QDT8kCiVk4iCufhiLjCAmK0hLa6wejP45jGb1j43fAbOAzcuC4teG+hFM14Q2UrnpZbZ6ZCNy5zXjD2lLKinbr8WkE72LQq3S6oZM5MjMdrJxlNktNDv2e3jc2OlXtyxPjiXm3sJ07Bp2RNdye95Q7SrPgpqrUHXPuDiywYPfi0PMvtaWEfb65iW4p5Zg9lpu2kgXTQOFZADUeOLgQrwexg1gFIUa0FDv8u48QItuhfBfDBrLjU55Uehd5iag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYleBcyBD1ozOuI3ySKeI2qLzqZET7rd7G9OLw9gays=;
 b=ODzBvCO5d4nsZyFrlWBvEjmlReMN+02uAD80fANjUPyxetzYWHfWYF5ceyfLkUnm7AZyEMR+L2RDUp8Lwz+Fveol1lskdeJKToJInAB6MGm/+6aNPBFef48vniOyBd+3qxE+VD2W89UUSRJujkiBKOX321bejr02c2bpIPVh3CBymL9YzugNgxk17Mc9C1LXaRYEl6z8RVlHw+piWdsrSnFjCyNp4weNowZmIReqdsY6d3JPqBeEOV0L1hRo600IqjO8kSo/cIgaoGNsLS+y1SNbYT219ah2As6mEyMpqF832WI/SiaRXJnqWUgBNOI6qv4tTxGd/nWFScaHzlWr2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYleBcyBD1ozOuI3ySKeI2qLzqZET7rd7G9OLw9gays=;
 b=MdU/MlEu/nXiJT4SfnwDLWIFhepZATbavJT27MaC4aoWfv20hGaacbRl5EbX13F8wdlMn7c3grsa8QtuJ48UeL3duIDWRolngwCSKAM/PaQKxp2iHYeVLdmSCVxOWC8zvH3Iz97SIUAtxsQFKX4mrfbzz/9LqRp4EGn6hxsaAtk=
Received: from DM6PR13CA0047.namprd13.prod.outlook.com (2603:10b6:5:134::24)
 by MW2PR02MB3643.namprd02.prod.outlook.com (2603:10b6:907:5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Sat, 26 Jun
 2021 15:53:27 +0000
Received: from DM3NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::4e) by DM6PR13CA0047.outlook.office365.com
 (2603:10b6:5:134::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.8 via Frontend
 Transport; Sat, 26 Jun 2021 15:53:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT044.mail.protection.outlook.com (10.13.5.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Sat, 26 Jun 2021 15:53:26 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 08:53:18 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Sat, 26 Jun 2021 08:53:18 -0700
Envelope-to: git@xilinx.com,
 robh+dt@kernel.org,
 mdf@kernel.org,
 trix@redhat.com,
 arnd@arndb.de,
 gregkh@linuxfoundation.org,
 zou_wei@huawei.com,
 iwamatsu@nigauri.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 chinnikishore369@gmail.com
Received: from [10.140.6.60] (port=59432 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1lxAcP-0000uY-Cl; Sat, 26 Jun 2021 08:53:17 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <robh+dt@kernel.org>, <michal.simek@xilinx.com>, <mdf@kernel.org>,
        <trix@redhat.com>, <nava.manne@xilinx.com>, <arnd@arndb.de>,
        <rajan.vaja@xilinx.com>, <gregkh@linuxfoundation.org>,
        <amit.sunil.dhamne@xilinx.com>, <tejas.patel@xilinx.com>,
        <zou_wei@huawei.com>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <ravi.patel@xilinx.com>, <iwamatsu@nigauri.org>,
        <wendy.liang@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <git@xilinx.com>, <chinnikishore369@gmail.com>
Subject: [PATCH v8 4/5] dt-bindings: firmware: Remove xlnx,zynqmp-firmware.txt file
Date:   Sat, 26 Jun 2021 21:22:47 +0530
Message-ID: <20210626155248.5004-5-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210626155248.5004-1-nava.manne@xilinx.com>
References: <20210626155248.5004-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae32428d-6acf-4de9-d547-08d938ba895d
X-MS-TrafficTypeDiagnostic: MW2PR02MB3643:
X-Microsoft-Antispam-PRVS: <MW2PR02MB364361170D50A44928FDDD9BC2059@MW2PR02MB3643.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8FngwFnHKylqFvCKXe6AccD+b1f4HR2hxx5xNRoIER3sMvKwalJOzSeU12gYyNTLla8du4btIOoghb8VnI4B6ez2OhIlI9l8tVXv+c7pCbiI+ajpsfPud/UanzUt6zVFybf9drHb+wz7kfnedSewtru3T9fWSvxIbkl+4tUN1oQRIkFZKDXJiFDOfZTL20jK6Lek46Fne0o9DQzggrzCpvOYSAUW2MnQ8CeenQQgQ1xfhzMN7PrKBDqktzltHepijgygj9aroJWdAkZdeCOjqSHXA2c2y0W633tzN9WzxwL5MfijSmddj34K29F082xrBmnR6LbAICkM1VzFSoeBUqvDxzoeR7l/2+sDpY5GBk4P8AuAjoGAcCHlei8NGvBWGdeT04pYFtNLPAYwZmWaSNhjjUJrsjf3Y+QbfaQVN4qE6RUDb6Ppxh/SZV8nY0bai4Tpz8zbwodXuNaM2CXbv1mbBYh8Ui0B8VL279vwZlzqyq2HzM63BwmEdk1aTxITerWFpyYqBGVswoprXPOl/QLCuBsgFPE4sjGWcq+gfxmuQc7E8ZtmqJtOwY8JbnF9zU0ToAvTrU4B2wv+Uqvod2WwGGCINwe51jLvzBvnZnExUyZqeRT52sdakqfo4gMv7XqSoF0MR4f0VZ1nTMsNebfRWDB/hxhtu5De4Y79b7XmizenjJlyjSalF0IIGvsBrhuXwLTj819ltctlaIlprD3a6IcpFIH1OS1sT+1yatnGTXoYuWEe0nLtTTLGRb67
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39850400004)(376002)(136003)(346002)(396003)(36840700001)(46966006)(921005)(110136005)(7636003)(478600001)(26005)(8676002)(9786002)(2906002)(1076003)(426003)(70586007)(8936002)(356005)(36756003)(82740400003)(186003)(36906005)(336012)(82310400003)(316002)(47076005)(6666004)(2616005)(5660300002)(7696005)(7416002)(36860700001)(70206006)(83380400001)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2021 15:53:26.8436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae32428d-6acf-4de9-d547-08d938ba895d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT044.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR02MB3643
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The funtionality of xlnx,zynqmp-firmware.txt is replaced with
xlnx,zynqmp-firmware.yaml bindings so this patch removes the
zynqmp-firmware.txt file

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v8:
              -Removed xlnx,zynqmp-firmware.txt as suggested by rob.

 .../firmware/xilinx/xlnx,zynqmp-firmware.txt  | 44 -------------------
 1 file changed, 44 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
deleted file mode 100644
index 18c3aea90df2..000000000000
--- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
+++ /dev/null
@@ -1,44 +0,0 @@
------------------------------------------------------------------
-Device Tree Bindings for the Xilinx Zynq MPSoC Firmware Interface
------------------------------------------------------------------
-
-The zynqmp-firmware node describes the interface to platform firmware.
-ZynqMP has an interface to communicate with secure firmware. Firmware
-driver provides an interface to firmware APIs. Interface APIs can be
-used by any driver to communicate to PMUFW(Platform Management Unit).
-These requests include clock management, pin control, device control,
-power management service, FPGA service and other platform management
-services.
-
-Required properties:
- - compatible:	Must contain any of below:
-		"xlnx,zynqmp-firmware" for Zynq Ultrascale+ MPSoC
-		"xlnx,versal-firmware" for Versal
- - method:	The method of calling the PM-API firmware layer.
-		Permitted values are:
-		  - "smc" : SMC #0, following the SMCCC
-		  - "hvc" : HVC #0, following the SMCCC
-
--------
-Example
--------
-
-Zynq Ultrascale+ MPSoC
-----------------------
-firmware {
-	zynqmp_firmware: zynqmp-firmware {
-		compatible = "xlnx,zynqmp-firmware";
-		method = "smc";
-		...
-	};
-};
-
-Versal
-------
-firmware {
-	versal_firmware: versal-firmware {
-		compatible = "xlnx,versal-firmware";
-		method = "smc";
-		...
-	};
-};
-- 
2.17.1

