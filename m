Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869EC2F9B90
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Jan 2021 09:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387770AbhARIxk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 18 Jan 2021 03:53:40 -0500
Received: from mail-eopbgr770071.outbound.protection.outlook.com ([40.107.77.71]:53440
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387605AbhARIxd (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 18 Jan 2021 03:53:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUQg/SA4LWH8Q64vg5R47Wslkop0bTxp0DUkJZOKXBuOV1GhI2DqRqo29kLpAotm6fbRbL6VuDLObDeC7DP4sy1E46B88ICR4I5Zy11gcvXq4KqQ//cNgdV8l09QbWoKOj86rhjASSZFpYqzCLxqE1ACewfIZkt5I/AYDZx00Ir2i7ajZE799BRfM5K/MLwNfs/FrdODwnlghhfhDGiUgIIrhSXOnBZwXOf726uAS2IhthWOpVFCwu/BhH6QmWRp64xvZZYvKXQ6Exz23aT741MLc+jCA7WJFhHbjRjDv5A/IspqTqHOZ1LH4u/XWuQdMN7z7Qh0LwImLf7kva8ivA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7i21hsS5FOJGLXBfCH/Sx0eLFeTn59xRfwuLq/Z6TI=;
 b=g6+d2eAPdUx8IAB9myQOa0MQvnqWwr0+rBX+kbCXEn01/ZpSELoErjLH1AEwIoyu4/PL5qlFAIpMFWuUFmbs3+6HNm01Q0FPq30galhZpQWYXwAtyULas1FVZEW/x2bBl4CYDgdFXWDhlFVNmaLLjAPkghwIC1Su1fMtHYg7ZvesPPaO6PdfSm/muzbO9mgwn7ARMi4cfonWH7VaI2GAgcmTJ+yBTK6F3CQCN55BWmraNOtIAc21CtYxnrCY7ksYBVhhFs87NHOg2/si1xX2b6AJ5pckEkliF+WMDBY1v2K4WMEkTdKbUZkIJ8i6clGhVx/VAQGFlsI2QUNxlw8rsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7i21hsS5FOJGLXBfCH/Sx0eLFeTn59xRfwuLq/Z6TI=;
 b=NDe9BaJA/CJqfMgmJNkgsbGVrjfs74d/1aZzzHVuj0j5ck5RefMx7vCYR6Tgnl+DdMWkTFDUujsUxRwL0qbsl9QbluElDwdLq2lOCbE8x5V795yZ/Ybuv9uBtkNHWegoktb/r5HGVvYclFwflMdJ1NdBcFPcYY51OlypMZcO2ZE=
Received: from BL1PR13CA0191.namprd13.prod.outlook.com (2603:10b6:208:2be::16)
 by BL0PR02MB4305.namprd02.prod.outlook.com (2603:10b6:208:4e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.13; Mon, 18 Jan
 2021 08:52:39 +0000
Received: from BL2NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:2be:cafe::93) by BL1PR13CA0191.outlook.office365.com
 (2603:10b6:208:2be::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.8 via Frontend
 Transport; Mon, 18 Jan 2021 08:52:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT009.mail.protection.outlook.com (10.152.77.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3763.12 via Frontend Transport; Mon, 18 Jan 2021 08:52:39 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 18 Jan 2021 00:52:16 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Mon, 18 Jan 2021 00:52:16 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 chinnikishore369@gmail.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 robh+dt@kernel.org,
 trix@redhat.com,
 mdf@kernel.org
Received: from [172.30.17.109] (port=33358)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1l1QGl-00086B-Ux; Mon, 18 Jan 2021 00:52:16 -0800
Subject: Re: [PATCH 2/3] dt-bindings: fpga: Add binding doc for versal fpga
 manager
To:     Nava kishore Manne <nava.manne@xilinx.com>, <mdf@kernel.org>,
        <trix@redhat.com>, <robh+dt@kernel.org>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <git@xilinx.com>, <chinnikishore369@gmail.com>,
        "Appana Durga Kedareswara rao" <appana.durga.rao@xilinx.com>
References: <20210118024318.9530-1-nava.manne@xilinx.com>
 <20210118024318.9530-2-nava.manne@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <9d7f1460-0431-4364-6406-1d4b8b3b6871@xilinx.com>
Date:   Mon, 18 Jan 2021 09:52:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210118024318.9530-2-nava.manne@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77cdbe7f-19c5-4b9e-fab0-08d8bb8e6917
X-MS-TrafficTypeDiagnostic: BL0PR02MB4305:
X-Microsoft-Antispam-PRVS: <BL0PR02MB4305880DB35309FE859E8493C6A40@BL0PR02MB4305.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ETU1Unw/6zKbKZHo9S2cbCY2tTJkq0xXfxTY4paKsxxBEZkI30/LdLaI+DGusB4v8ZfONxjxyrHsxb+02LMeQ+bFKfJgQiJZbOAD1F7RuWPCPaYot4LHubX8OX3cEchwmJiYShPzhGXYKQFjJ13W2H3IBUw1dRooJ6PxiSjrBfNZXUMqRFdU5Vs6vuwZsbAoT3gl8Z0suyTQBZ99dAuHv13sCcpCuo9M9VP70gVflex3Hmtm3uPgly+vO2l0lDOHLnEczokZt7Vx6kedkj+ib4BqY515EBBYYAgeRJHWIcrZq35zqkDSLu+C6UCgSZ536iz5LSXsc2uWASorgM60sk52LrUQq6A9+tGzr7mwGwB4sw+5ggP2n5iEElne90RFEhfpCGlA98Z0cY0UQWjaFGV7hqkjT9yreQ2f3ZWqS3FtX/8oq3bvHXpYgXrjNUpcgskTgh0YWHFMih1yXl2La2JcegnvAoo08UkDu9qYlqgOGHwabYeyqwE2FZPbYqIofbHfeuk07rrBNalXhqT9+6QrKz8kbQtHGkLqThheE3pTO9QM1R9RfH4wPtOMmQ1htn9KZJprF3DDQtNqy+byGg2oTINfnK2wi0oSPTp3Ixw=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39850400004)(346002)(396003)(136003)(376002)(46966006)(966005)(8936002)(82740400003)(426003)(2616005)(31696002)(31686004)(186003)(2906002)(26005)(7636003)(336012)(36756003)(53546011)(9786002)(44832011)(70206006)(70586007)(107886003)(478600001)(82310400003)(5660300002)(4326008)(36906005)(110136005)(316002)(54906003)(8676002)(6666004)(47076005)(356005)(50156003)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2021 08:52:39.4425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77cdbe7f-19c5-4b9e-fab0-08d8bb8e6917
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT009.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4305
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 1/18/21 3:43 AM, Nava kishore Manne wrote:
> From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
> 
> This patch adds binding doc for versal fpga manager driver.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
> ---
>  .../bindings/fpga/xlnx,versal-fpga.yaml       | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml
> 
> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml b/Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml
> new file mode 100644
> index 000000000000..cf3aa7917488
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml
> @@ -0,0 +1,33 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/fpga/xilinx/xlnx,versal-fpga.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx versal-fpga driver.
> +
> +maintainers:
> +  - Nava kishore Manne <nava.manne@xilinx.com>
> +
> +description: |
> +Device Tree versal-fpga bindings for the Versal SOC, Controlled
> +using Versal SoC firmware interface.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +        - xlnx,versal-fpga
> +
> +required:
> +  - compatible
> +
> +Required properties:
> +- compatible: should contain "xlnx,versal-fpga"
> +
> +examples:
> +  - |
> +    versal_fpga: fpga {
> +         compatible = "xlnx,versal-fpga";
> +    };
> 

There are issues with the binding
Run
make
DT_SCHEMA_FILES=Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml
dt_binding_check

and fix
./Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml:15:1:
[error] syntax error: could not find expected ':' (syntax)
and maybe others.

Thanks,
Michal

