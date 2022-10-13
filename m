Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5525FD6A3
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Oct 2022 11:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJMJGP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 13 Oct 2022 05:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiJMJGO (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 13 Oct 2022 05:06:14 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2067.outbound.protection.outlook.com [40.107.212.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF704123449;
        Thu, 13 Oct 2022 02:06:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOPEzV0+cb/E2tQLK4lMXYDTAUrQoeNGD/npZW1wdV+052HQu3u4cdBmsm8+cbeQKjrzwvgi1TlwDTw+WOXiHquL77Ho5bQQR95S57ZklGRAP3gaGeAw6wYx66eMPzlW/I7/XruMfhaZOlMVXMrTHdBa/Evsvh1aGtOYcz5WIKd9c+tM6UOz23+WYHa7ntRwfgq9wTEhz+elob6mOSStjlD9md5HsxRchWYrfz0xHHhyKL8Va19eozquWn/C4yPK9C/9wkG5zygEsoi+lWguKsYUivEkgSYFum2C31VvSzpreKWQcYkUl+H87xZBynuNp6BFRUqrwKCMbyZE1FyoGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmXzxqEBuj3gpagXI4+RNkW29vjKpxax3lU2E+1NuQ0=;
 b=fz++mkcv8qZoEQLzJ9kFNs9tUstLUKWlBzieizNf/KKdgZRpyBuFh9Qfa9lINjjJ+1YQDSUU9yt5989vnL6HourLd0eygiYU49XWQhm/3oKO37NEPs0qichm7uXroPtuOtBraeRTHwEof3fc0ZfPU5FJDbKTTZXmsEtmo+6WSP3GAzf/kk3VECeeLhPvWy6ZQCIQqgADZgBrU3TKyEZUHN61IKro5J48jVAkiHavJ8HEIfkIXc2Sk3NAJoI/ln0ff6unMukTivVqc0kZ3f8vbXhpNNV/KpwcRKW8TfEIkh1Z1skkZc1erI9PZrcfDUvkgWyCQEjWEKef0YJ2e+JEOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=xilinx.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmXzxqEBuj3gpagXI4+RNkW29vjKpxax3lU2E+1NuQ0=;
 b=2/iY8F/HVNXY67bfGwJAzzAy2peaKNZNOyqkbJfxYf1Po0SHYJpZk1jmG8zb+cxM9Y3qFBNK8UuLVj8wknsB8qlrqXAiaOoVNOXN1025jF1bk9qbjfM9i2SLX6EanViaIl+V1pwufRvaINvZcCrzJi0T6GRxAiBoBpfjpFbI3CA=
Received: from MW4P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::13)
 by BL1PR12MB5707.namprd12.prod.outlook.com (2603:10b6:208:386::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Thu, 13 Oct
 2022 09:06:10 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::23) by MW4P223CA0008.outlook.office365.com
 (2603:10b6:303:80::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.22 via Frontend
 Transport; Thu, 13 Oct 2022 09:06:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Thu, 13 Oct 2022 09:06:09 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 13 Oct
 2022 04:06:04 -0500
From:   Nava kishore Manne <nava.kishore.manne@amd.com>
To:     <git@xilinx.com>, <michal.simek@xilinx.com>, <mdf@kernel.org>,
        <hao.wu@intel.com>, <yilun.xu@intel.com>, <trix@redhat.com>,
        <gregkh@linuxfoundation.org>, <ronak.jain@xilinx.com>,
        <rajan.vaja@xilinx.com>, <abhyuday.godhasara@xilinx.com>,
        <nava.kishore.manne@amd.com>, <harsha.harsha@xilinx.com>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <tanmay.shah@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>
Subject: [PATCH v3 0/2] Adds status interface for zynqmp-fpga
Date:   Thu, 13 Oct 2022 14:35:54 +0530
Message-ID: <20221013090556.741357-1-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT013:EE_|BL1PR12MB5707:EE_
X-MS-Office365-Filtering-Correlation-Id: 14215a16-1f5a-428e-c21b-08daacfa2b87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BesGy3Z5FIHosLs2ovCPH5IPRA9iBIhAutDZuConcYx0gg/RXoVRd1FuHObiuFhl+FOEqN7Iv8sozhgoHc+Ed4dCD0JeJExG/lj88BjoNKOOnyHjV0vzlXkj7t953dFXwlk2kCc86/5uraqMVVVPoRmyrC34OCyiqqgM38DKTDTonI6Jb7CnsJ/gl8LLI0n++zyjyqvbk2WkAsg5E13XEkVfYM/s6/RmufGkF9Rdq756hBbAVOrN3fa/F/mASMYGvnDJR1vQo/Vyj76mazPaRY9HaAES8nZpmXJh/dhWK6sWqwX5TodG323K0D1VYofvUsBM1CSey1EE6SAp4uwWGquG4V15LBND+nlFniQjXpRczY1NGuRC+Xgim5UA5iTdOl7oliIkqJgN3/oyEVr7YYO8IHQct9sAIZvtiRHF7wQ0gLZJP1/Zff7ZRK7x1KRa25F/1Rg1CLGUAEJfFoc0LCD2IEdff547DtVMZULdUIA5jal4A1atg1JUmhk2BFw11XXEvciGYi99JWlacvmQWfVR2A3xAhUwKGwgbsFpMJvP/W33n31tx6cKA4Q8WXtR4Os2zyxVeueXpSc493FCgKTVbsW+54ndGcEfcgP49/HI6Mamc4BV3a6/QLwENnZ6cXYh5T7sELGfkUod9PG2knmBOnk0dmp56gIklEqd2TL/XGu4KwP76D7OYwYO7E22Ydiu9Jz+FG7KyUDtGfYw2E621H2BrCQQ5gOBArbocx+YGkMZ+zmurfX7hXQHDV/OkoLImUW3gCz9srnR1AuR3NrSOFato18nkxeIr5DtvloTSRMca7fgCo1SQFbM6gfrU7OF+lr+DPhMcNrPL844+E34OFKws4Vbn3YWNvtSn7f0euIY9z1NO/pkrPiIpyK/+xR9YPq1K4HxN9cpGAF2kX6xQmKl6QfILPdKeoaGkMeQi8acJRiUXmHzIBn+42XQ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199015)(46966006)(36840700001)(40470700004)(41300700001)(5660300002)(70206006)(70586007)(8676002)(8936002)(4744005)(2906002)(6666004)(316002)(26005)(478600001)(966005)(40460700003)(110136005)(40480700001)(82310400005)(36756003)(103116003)(36860700001)(47076005)(1076003)(86362001)(186003)(336012)(2616005)(16526019)(426003)(356005)(921005)(81166007)(82740400003)(83996005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 09:06:09.6746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14215a16-1f5a-428e-c21b-08daacfa2b87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5707
X-Spam-Status: No, score=0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Adds status interface for zynqmp-fpga, It's a read only interface
which allows the user to get the Programmable Logic(PL) status.
 -Device Initialization error.
 -Device internal signal error.
 -All I/Os are placed in High-Z state.
 -Device start-up sequence error.
 -Firmware error.

For more details refer the ug570.
https://docs.xilinx.com/v/u/en-US/ug570-ultrascale-configuration

Nava kishore Manne (2):
  firmware: xilinx: Add pm api function for PL config reg readback
  fpga: zynqmp-fpga: Adds status interface

 drivers/firmware/xilinx/zynqmp.c     | 35 +++++++++++
 drivers/fpga/zynqmp-fpga.c           | 87 ++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 11 ++++
 3 files changed, 133 insertions(+)

-- 
2.25.1

