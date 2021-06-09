Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5B03A0C0F
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Jun 2021 07:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236094AbhFIFzK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Jun 2021 01:55:10 -0400
Received: from mail-bn7nam10on2060.outbound.protection.outlook.com ([40.107.92.60]:38497
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234310AbhFIFzI (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 9 Jun 2021 01:55:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnSQ4trucNj8yVUE0zm0AQUwcpqRkpbusCE0hAnSiDPqsiYgRdd2FY7EOVPwqf6njwdf2WAWtS/qbg+EXk5WcpjU55s9hepavd4xycoRfCVIdS9UEYVP6dz8Fd6FYmHQPXGhTTB1SulG3isahbOKVluDDk4HqZpHAYVKJ0IjlBscPbmpQ3Hq/KRitO9rrtGNi0Zu7ZWh4IVJqDiAy3867YzcRgVaW6da5nV0RRQjnx9OefS0Nxt3OplruZL+VATvfAqrV7Wn3vGTVfcwVLSj3aq7bSm/9xGeTm+XI3HdxIuu/lqdmrKpxJXTBuk46dI4B5Lr9SUNt5U1QS3bkP0SyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TMzxzrF+IIeHiYJO8qVBREoM78xEeIul92iqJBfg2w=;
 b=IRJsxL6Lb1KQIiYY5jC+KqPbF+FT+qoSJchtm5rS3OIarApjVsnaLazD+x/g5N/t9rjmajBo2ZX3r5WspNYj2+i4MqGRjtmWRIwUN26wIEunn+fr7aYTzp5MzcNZX8Sho5cuKbTVq1hTXWj2KENqC8KAt/eVHdSPl4wEYXvxV7Zqb0PQBkz6SAOl/4Qv+3JhydDI1NaQ3Mj2lUIEHGuIac5WZvo5P40wYZUxfit8GGtqFoQhi01yWXjlkP5Ln9TcMbCdEEEhpFsIZNSnwuIaMCTEU6h3iDf1+Wo6iCRk2SQEvMQ2qqDr/WExtiS4t+KemHoK86jJpkxGlerBGKyOqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TMzxzrF+IIeHiYJO8qVBREoM78xEeIul92iqJBfg2w=;
 b=Li7eNEfH/YpJJh143ZItm8zobwD2U5UXxtJSzlAof4ugsS4xe9ZV68Ww5fhPC5d6ogd2aW3PZuP44DCbd0R4sWnIf+FSQKFZVQvIj9NxT7hwbZ2HU+oHR431nG2yPaHq98ehcDBugKc1B+SdN/tn32fUkdIlQ6k2+LH+ndr1tDo=
Received: from BN9PR03CA0037.namprd03.prod.outlook.com (2603:10b6:408:fb::12)
 by MN2PR02MB6319.namprd02.prod.outlook.com (2603:10b6:208:180::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Wed, 9 Jun
 2021 05:53:09 +0000
Received: from BN1NAM02FT039.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::57) by BN9PR03CA0037.outlook.office365.com
 (2603:10b6:408:fb::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Wed, 9 Jun 2021 05:53:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT039.mail.protection.outlook.com (10.13.2.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Wed, 9 Jun 2021 05:53:09 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 22:52:53 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 8 Jun 2021 22:52:52 -0700
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
Received: from [10.140.6.60] (port=51918 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1lqr91-0007H3-KU; Tue, 08 Jun 2021 22:52:52 -0700
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
Subject: [RFC v2 2/4] fpga: Add new property to support user-key encrypted bitstream loading
Date:   Wed, 9 Jun 2021 11:22:30 +0530
Message-ID: <20210609055232.4501-3-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210609055232.4501-1-nava.manne@xilinx.com>
References: <20210609055232.4501-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1811ff0c-8bad-4702-eda3-08d92b0adc5d
X-MS-TrafficTypeDiagnostic: MN2PR02MB6319:
X-Microsoft-Antispam-PRVS: <MN2PR02MB631989B11EDAD444F078CB77C2369@MN2PR02MB6319.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J4kS9+ZIwJPG+60jqLRKn3Wu1tPDF51m4KeeMOeYUVQO0Ftjg+0saaYZpcj46WhxVQhLVewmgMzdGiQ6n/sks/YFqLPSsVl/IWsB8KuCysClY51kPja46GghjxSvF5o7mbYYVJh77R8E9zo3Bh94CTpCsZm9rolyBuJ6+fT5wZ4lsLx4sV0w9uWRpPXWXpthlVDFKcDzKLhZ5lywU4CHbGsVQWdz0Z0YcZOwwTRZ4sMzA1voZ1MGE6ESrtIG6buvFDXEMfyy2gIbkoKNGJtG1y71QyY7vU6PtAqaHBz9HtHkNEVTjB4OFlZ6ZiSoYrM5ed59F05Uf7HvZN/fKxP85QKaBAfuyiMs+NiCOEO3OHByMeQxePMYNwOe7jJAPQg7SOj+Z+vIPE/0FKG+mx8gmtCvjOftttm7BhXBTo2xE8I4dYMSZNvf/K0k491mJ6rvt0SvT9s0gxtx7n/rL41Wa/4e9+2u22OBsxn1R16ifTLGkxFcqXU5+/WRFBxABUSsjx4POkuKoLoVHhhAkmwpyx6O0rlKl3sVuCcgZKd+qw+L4kftSysXUWEVTEztJtEDszVImfZFQVD+F3eGK1nA/pxcAEwuL+VUPg4Q9LkRnrmhA2/l05Ij1aPUYeY/amQLh6nAHOOS4rNUT1O/MnmUs4WJRYMYhcuEiPWN71bQm4zwtoKARPsvq1iWfhxILRB299Hmp89owWd36z0gNfrF0ENADANgGZqwA6K+rZX5fWlg7mXALXSNVHgTunryxsUP
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(39850400004)(396003)(346002)(136003)(36840700001)(46966006)(7416002)(921005)(83380400001)(186003)(5660300002)(47076005)(356005)(70586007)(110136005)(336012)(426003)(7636003)(26005)(6666004)(8676002)(2616005)(9786002)(36906005)(7696005)(478600001)(36860700001)(36756003)(82310400003)(1076003)(2906002)(8936002)(316002)(70206006)(82740400003)(102446001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 05:53:09.4907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1811ff0c-8bad-4702-eda3-08d92b0adc5d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT039.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6319
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch Adds ‘encrypted-key-name’ property to
support user-key encrypted bitstream loading
use case.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v2:
                -Both DT properties ie; encrypted-key-name and encrypted-user-key-fpga-config
                 are targeted to use for the same use cases but ideally encrypted-key-name
                 is enough to serve the purpose so updated the file to remove the unwanted
                 encrypted-user-key-fpga-config property as suggested by Rob.

 Documentation/devicetree/bindings/fpga/fpga-region.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
index d787d57491a1..0de4a1c54650 100644
--- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
+++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
@@ -177,6 +177,9 @@ Optional properties:
 	it indicates that the FPGA has already been programmed with this image.
 	If this property is in an overlay targeting a FPGA region, it is a
 	request to program the FPGA with that image.
+- encrypted-key-name : should contain the name of an encrypted key file located
+	on the firmware search path. It will be used to decrypt the FPGA image
+	file with user-key.
 - fpga-bridges : should contain a list of phandles to FPGA Bridges that must be
 	controlled during FPGA programming along with the parent FPGA bridge.
 	This property is optional if the FPGA Manager handles the bridges.
-- 
2.17.1

