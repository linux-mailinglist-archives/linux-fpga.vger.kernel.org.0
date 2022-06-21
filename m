Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9606552E53
	for <lists+linux-fpga@lfdr.de>; Tue, 21 Jun 2022 11:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348895AbiFUJ2s (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 21 Jun 2022 05:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348889AbiFUJ2r (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 21 Jun 2022 05:28:47 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12482E7;
        Tue, 21 Jun 2022 02:28:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ai6tC/diUTxn8DoPR+quCTFOAJA5hGS57S/ovH/19IS5lREyvl6Dycv4wOrDLltQA+jU+yA2Idoq5nK3fVJABAP4jIYbR8PLLqeOVSpSwZyqY4vOe+JR9j3HEVs2Nmm2uKg/56dKqgipQUuFmw/B6oDAXcJvVk0MFeoQxgS+cIuqwT5ReQmxlCWSYE/tiE0A1QC3uyrzdxm+QGRU1HwD3TcFvqOH/cnYo4ssRDxklFTouOqRqDrrNg3EypZdDtjy8L/P3KI+10qzye0GrJ+W2fLIlXBAJgXhWyMoq17OCC4mLiVGDDKQ8Hx8P1a57VglATLc5qtqGZU5itpsQddXuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/zlDA+4VdyUEHNl6rd7W9ZTfZawQR3r0WsgZMw9DxI=;
 b=bX3wAEJFxw5UN65jsOnWh3ktz1Eq7ILzqczbdhT7hUz1ynAZpFg1E24PvIA1TJDTMhCeLNn60uh2FF8Ipiw/fmWuUc1U1ygo+PT9kycr+DCjErRguFy3TSuWnJrUs7Z1SX3nUJutIvKwQEm3RzC9LRHiO+2rLs7HTfaqBgCjC1yL9BBWcn+Bgs4VgYDdHDeucRN5bHrJzl48F+8hoZzPUmRTpwOMW8zQwPOnOIF2WC7J60bOLc8clEwUB1e0rB05WXROmUVfakMF4wSir9gKGmOWYscrm+I66lvN8VDyJ9ojOtMlKWanJOUr5FUywdiWksuwMAPDED3WzuIoy17HIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=intel.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/zlDA+4VdyUEHNl6rd7W9ZTfZawQR3r0WsgZMw9DxI=;
 b=Bi8KVLFTD3EGufG1rcJlVF7zZThVq8HDVGBDsPaZkfP10kVtK4a7o7NkORsOfh0+rDO5rX6kTA/SzzMenIQWAy3L5Y3JqASjQZDhikYvQbaDQisFI/u13ck7vHFVKF81ACrNjgOt6/RAKitDPYtqZqhL+Xl3yqYYZlDi3XEzSJ4=
Received: from SN6PR04CA0100.namprd04.prod.outlook.com (2603:10b6:805:f2::41)
 by DM5PR02MB2203.namprd02.prod.outlook.com (2603:10b6:3:5b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 09:28:42 +0000
Received: from SN1NAM02FT0023.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:f2:cafe::1f) by SN6PR04CA0100.outlook.office365.com
 (2603:10b6:805:f2::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16 via Frontend
 Transport; Tue, 21 Jun 2022 09:28:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0023.mail.protection.outlook.com (10.97.4.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Tue, 21 Jun 2022 09:28:42 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 21 Jun 2022 02:28:40 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 21 Jun 2022 02:28:40 -0700
Envelope-to: git@xilinx.com,
 hao.wu@intel.com,
 trix@redhat.com,
 mdf@kernel.org,
 yilun.xu@intel.com,
 gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org
Received: from [10.140.6.60] (port=45120 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1o3aBc-000DOt-1Z; Tue, 21 Jun 2022 02:28:40 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <michal.simek@xilinx.com>, <hao.wu@intel.com>, <trix@redhat.com>,
        <mdf@kernel.org>, <yilun.xu@intel.com>,
        <gregkh@linuxfoundation.org>, <ronak.jain@xilinx.com>,
        <rajan.vaja@xilinx.com>, <abhyuday.godhasara@xilinx.com>,
        <nava.manne@xilinx.com>, <piyush.mehta@xilinx.com>,
        <harsha.harsha@xilinx.com>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <git@xilinx.com>
Subject: [PATCH v2 0/3]Adds status interface for zynqmp-fpga
Date:   Tue, 21 Jun 2022 14:58:30 +0530
Message-ID: <20220621092833.1057408-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa949471-0d0d-4c11-1ba1-08da53686e7b
X-MS-TrafficTypeDiagnostic: DM5PR02MB2203:EE_
X-Microsoft-Antispam-PRVS: <DM5PR02MB22035ED7F45FEFB41CB18796C2B39@DM5PR02MB2203.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c/oNx71aRhfPOE0DE3Xlg1p/fkDasIrmBprNp7WUXnoJJswprXI0XyZH1biHsjWKHMBzzvNH4TdhjVaYl7U2N1k2QVQqHY+kp2s13B9vpzH1vG6eK4gLq50UIaSuj288NKnY0RGPoPlCX9N30BCsHsS6QEdKdFCMRyfB2j4+L1dmcU12SeNvvEvAR54rI1+Nwp5NkV/HhHrraLbsOzSxYGyLAVn2DTE0QLeELeBZTkKC7Fm020zwDQHMpqtl1dC6GbzbkBpIbFokUAxv6rKmbUkO7LkpbnzsITPM9zuY11vLXhTWhzBfLrlTbIbdHg9IPPSaUvkYRaJ0tlmymCJQinv8gg4ilGBDzFxdDZliR5e8by42mKc1d5V/t0+pOahMcULgzIeCoB6zBguFaJITjHDIqHC+eQWl6EoE0FrGqgZgUEsOGTJ2OtS3XHPWnFP5HkQ9xHp72xVTYPWnJ34trUv8EgttGFWhMg/1FzJk7RszoJcRKCPFfAWqDnbTTQoHdB11dc9AxtzpzLHlj50D4ySmQnwBesvgnCozU/2huBmIr6G9Lf/zogF2PiHFJWylYHw2gVME3fBN7rlaf1TCCgD+U+9h5PfbcMFPf6ZPCls6ikv6A4RA+a0KttryIa9ebmRbuojR2EuseNoLBJcJYrK4PvL7Qggs8/PbDf8S1LWmBttilxVYbIC6bt4G/wru6fMdFQ0m3Avr+38MOGL+CG3klGEN+0xDzS0ldJ7UGHtt0Tm/4Fef2VLw22iOVqPbR31BnTG/VFp1Fs8rzDI/8n1gmFslc8Klaz9B1JI9MmVUqed78p+TZ1GzT838OnMHBwEuloYCp5IgCvJu8otrN+Iw1PPmkk6lg03R1Lo14dlB5MUCfbiLjKTAkhRKui4ibVtdDFQVfnaKJwy+bD0r0dtkAQ9XlqhMqTCvkl4ZcuQ=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(39860400002)(136003)(346002)(46966006)(40470700004)(36840700001)(356005)(921005)(82740400003)(7636003)(36756003)(478600001)(966005)(26005)(7696005)(6666004)(336012)(316002)(6636002)(110136005)(186003)(70206006)(70586007)(41300700001)(1076003)(426003)(2616005)(8936002)(2906002)(5660300002)(82310400005)(40480700001)(8676002)(9786002)(4744005)(83380400001)(47076005)(40460700003)(36860700001)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 09:28:42.0831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa949471-0d0d-4c11-1ba1-08da53686e7b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0023.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2203
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Adds status interface for zynqmp-fpga, It's a read only interface
which allows the user to get the PL status.
 -Device Initialization error.
 -Device internal signal error.
 -All I/Os are placed in High-Z state.
 -Device start-up sequence error.
 -Firmware error.

For more details refer the ug570.
https://docs.xilinx.com/v/u/en-US/ug570-ultrascale-configuration

This series rebased on 5.19v
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git 

Nava kishore Manne (3):
  fpga: manager: change status api prototype, don't use older
  firmware: xilinx: Add pm api function for PL readback
  fpga: zynqmp-fpga: Adds status interface

 drivers/firmware/xilinx/zynqmp.c     | 33 +++++++++++++++++
 drivers/fpga/dfl-fme-mgr.c           | 20 +++++------
 drivers/fpga/fpga-mgr.c              | 24 +++----------
 drivers/fpga/zynqmp-fpga.c           | 53 ++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 14 ++++++++
 include/linux/fpga/fpga-mgr.h        |  2 +-
 6 files changed, 116 insertions(+), 30 deletions(-)

-- 
2.25.1

