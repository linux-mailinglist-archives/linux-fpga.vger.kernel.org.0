Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7558B32ABC1
	for <lists+linux-fpga@lfdr.de>; Tue,  2 Mar 2021 21:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350063AbhCBUjb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 2 Mar 2021 15:39:31 -0500
Received: from mail-dm6nam10on2064.outbound.protection.outlook.com ([40.107.93.64]:58560
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239597AbhCBA0e (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 1 Mar 2021 19:26:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELTrcWDtRP1PRTtFSSAlnDmz9T61W/pcQY7+rzCwKDzl2YZCuPXxThksHwb5wVZIUFc/sWz5bXtNNHWYsIeJdwJMAvsEHkKbNMlmJTay5XoIegmQ8Fvs71EDHu8t3PlCZeyB19U2aAaFY9HdYz2l36gYynTm2oZDvf7114RM12fnOk/BYBcSsKVjAiakIJkLokIrBqncna/F1+qgzYJ9spFU3vyS2Qen+iEQcDV50+84cyLbwlvMHRDsDGG20GNUqLxu+j+uVaU44jbzRX6ftrlqgdKDe/H0QXPC76f2HIsHVM22gs9g5hx9sAtRbMDBTpiWONMx/wg0Qs+PoQ3s2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOxKBP17Cu07Nc/fVqzb7I5hv5Kf2wFmC+E4+qjyt8s=;
 b=OsAd1ynKGp6cRxW4ttKiu5CU0Tg3iVkkzbqy75oGydKFF6AAl3voaSgpuxm4of7RB9CJZ5m7Xdr3vFnB1LYsEYJFmZLApJZSH8ZSQJ6DL6QosV9QxFLBe3DsotPez9LwKlBjQn75qkD2mpimInGiX1qDo1ndyhtImHBuYnWvv34G+v/YQyis1+qe4iDXjB972VAeBjB2fCIwW45odGE1CAWE3/r9K0gS0MHwlDLPEucmK16q0Nlzu2BCAUa0E81BaZtA76nJDS9vXKJcR0X2pHuBzQ5vkfvx2yO6mwBKV+zw+nbYkgZjPckupooZiWMl1XOW20WiumPTOCLynJreSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOxKBP17Cu07Nc/fVqzb7I5hv5Kf2wFmC+E4+qjyt8s=;
 b=CIEuEiGjKdX+5fxuImrsH1G+tXtHCJddKQti1GX2E8N9X29rrQgoz1xVBFK+wencCMjw5S/UsKeVFOow4Gn6421n3MTpCybz22dxMU2E8SgaAIhLHMbFyob7UwrGA4TjhKXLSCFqPSKkQ0huonk76e2L3IYVn24kBDdHd3gcF4E=
Received: from CY4PR12CA0042.namprd12.prod.outlook.com (2603:10b6:903:129::28)
 by BN7PR02MB5059.namprd02.prod.outlook.com (2603:10b6:408:21::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.25; Tue, 2 Mar
 2021 00:25:40 +0000
Received: from CY1NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:129:cafe::cd) by CY4PR12CA0042.outlook.office365.com
 (2603:10b6:903:129::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Tue, 2 Mar 2021 00:25:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT055.mail.protection.outlook.com (10.152.74.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3890.19 via Frontend Transport; Tue, 2 Mar 2021 00:25:40 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 1 Mar 2021 16:25:38 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Mon, 1 Mar 2021 16:25:38 -0800
Envelope-to: maxz@xilinx.com,
 max.zhen@xilinx.com,
 michal.simek@xilinx.com,
 sonal.santan@xilinx.com,
 lizhi.hou@xilinx.com,
 stefanos@xilinx.com,
 robh@kernel.org,
 mdf@kernel.org,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 trix@redhat.com
Received: from [10.17.2.60] (port=48288)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lGsr3-0000MW-Th; Mon, 01 Mar 2021 16:25:37 -0800
Subject: Re: [PATCH V3 XRT Alveo 03/18] fpga: xrt: xclbin file helper
 functions
To:     Tom Rix <trix@redhat.com>, Lizhi Hou <lizhi.hou@xilinx.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-fpga@vger.kernel.org>, <maxz@xilinx.com>,
        <sonal.santan@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <devicetree@vger.kernel.org>,
        <mdf@kernel.org>, <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-4-lizhih@xilinx.com>
 <4628ef05-27d1-b92f-9126-27a1f810c608@redhat.com>
 <3b73400c-cca1-60af-4eea-ed85de77a977@xilinx.com>
 <c79176af-8d0c-2300-3e4a-dfa604f10a62@redhat.com>
From:   Lizhi Hou <lizhi.hou@xilinx.com>
Message-ID: <55ed0169-085c-9706-3b17-23ea582c43c3@xilinx.com>
Date:   Mon, 1 Mar 2021 16:25:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <c79176af-8d0c-2300-3e4a-dfa604f10a62@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1adb70d0-c6e2-4dae-cfe1-08d8dd11b594
X-MS-TrafficTypeDiagnostic: BN7PR02MB5059:
X-Microsoft-Antispam-PRVS: <BN7PR02MB505957A9DE8059BA01AB7C07A1999@BN7PR02MB5059.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vo1HYhSACBaJ9LdhBOcmnC7fbKzQb+1F0j8hzmg7fbAY+rZ/9i6aBd+C7kge5n0Xso1JdcnCUHOsyYqRmKb+KmdekALSbv60/YvrtqTI5N2FxA2hJKUydk84+93McYW1bLUWC6cNkd8xygH0XW1vxQuvkI23vGBLkQUhIk1SzsExR2x8+pvysPv4lEiZKv2aBbuhXpobn3JdZF48ovd4vGFj2iHh0mw0tW4/LW/+IXK2lfLTom0ivtmxAitoWUYizHxiv3Y169gT8adaylnvAqwA0PTPJJ49zkh46PJXCmYindmHaf+3FEpmWXFmu4T1SsHjpqDHpfcuSZkiM+HCZXOg118YlD/adGdF2t7Z/Y2W4wjfEX+eJY5rN67MZDpmE2bOKxd1RZH9t9tlXrJGjerFDEKl0petA0IlaXoQSgl0cRArdpKluWd1YdnHOxfatYH442jKS8vK1FT64j6D73OF7zLq6Jor4jqN152MrKZ1/ddlixPxrfMrD52+zQmH2/nlO28wG0bSL1gzw3ehZa4MWfEgZNlu0AElrD/RuwcoCMdADMo9HoG+/XT4uf+26zoHkEWJoH5KYQ0QXGaok5AlUKEMklhVx0OZTc3OkBPwCny/MgKx6rOs1SrbPu0PCrcgKzDnsmPoT73o5HI4QcvhjSTMWzK2khNMojI+RfIkHbAWijp3i7zKKFmkzRDL4TwfCFifdh/OoEGur+rVeUO2ibt4+qQdaQ942tY+V0Y=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(46966006)(36840700001)(426003)(107886003)(36756003)(2906002)(31696002)(478600001)(336012)(53546011)(82740400003)(186003)(36860700001)(26005)(83380400001)(82310400003)(44832011)(356005)(36906005)(2616005)(4326008)(110136005)(31686004)(8936002)(47076005)(4744005)(316002)(70206006)(9786002)(70586007)(7636003)(5660300002)(54906003)(8676002)(50156003)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 00:25:40.2466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1adb70d0-c6e2-4dae-cfe1-08d8dd11b594
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT055.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5059
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Tom，


On 02/28/2021 08:54 AM, Tom Rix wrote:
> CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
>
>
> On 2/26/21 1:23 PM, Lizhi Hou wrote:
>> Hi Tom,
>>
>>
> snip
>
>>> I also do not see a pragma pack, usually this is set of 1 so the compiler does not shuffle elements, increase size etc.
>> This data structure is shared with other tools. And the structure is well defined with reasonable alignment. It is compatible with all compilers we have tested. So pragma pack is not necessary.
> You can not have possibly tested all the configurations since the kernel supports many arches and compilers.
>
> If the tested existing alignment is ok, pragma pack should be a noop on your tested configurations.
>
> And help cover the untested configurations.
Got it. I will add pragma pack(1).

Lizhi
>
> Tom
>

