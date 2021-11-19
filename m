Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A97E45673A
	for <lists+linux-fpga@lfdr.de>; Fri, 19 Nov 2021 02:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbhKSBJV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 18 Nov 2021 20:09:21 -0500
Received: from mail-dm6nam08on2085.outbound.protection.outlook.com ([40.107.102.85]:50464
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231895AbhKSBJV (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 18 Nov 2021 20:09:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+r8gKaIqhXG3laGVD1iKp1xU6H7Jg1+7bqc1xr5NVf2aUj87uGH/ImV/d3ko34rtixg8D1Lc9nL9LIy61kDJNvjjWENlACD68wB7d0JyYhDSbPmh7q9P29W9k2RsYCfPKI9t656iL4PoG04d3CUsX33IhCL9jPJpQjrp2cznXWHVKsXKVOo2XyzkV9mLjmnAaf/MQkKcekCA7XBBx1+25+1pZ0HAE+tXNDNuZQLiNfrRh5qYuBYZ2ZrzUpq8XecTUf7QFkgBA4iHYwR5ZbM+wtVcm46HW9fdMCu1mMEo4I/QC4XoNaNMt4NvvDaTb+zxcGv0A/Oeb7Qu0B+FfwMew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=liluh0TUwfrPTpKTJFSswiVCEGgS5wziyqumgXOhQH8=;
 b=ggkWhm28CW0OXOpGDQy1MK68wdtieGEwQLEpMG859bsrlQTVlZ5wRccai6zEvO5MocX4fZdgMzUb2VZm+Z4w/Y28ojvEp/urQSaz8gOCluHM032+9lTQC5MUVPALFRYLCKnF383+HXGpTwVglVUx8q/XirdQ2Jpj2Sw0lt4sV45l3BxRs6fcA6jzGbJXzD+CLu/Qr1yRKxq2L66q6koSrOO0wfN1Iic/d1z6rI1+dc1yCvTB//icZFJsMdOugS9XrrsrAOZ52CmNlWH375gQBBEDiiF9EeLh+kroh0XUlwsoV2C9uJlXIkZJa1k8xml+YAb7cRfCRzfBIX/RpaX6pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=redhat.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liluh0TUwfrPTpKTJFSswiVCEGgS5wziyqumgXOhQH8=;
 b=jO6nFbfC4kiln9FeneF/RYC32iO1Cqe5Dj+7eoRIO9RFM60Jx+SamrHW9eBs354Qhzz+j9ayKAv95JVnWoI51RLWHBdkuQNbFa5FLkGct/vdR5BNuZiRGwcG1Gt551APnCUOw498Ih2NUHtwYoReYLz6sW3S6/T3cF8udFZgzI4=
Received: from SN7PR04CA0162.namprd04.prod.outlook.com (2603:10b6:806:125::17)
 by DM6PR02MB5257.namprd02.prod.outlook.com (2603:10b6:5:48::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 01:06:17 +0000
Received: from SN1NAM02FT0050.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:125:cafe::8c) by SN7PR04CA0162.outlook.office365.com
 (2603:10b6:806:125::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend
 Transport; Fri, 19 Nov 2021 01:06:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0050.mail.protection.outlook.com (10.97.5.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.19 via Frontend Transport; Fri, 19 Nov 2021 01:06:17 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 18 Nov 2021 17:06:16 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 18 Nov 2021 17:06:16 -0800
Envelope-to: trix@redhat.com,
 linux-kernel@vger.kernel.org,
 mdf@kernel.org,
 devicetree@vger.kernel.org,
 dwmw2@infradead.org,
 linux-fpga@vger.kernel.org,
 robh@kernel.org
Received: from [10.17.2.60] (port=54922)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1mnsM4-0008on-9l; Thu, 18 Nov 2021 17:06:16 -0800
Subject: Re: [PATCH V1 XRT Alveo Infrastructure 2/9] Documentation:
 devicetree: bindings: add xrt group binding
To:     Rob Herring <robh@kernel.org>, Lizhi Hou <lizhi.hou@xilinx.com>
CC:     <linux-fpga@vger.kernel.org>, <yliu@xilinx.com>,
        <dwmw2@infradead.org>, <devicetree@vger.kernel.org>,
        <stefanos@xilinx.com>, <sonal.santan@xilinx.com>,
        <michal.simek@xilinx.com>, <mdf@kernel.org>,
        <linux-kernel@vger.kernel.org>, Max Zhen <max.zhen@xilinx.com>,
        <trix@redhat.com>, <maxz@xilinx.com>
References: <20211118210323.1070283-1-lizhi.hou@xilinx.com>
 <20211118210323.1070283-3-lizhi.hou@xilinx.com>
 <1637273394.274455.1841667.nullmailer@robh.at.kernel.org>
From:   Lizhi Hou <lizhi.hou@xilinx.com>
Message-ID: <8f64e8d2-ece4-9a77-3fce-f87598ae4d19@xilinx.com>
Date:   Thu, 18 Nov 2021 17:06:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <1637273394.274455.1841667.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8bc1fa3-55a0-4d5d-4bb6-08d9aaf8ca44
X-MS-TrafficTypeDiagnostic: DM6PR02MB5257:
X-Microsoft-Antispam-PRVS: <DM6PR02MB525752B7AE7FF6FFC6400D45A19C9@DM6PR02MB5257.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dYCoRspEkmU0S4uyUgHgkODGx/IQK6VrvuxxyYSkrRFDuSB1Zsdh+Qo4orPyCnsF0jQBNMdSbCfLYbDz8MgtXCgQ9+/I4xy/jiK8+78leu5Pr9P/wQEjB2IUV4LRY/0U8OeCgfD5fGhs6Wk9IK96BpUkM4SYzKKpT9DYcipfYm8MAjgdt1qsw90BE1ammJgAsqhgMO4+ajsrR5X+dVNCM0S6eOQC17FCmSRewuaqTy5OsZaPpi6yCsDrfem2BbmXSOU4K+L2PkS0R/sDe/0V8CMTnfhoksRB/wx+KQN1KWorIRF/aenabIL35jmBPcJqWYt4bPujGEysEn5eksSk6j+ADJHqpqTpgcgU1334a+yZ+33SxqK6bvIS6+ymCLYdLLWsgZ6pynFOgYZ+1Q5e1b3eDiWAlHu+r24XXIBRwu8eMI3UQKTEhBLhfitLnGx4Ovrxs6cOCAzpHLQHrwH+hj6B/nVftFrhPhw4OkLYSkw95SFcZl32o2882tHWAbv/dSIfDX3u4O3sBayR/fITSM1IAhgd7G+G/HZOAY6dN558acr0nUhUdbkfAOINwCsW1Asw+qAclbF0WguQHgtmkcQO/+i3DzagAngUDrpCjl5/IIJLiTYsdCXWkp8lrUjZqPIHABZybbmsWXM9fPjjgJnTRib/rRy3SHA19qZ/pim4Z8zeJSSlzpsWZBHOpZio3w8LyllDAWaYKkL6r21xv/WPeulIXJtXsQNaKDAeANMF3di3DrvHcsriJXFINh06QxDYXJQsyClm2I+Fu8gzNLLssTquYaOdq0E3waiC7T8smkm4F0fmwvzrwQy2Q3vfS7eMrPWZshZ/QBbRbf6l/A==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(9786002)(110136005)(54906003)(70586007)(8676002)(2616005)(83380400001)(70206006)(316002)(36906005)(966005)(44832011)(36756003)(508600001)(31686004)(5660300002)(31696002)(82310400003)(426003)(356005)(47076005)(36860700001)(4326008)(2906002)(186003)(8936002)(336012)(7636003)(107886003)(26005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 01:06:17.0910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8bc1fa3-55a0-4d5d-4bb6-08d9aaf8ca44
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0050.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5257
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

I was able to reproduce the error after following the instructions. I 
will include the fix with next version of this patch set.

Thanks,

Lizhi

On 11/18/21 2:09 PM, Rob Herring wrote
>
> On Thu, 18 Nov 2021 13:03:16 -0800, Lizhi Hou wrote:
>> Create device tree binding document for xrt group device.
>>
>> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
>> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
>> ---
>>   .../bindings/xrt/xlnx,xrt-group.yaml          | 59 +++++++++++++++++++
>>   1 file changed, 59 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/xrt/xlnx,xrt-group.yaml
>>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/xrt/xlnx,xrt-group.yaml:22:6: [warning] wrong indentation: expected 4 but found 5 (indentation)
> ./Documentation/devicetree/bindings/xrt/xlnx,xrt-group.yaml:25:6: [warning] wrong indentation: expected 4 but found 5 (indentation)
>
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/xrt/xlnx,xrt-group.example.dt.yaml:0:0: /example-0/xrt-bus/xrt-group@48,0/ep_fpga_configuration_00@0,0,1e88000: failed to match any schema with compatible: ['xilinx.com,reg_abs-axi_hwicap-1.0', 'axi_hwicap']
> Documentation/devicetree/bindings/xrt/xlnx,xrt-group.example.dt.yaml:0:0: /example-0/xrt-bus/xrt-group@48,0/ep_fpga_configuration_00@0,0,1e88000: failed to match any schema with compatible: ['xilinx.com,reg_abs-axi_hwicap-1.0', 'axi_hwicap']
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/patch/1556809
>
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit.
>
