Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB37939B7FE
	for <lists+linux-fpga@lfdr.de>; Fri,  4 Jun 2021 13:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhFDLfb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 4 Jun 2021 07:35:31 -0400
Received: from mail-dm6nam12on2082.outbound.protection.outlook.com ([40.107.243.82]:19872
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229916AbhFDLfa (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 4 Jun 2021 07:35:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tqxx15X7J6KxgPgmORhLJYqcxoAyYynwdwbhB5sWhlEG9cL0dDE6wpqkjont4UCaZSeSJ9m8YGiB6Wb3hZSx9NHDv3EePwMBFU21fbg2BqxFOjoJU5gW1g2Gbiz6SpDGvDYC0sZKRCJ7t4YHdMWhke3HShPBLqD4f5c94KstIQ66g+oknVg3YRSmVCdMHitK87zK8356HM3yBfRUDW+gOcPNM8T3Oie98BlYMLVJgyGGKn2pzYg82qVXUsKQqnwzgZbg4mXRF4U9LlMrCj5yQor4AvUbWa9RiNkh2bUw+82Oys+qQk6PbVhcEbRt2NYamogWMbcZUiZjkeqTXO+YxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltuleEGy0Pg9v5UFjXEHzqxOAH1wsaCkSbVoDnzB2SM=;
 b=BPLTUzDgxH2L0tdbJaXjutOTgJJj5FrD0fwqMLAe+cDQ+GmrLHEtTERkOzPQrvTWHxuoNZUVMdnNRUwT1y/f2aq3h5DNOm0sQuDAWk0yybixw95gLMaUmraPk1fl11821UMarz1Ad0si+P44V2moDiJxzuJzonHBxvmQhXqsN8lD0VfJYPYht2AOHeN4bv9i8yz2ljYxe61PIVNGzicG1WQMQb4xuTrQjUxGpWAncONwfJDR829IwqllYQTM6+8BRFsm2yA1ffyYmmqXyAmYIE0s1a5Xax1VQXmUYmtWRQmD6ZiPPYIMin8BSF20AMY54yP4gWKjLecC+79WDTuTmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltuleEGy0Pg9v5UFjXEHzqxOAH1wsaCkSbVoDnzB2SM=;
 b=i/PWSslZU6MbOzkXixKFx8M8FlIpKMIp6sZ3DU3HuSKcO8qUaMHBuaQwBgE5vrD4GPcXDiNW6giZQetFN1HJdNz2SlwaKhMpRvYmYAFO4/annlChG5RCTej9L5C/Y4UGoe4EW7rX2/WR3aneBcGI7ceIhG6eP7w6grtei+ABU+I=
Received: from SN4PR0501CA0065.namprd05.prod.outlook.com
 (2603:10b6:803:41::42) by PH0PR02MB7637.namprd02.prod.outlook.com
 (2603:10b6:510:55::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Fri, 4 Jun
 2021 11:33:42 +0000
Received: from SN1NAM02FT0042.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:41:cafe::8b) by SN4PR0501CA0065.outlook.office365.com
 (2603:10b6:803:41::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.10 via Frontend
 Transport; Fri, 4 Jun 2021 11:33:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0042.mail.protection.outlook.com (10.97.4.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.18 via Frontend Transport; Fri, 4 Jun 2021 11:33:42 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 04:33:41 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 4 Jun 2021 04:33:41 -0700
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
Received: from [10.140.6.60] (port=49944 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1lp856-0005PI-G6; Fri, 04 Jun 2021 04:33:40 -0700
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
Subject: [PATCH v7 0/4]Add Bitstream configuration support for Versal
Date:   Fri, 4 Jun 2021 17:03:28 +0530
Message-ID: <20210604113332.1394-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a570d703-98e8-4cdf-d71b-08d9274c9b1f
X-MS-TrafficTypeDiagnostic: PH0PR02MB7637:
X-Microsoft-Antispam-PRVS: <PH0PR02MB763755D79041D6E16DBF556EC23B9@PH0PR02MB7637.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OAJkWH5/OFIYZOpRkhIB8tPjG5TdvRHsk0KrXJCi2tP5kYyfYRoPru3fP6zs80O8dYtPeZSR2Rry6qmRZVcpeT+xuIr8cRXEtJFSoQCbhW7uLbsu3KghljPWLMvTG0mdGyxjRJ5nX2CHTm1hW+zJsAatuGFEjvZyEWclgpfxdxMBQzSY8OQf6PCZE1ZmZDn1Rq4IN1mZPBc8wy+OIRVdzl4xJxlY1Hat7H0up+u+kM6n0wsG3U+wj+wTiz8j8gUXKrjCQdDsHSx7lYJeV60VyYO6bTzlbO5c2iD28sGx6yMW1oD+o3SAjZOkuVdEC2TJ1o7WzEztCo33xYx1SEMuYpmXkfPF0d3ATFkmcBm4lV6c6qeh/kQlBePNi1Uv6DbTobYopMH+CvUV+b3OkNl70FaTRUaTq0k7QsVZWEydKOrwI5Mzxb9EhXHhseZNGBCQEsdnVaRAf3wuP4FltQBaca248kPo19EO9w43MmVE7woeFPFmQrIUvU9rNm9P6SGNIupw40N5QKV3oYigo1z6kLhahY9eGQ08DN2RN2CgpgsqaPf1Y7wZ2xv8dwzySy9cTaeKa9EjrWmKLSrzNyni0vf9ML54bzyzAVZvg12qr4LvMOYh7su4wtdCGWTK8LFkw647uw1/elvVkrAGMzVsg7ko9xzn49DLCTpBbFJYvwtb0//VEwSAVy2htXJlG31BcqA7YIlxR2Vp5R5Y1ghOrsUOXHyuDtxj+D/xHMGRKEOTz0d1rqPwkTCi5eh77ZbC8SL0CBMss2SBHSFaSmn3C006AgXge7Xp4usqvMzqazQLVOmoFPC8iEHAtuimTLGM27lCfZjvH6iJDzIPwvmIyO18ybC7br7DYwfOXX2eHp8=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(36840700001)(46966006)(26005)(36756003)(8936002)(83380400001)(82310400003)(921005)(7696005)(1076003)(186003)(8676002)(82740400003)(7636003)(70206006)(9786002)(426003)(966005)(36906005)(6666004)(2906002)(110136005)(356005)(70586007)(316002)(5660300002)(36860700001)(7416002)(47076005)(336012)(2616005)(478600001)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 11:33:42.2389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a570d703-98e8-4cdf-d71b-08d9274c9b1f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0042.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7637
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This series Adds FPGA manager driver support for Xilinx Versal SoC.
it uses the firmware interface to configure the programmable logic.

Changes for v4:
                -Rebase the patch series on linux-next.
                https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

Changes for v5:
                -Updated binding doc's.

Changes for v6:
                -Updated firmware binding doc.

Changes for v7:
               -Updated versal-fpga.c driver to remove unwated priv
                struct dependency.

Appana Durga Kedareswara rao (1):
  dt-bindings: fpga: Add binding doc for versal fpga manager

Nava kishore Manne (3):
  drivers: firmware: Add PDI load API support
  dt-bindings: firmware: Add bindings for xilinx firmware
  fpga: versal-fpga: Add versal fpga manager driver

 .../firmware/xilinx/xlnx,zynqmp-firmware.yaml | 94 ++++++++++++++++++
 .../bindings/fpga/xlnx,versal-fpga.yaml       | 33 +++++++
 drivers/firmware/xilinx/zynqmp.c              | 17 ++++
 drivers/fpga/Kconfig                          |  9 ++
 drivers/fpga/Makefile                         |  1 +
 drivers/fpga/versal-fpga.c                    | 96 +++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h          | 10 ++
 7 files changed, 260 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml
 create mode 100644 drivers/fpga/versal-fpga.c

-- 
2.17.1

