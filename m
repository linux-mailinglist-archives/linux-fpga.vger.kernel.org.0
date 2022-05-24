Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1435326E9
	for <lists+linux-fpga@lfdr.de>; Tue, 24 May 2022 11:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235934AbiEXJv2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 24 May 2022 05:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235917AbiEXJv0 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 24 May 2022 05:51:26 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2048.outbound.protection.outlook.com [40.107.100.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95511CB1F;
        Tue, 24 May 2022 02:51:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLQRo+I+QQrQN77vLsaOQYcaPUU74xzpfHNko76ha7CtR1uNQTkYFcrQj2YGy/Qh4t1LdBgAsx0wL3De28PPnuMY+OJ84HaFQGpeTk25dmA0DQi8oWKCCRMTiJrd995e7feX6BirOM6BpOdIV5py9ieDCeNm5cc4B/rNQSpApRD9VSdadMTFStyfr3k5L6i7tY35nDobCrrTUTErqOjgiViJxIXxvePeXddiHDIqT/t7iwJ0+NEPhAgq3yhjOxtwDOSZQ6J/H5K0E/XKn8AESV3/ogHbWGaffgya1Dv0ArQfgnLx408uI66wrVlq+94hM/obVqQfUhBJCmL8Zeryrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25CbHyWvTpz2Vorks8wDWpAgL5sf+mITmGtznSu/K8o=;
 b=KKIOOVhPUJGK0Cf/CanLJG7G3qB4OgkfiwfjFGOi8Bo7FNkDIP1RR37BZfUQtRTcWRXf7Lg9YdGt7Q7srOdUfawWke8/vz7XEGaO+UD2Aiu1or1rDb+uUiPXVQekfy9t2RokadWPbtjhKuanmRiAymsfQO4QtrF1bqeUFXMtBr+SsEdJ56t8lOR0a4ePvjMd0c5Kfc7WxsZ4+Tte3sXEm9oSqYCByrgZSOso0UX3+ZNFOWOv7fBJdtCrRyO7BAXNPA1Hlf/H+VXp+sFEses15vUoSmu/uszJ2BojJ0wjsonuOBYvdv6cisJRg2qEKTBYk997p0NCbflL3AFo9hRCuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25CbHyWvTpz2Vorks8wDWpAgL5sf+mITmGtznSu/K8o=;
 b=NkNAYg22Z/CLv1FLHqFfd5jbFUemCOF4BMyWiIM9XIQxkBV9IHqCT+TxoEqjHrjfmZP73pnDi8hI0IPZ/mwRxo4FUt2AK6VQ1Q2f25TNhntoldu3TtO42BBhtChbwzfYRT3XQaibfZ0fXK07wYEbAN83Acm21/+rdQGsC8kUtCg=
Received: from SN4PR0501CA0130.namprd05.prod.outlook.com
 (2603:10b6:803:42::47) by MWHPR02MB2542.namprd02.prod.outlook.com
 (2603:10b6:300:44::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 24 May
 2022 09:51:19 +0000
Received: from SN1NAM02FT0030.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:42:cafe::26) by SN4PR0501CA0130.outlook.office365.com
 (2603:10b6:803:42::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.7 via Frontend
 Transport; Tue, 24 May 2022 09:51:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0030.mail.protection.outlook.com (10.97.5.194) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 24 May 2022 09:51:19 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 24 May 2022 02:51:03 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 24 May 2022 02:51:03 -0700
Envelope-to: git@xilinx.com,
 mdf@kernel.org,
 hao.wu@intel.com,
 yilun.xu@intel.com,
 trix@redhat.com,
 gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org
Received: from [10.140.6.60] (port=58200 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1ntR8u-0005Sf-CC; Tue, 24 May 2022 02:47:56 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <michal.simek@xilinx.com>, <mdf@kernel.org>, <hao.wu@intel.com>,
        <yilun.xu@intel.com>, <trix@redhat.com>,
        <gregkh@linuxfoundation.org>, <ronak.jain@xilinx.com>,
        <abhyuday.godhasara@xilinx.com>, <rajan.vaja@xilinx.com>,
        <nava.manne@xilinx.com>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <piyush.mehta@xilinx.com>, <harsha.harsha@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <git@xilinx.com>
Subject: [PATCH 0/3]Adds status interface for zynqmp-fpga
Date:   Tue, 24 May 2022 15:17:42 +0530
Message-ID: <20220524094745.287002-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8ea0c78-aad6-4c0a-ca2a-08da3d6af3e7
X-MS-TrafficTypeDiagnostic: MWHPR02MB2542:EE_
X-Microsoft-Antispam-PRVS: <MWHPR02MB25422890B1B6189C19DDAF18C2D79@MWHPR02MB2542.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8NI5rgcr07A1qabU/iMH0xsxuRKQWcTY5rNugn4LicME6eZHfX6dcacvp8o1qQjaNkQwo8f/eCMeUDvlgA32uHO4btvQFmiK/5vCdXfVKcRNaFYG7Z0SXOJI/UI1j+Ktc+disA7EQXLV4BuBPeXNkFBplC09AxcFEvy3HNq8vKQDUuXYxBmKBDjGmugpBMH4tL1xkI+ccf6tfnpWfJ6zILR6nGPUDgLfkuO5vN5EdUNaxtB1Ltysu39ChI4nS6t7K+43whq5dDDqaBWfTfWQD/Upa8tYsl4bYZx7hscsEvmRCndelEqellm8DL6Nju5rVSjdCbDYCi6TSMD30UlgOoieJJWhvBqfDr/WLSYBSMiZFRe45Lu3FAPGgr9kENEXQgAP4H+mlgcvmSsd7idy4z1BfMOEpfCosfxlTLQcvOkr5xaYcqpu33rsn1e5DBkttmIBa1FkELe23z9KMmuO06EvedbRyz8nITa/Rlo/wY8YvEVaCJGPe/vMzORJ+dr02NwkIrtaFt3V/KSScpzN1vA+oiPoPUuZlb6JhvPcPocMGaPF565aQt05IRBIzj6YRe5swRn7naj9jMdyCM0LRHCg0ss4S6iH+59aMPx118wPY3pmfFrkfh8XjTDvO9ypovu8UDiiLX+CVNiNDVKRV4NhZ8BKNx6xlNB4ZySh3Ptsg9SCD91Zsmc12lGEkyr0eznslpBrUn/Q6NtMBxxE/zYSm3UcdIhKyBg8/E3DpbL5mewTdv5ldIVNiXxl9oKCrMbZvmTONdLL5oS88A4uSoHuqnKaUlh67nw4a65L9ifDHLsFrYgSIhoii3sMRpdrvbIkfvd86J7jZXlUcm2Uw2TQSZiPtkkinSxu9eLk6o8=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(426003)(7696005)(26005)(5660300002)(40460700003)(336012)(186003)(83380400001)(966005)(8936002)(9786002)(921005)(2906002)(6666004)(47076005)(7636003)(356005)(4744005)(2616005)(110136005)(508600001)(8676002)(70586007)(70206006)(36860700001)(36756003)(82310400005)(1076003)(6636002)(316002)(102446001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 09:51:19.3447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ea0c78-aad6-4c0a-ca2a-08da3d6af3e7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0030.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2542
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Adds status interface for zynqmp-fpga, It's a read only
interface which allows the user to get the PL status.

This patch series also update the below status values for
fpga-manager.
 -Device Initialization error.
 -Device internal signal error.
 -All I/Os are placed in High-Z state.
 -Device start-up sequence error.
 -Firmware error.

For more details refer the ug570.
https://docs.xilinx.com/v/u/en-US/ug570-ultrascale-configuration

Nava kishore Manne (3):
  fpga: mgr: Update the status for fpga-manager
  firmware: xilinx: Add pm api function for PL readback
  fpga: zynqmp-fpga: Adds status interface

 drivers/firmware/xilinx/zynqmp.c     | 33 ++++++++++++++++++
 drivers/fpga/fpga-mgr.c              | 13 +++++++
 drivers/fpga/zynqmp-fpga.c           | 52 ++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 14 ++++++++
 include/linux/fpga/fpga-mgr.h        |  6 ++++
 5 files changed, 118 insertions(+)

-- 
2.25.1

