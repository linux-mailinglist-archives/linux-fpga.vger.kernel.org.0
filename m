Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED194D13BB
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Mar 2022 10:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345450AbiCHJrE (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Mar 2022 04:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345452AbiCHJrA (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 8 Mar 2022 04:47:00 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525B741614;
        Tue,  8 Mar 2022 01:46:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7s8KsoiiXjSTWNdxXORAFGPOaGtRiJCJy04p8pKaEsAT71YVelRxYTavJKpm8GHNHJCkEDnRimmWBYpo5t+0OhgwOLG4oWZpqfHJ8S1GMxU9Cx0rK5EMzNSAwOdQ+t8t7+ZK340rIldKOIhd71NAc12Z4UB16HM1C6Yc1U5oNksyd/OjLUXXJsYeZIirS8jaMcx94RoHOSHelCuofmDQ4//vO3c+bCuQe1N5344alVUDLAoWNJEf63TzY/MfGJb7u0TFfJA4TEfz/1htuiQ0188XFvGVrakoYyHCg25lNDDWLoNkVTF4MYuR6Ra9XiB5K5xFLVwBlltTD1zLcecUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vj/bUOViPTrqSEqJgWWfkHn+V5i+SEAPvjremB5pSfw=;
 b=j4ongNdNOMgWTRFZKBgxenRLDH2c4NHxX7kaSzUv9tMaV/tDYNGaZOosR0dkKLuYqaFyg9A8+7uo9OV5DMZERkj6ESzWgqvoEYMC62/OEAlTVe/mxb4qPuRFgNC/6BPT47zZZli1ZYDjjYjMMGpM8EzjuMKF4+Q9N68MzRa/VlUwCAy59Ps5QcVNJbbRIWvtRwKO9kiQW/YKDcIqtwT/8y0pAHiWNZo8WwVjgTsu36/ZHaAgeAkjVfjsdG1Z7B5vgF9s3W0H4pBd/e+XiPvhvJFi4I8+Xc/h0I7lRtCtKYtJu1jPFPhEFjwGTjZTPaF2VXOvPc6FjudCQjmmXiXkGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vj/bUOViPTrqSEqJgWWfkHn+V5i+SEAPvjremB5pSfw=;
 b=n2bHlDhajGXsYyTkXpoj59+O11KyN2uidsy46v7XRbNCwT8Cmg5DUlA+/xKB5GmsJiBMIf9wxwYaODO9LQxfvWFaD3v99ydTzMDmIapnYjTJdH6Eh8iqhqh/kRxwNnGvyaAaXcP78ITdUevqHh0kjNiDyYnJSI5GZ4B9yTvj4S8=
Received: from DM5PR06CA0045.namprd06.prod.outlook.com (2603:10b6:3:5d::31) by
 SN6PR02MB5213.namprd02.prod.outlook.com (2603:10b6:805:70::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.17; Tue, 8 Mar 2022 09:46:01 +0000
Received: from DM3NAM02FT049.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:5d:cafe::c6) by DM5PR06CA0045.outlook.office365.com
 (2603:10b6:3:5d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Tue, 8 Mar 2022 09:46:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT049.mail.protection.outlook.com (10.13.5.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Tue, 8 Mar 2022 09:46:00 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 8 Mar 2022 01:46:00 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 8 Mar 2022 01:46:00 -0800
Envelope-to: mdf@kernel.org,
 hao.wu@intel.com,
 yilun.xu@intel.com,
 trix@redhat.com,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.140.6.60] (port=33304 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1nRWPn-000G0A-Mo; Tue, 08 Mar 2022 01:46:00 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH 4/6] fpga: fpga-mgr: Add missing kernel-doc description
Date:   Tue, 8 Mar 2022 15:15:17 +0530
Message-ID: <20220308094519.1816649-5-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220308094519.1816649-1-nava.manne@xilinx.com>
References: <20220308094519.1816649-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b35ed74-3a7e-4c6b-ad0b-08da00e87427
X-MS-TrafficTypeDiagnostic: SN6PR02MB5213:EE_
X-Microsoft-Antispam-PRVS: <SN6PR02MB5213EEC2ADA06FFA3BC30381C2099@SN6PR02MB5213.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f4BGtPDWcHf8TUIvsbfMl+6Acxw931JD6Nc2Rr/4fUR5mRNs7XDgJjKX0ipWeBlYC6MunkNpbnLdcXBI7jW7YYVZYDb16bGqwU4OyAKNLhEQtRka5TKqdzj4miwC/UAqgcC8wKuCHwM8lqR1WtJnYXa2z80NZgNCJ/uvBfaWFjQ67CGREwEEvEqmgO3W235laXZ97EPu8IDZgW0mWBbrpCB5dIM/yUIPlXiqghg19qfTIUgObSUGTIZwTqzkQFpWbGfYNDsDKMnElXA4mB1bczWv//vytHN4pIsYJrb4t1QV5joXdCifeZS+YizCT63YicCiEz5c5njPQKonDKiEw11ZujovoxUxZGUH2imKHZgvILBaIShlYN9WCKt1pU626XFpsdtsZBKAcL1CuELWiKyvD4j8c/1GS4xJtHTcuv4Hb3vQGU5EEwL3NAQPCPRUO2mDQOUdhGrP9q+BVoFhywkRk0VPtSr1TFabkHpcRx228qZ/r7zg5OBjwVs5b59lPwoNC+/a5i4LPaTkMqOohMbLUG9T5GScLCB/Dhuv/4kdc2vxYT3fBX08zTIZix7GjRNK0Mz2eEoxdBP9B9ivvezTgE0qWttyIvCKQXAMiM1eAHB2foCdQm4TgcLOW83ruVnSyn9iWG/BTWCT1y1RwOZ1HmzE67Xz4E8Xh+tJyOPciaQm5P7fyadg/Xjz8rMuGoWEBggx2Cf0Ndd2Y9SEhgNxtQ2wlUY6m/HuJY3jK4yhwOOOI7KqgbVSaFJIhjkt
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(83380400001)(316002)(110136005)(36860700001)(47076005)(356005)(107886003)(70586007)(70206006)(82310400004)(40460700003)(4326008)(8676002)(5660300002)(7636003)(36756003)(8936002)(9786002)(2906002)(6666004)(7696005)(26005)(2616005)(1076003)(426003)(336012)(186003)(508600001)(102446001)(21314003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 09:46:00.6735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b35ed74-3a7e-4c6b-ad0b-08da00e87427
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT049.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5213
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Fixed the warnings: Function parameter or member 'xxx' not
described.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
 drivers/fpga/fpga-mgr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index a699cc8e2fa6..354789740529 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -730,6 +730,8 @@ static void devm_fpga_mgr_unregister(struct device *dev, void *res)
  * @parent:	fpga manager device from pdev
  * @info:	parameters for fpga manager
  *
+ * @return:  fpga manager pointer on success, negative error code otherwise.
+ *
  * This is the devres variant of fpga_mgr_register_full() for which the unregister
  * function will be called automatically when the managing device is detached.
  */
@@ -763,6 +765,8 @@ EXPORT_SYMBOL_GPL(devm_fpga_mgr_register_full);
  * @mops:	pointer to structure of fpga manager ops
  * @priv:	fpga manager private data
  *
+ * @return:  fpga manager pointer on success, negative error code otherwise.
+ *
  * This is the devres variant of fpga_mgr_register() for which the
  * unregister function will be called automatically when the managing
  * device is detached.
-- 
2.25.1

