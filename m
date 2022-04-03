Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA2F4F07C1
	for <lists+linux-fpga@lfdr.de>; Sun,  3 Apr 2022 07:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbiDCFSp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 3 Apr 2022 01:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiDCFSp (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 3 Apr 2022 01:18:45 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F5B36B42;
        Sat,  2 Apr 2022 22:16:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iev9HVsLAn9V7wGB05EDTHVMyEpfdTOn36cU/RDy7D5g1wu8StfwuPsHJ0o5Fi3I9uMrh9wag555e2qa4xSB/zdmvkca4fSGDkgzaMoI3nqv0nfneAJBGY1GPDC4LHMph3raYhZf3P5pEOG3MGio0hEm2ZOvUyNnER5Q65zDoy+YbHjTwtxVUA1g9eDgiZM3jGL3BBD1EnJeuvH0HPG2SZw00YfPAUf/MA55iCa+K8Y6fTXJMW8ALWZCoMaeA6zQ/2oKPndAeOALLiC1y0nuS6/aaOyJyTZXsZDO863VR1OqfagjDuAtDqvk31rn5xc9xCIaGglOVDCjrZYEGshRKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQeeTDhD5/yh7EMtzHW6umGwUc6k8b9aeKy9qkJ/yw8=;
 b=Uq1EJIKQRBiJXA7stF5LaMAa9bksaDAdtoDVJRTFKdGl396RqiDQHy42YSjhrhrSGpiLztG1GDu2rbrpR6vDx4aODNubkLlWD9LevLByHqJoi/dkSguTBdCiCqJnAWZqKcTYjBXgwgecgsfsCXyYYfjSbkF9aMcBtSbtQLI3l/6MrcGspCYe9woZ8BOPo8ToQ0AEsPqW76yhksoeOhfepd76GETCRE5i0hKtheVt5pA7q8jTigF7nMbzOMTku58A1xQbroEKZXtzCn7EfZc5sfgpwTUkdvtOcZRbAinYKyIDRkWsK27vzApfL6f43yGl3vW88Uhfe+ReJZ3OIwPuEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQeeTDhD5/yh7EMtzHW6umGwUc6k8b9aeKy9qkJ/yw8=;
 b=CuIwE4fZ1Kwvn9k3ohUK0Li2CfHguq3H3Dv0Fga5A6yZfH2UKyQvtUCnzlweUOtiwUcNOTCjUp/kRwViuzghoko8Gk3blx4HbPkMNc7lea5OHK7/oTvhIjQDiKMoEXXtd6zi++m7ZiSqKBopQJhy/zGS1E2ejdKiqRfnNGAKE78=
Received: from DM6PR11CA0014.namprd11.prod.outlook.com (2603:10b6:5:190::27)
 by PH0PR02MB8374.namprd02.prod.outlook.com (2603:10b6:510:102::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30; Sun, 3 Apr
 2022 05:16:49 +0000
Received: from DM3NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::ff) by DM6PR11CA0014.outlook.office365.com
 (2603:10b6:5:190::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18 via Frontend
 Transport; Sun, 3 Apr 2022 05:16:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT017.mail.protection.outlook.com (10.13.5.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Sun, 3 Apr 2022 05:16:48 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sat, 2 Apr 2022 22:16:47 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sat, 2 Apr 2022 22:16:47 -0700
Envelope-to: git@xilinx.com,
 mdf@kernel.org,
 hao.wu@intel.com,
 yilun.xu@intel.com,
 trix@redhat.com,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.140.6.60] (port=54274 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1nasbW-0007vd-Ph; Sat, 02 Apr 2022 22:16:47 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v3 0/5]fpga: fix for coding style and kernel-doc issues
Date:   Sun, 3 Apr 2022 10:46:36 +0530
Message-ID: <20220403051641.3867610-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4910272-e080-4032-9c6b-08da15312795
X-MS-TrafficTypeDiagnostic: PH0PR02MB8374:EE_
X-Microsoft-Antispam-PRVS: <PH0PR02MB8374628B9BC0544A90D2B750C2E29@PH0PR02MB8374.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LfI54waPgqS2SiksR96FqNAgFz1jGYEIWZfS+3CJNlwzVIYW1O1crJsBEd5k321VaqiUjBejlYJXmrC5yYiNqHsf08LP29npAesDf7MvEJA0KsIIgeoAeP9wBCN71eTtKa3hGm8y7fG8mDt8ISUmZs3ztbXnuaiFGsyNinJvqhNWM54fm7+9X5rPQobchWzVl4GojXOx/VB0PpcJZ1awbc2L2UllG7WeBOfIJJovqJFt7RM8K1tPvFDvSF8p8r+5kB/nclBXXpJGe1IHzOMwpYEDTZ6VW5pmjn6lNd/Fwulk9QXjEppz0Je4n5CkVO6G/yWu2+1zxbymRDBSLl2soDcuzRJA/Fz8hssGMRnOdFVfg0zqA6LKF4WyDl1XbG9lWqKKNeUuLkKmb0MmwgQyPMXq7h9nBiT3fX9vnNUj/EPSxgP4EyouTv8rbXZoQ2bn80w3pdQx9oaB/SjHIaQiKfhm8o+qrZ1v5NBwffk3bxDGqZ5FDcrpabREoeCI0jBfMvXtWP3AmqDeX1f2ShawWKfLgLgtGkKMD3WEacF/8RtOB/FcA608BxCR7M+kI6IPg/w9mWO7KYljho8FzPkzj5JNDxjW7glIY5mM/mNvWkWeaMEnnZqF92Rzz1/qd52P9+RY+kRiJZXmvlyn5rOwhpCWxylrVnXEwIDxqPZnuB/AcYICge9e03CJ3DvPdfL2StajndrgpnAqRLAGxiPRmJMWz8JCmvY/AfVx3xHPleE=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(83380400001)(186003)(26005)(82310400004)(6666004)(7696005)(426003)(107886003)(336012)(356005)(2616005)(1076003)(7636003)(47076005)(36860700001)(8676002)(4326008)(40460700003)(70586007)(2906002)(70206006)(9786002)(5660300002)(8936002)(4744005)(36756003)(508600001)(6636002)(316002)(110136005)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2022 05:16:48.7106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4910272-e080-4032-9c6b-08da15312795
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT017.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8374
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch series fixes the coding style and kernel-doc issues
exists in the fpga framework, zynq and ZynqMP drivers.

Nava kishore Manne (5):
  fpga: zynq: Fix incorrect variable type
  fpga: fix for coding style issues
  fpga: fpga-mgr: Add missing kernel-doc description
  fpga: Use tab instead of space indentation
  fpga: fpga-region: Add missing kernel-doc description

 drivers/fpga/Makefile         |  6 +++---
 drivers/fpga/fpga-mgr.c       |  8 ++++++--
 drivers/fpga/fpga-region.c    |  7 ++++---
 drivers/fpga/of-fpga-region.c | 16 +++++++++-------
 drivers/fpga/zynq-fpga.c      |  8 ++++----
 5 files changed, 26 insertions(+), 19 deletions(-)

-- 
2.25.1

