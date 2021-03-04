Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C016B32D9B0
	for <lists+linux-fpga@lfdr.de>; Thu,  4 Mar 2021 19:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbhCDSyL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 4 Mar 2021 13:54:11 -0500
Received: from mail-bn8nam12on2048.outbound.protection.outlook.com ([40.107.237.48]:50016
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231246AbhCDSyC (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 4 Mar 2021 13:54:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlyrMARLz3EHw6LzD51gT9qEbg0h49QP1YEXb9RKNS8+7fZ2kKmL//yVxv8b000W9q2IzkLmuC7SfrZFPEEU8laIAxj1H1arYkmb/r8UKOSbO9kfKl8atA5wMEwqiN6VkjQRLXXk9AifgNz9W07y/r9kHXnj7VxLXwXT9jaQV+yUQnrJndU1/1Hhep7ZG0VAj/oPXKag4spav8YzEuHBSmvKRfXLKnI2EVmQrcqPfWsiO+qMjLAxDWzbEhaie3Po5D0tQZGW+15qLX7+QeUWqeSMB7QJslY5Di1KQt1cLEoFZ8CHLBsXhK4Q+WbrOLldGxIluz1IgqI5I03jwfWO2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9WFCGarmGfC4gOsnhHfpWxz90jhxjZpQPUsFnLEcDw=;
 b=W3FpHCts1He0dDLKadbE4O71XocE8776Xx/QI8F7wI54Xfg+aVw8afHozvTwU1Jz9QFRACeQn7ZyKEEO92pdpTPc11dgDZ6UeZT67T3R6okQNBhvCeZkyRVeNCCY0btMcbQOJAaS79KMH1ROEmoLmsAlgYZ9HmD7xtsUZjBUcJOwAUZhMtxKqvdj/cPWMx4RFSRY8JdxrHh/y5S4Bs0Hkn7mLbPZv7ytwXA6DiURKSojHizb+zjIY+APOVkK3hglkaWmUs+YGykThWh3QqGjSOTW+40DeOqzIvJCcHXBnzbjlEDdktuBiyo0YoFIYafPYTIxk747tMtutSbHGHAiWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9WFCGarmGfC4gOsnhHfpWxz90jhxjZpQPUsFnLEcDw=;
 b=ovijQLld4Q8xBUIbcSjtdqwC/SsTKxVNAZSg/KFgsqpdptKhqq0hnNwtkI8rXKDcGvFlePe/JMhHBjnXPAHmjknI5J3VVejy4MPn2qAnlOvxvvyEzn3j5jEAtL/TC14RXebVxQvVjyP75nFp4ZTnHeIxU36TSI6dNkmS/foeTvw=
Received: from MN2PR20CA0014.namprd20.prod.outlook.com (2603:10b6:208:e8::27)
 by DM6PR02MB3930.namprd02.prod.outlook.com (2603:10b6:5:a4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 4 Mar
 2021 18:53:09 +0000
Received: from BL2NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:e8:cafe::67) by MN2PR20CA0014.outlook.office365.com
 (2603:10b6:208:e8::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Thu, 4 Mar 2021 18:53:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT016.mail.protection.outlook.com (10.152.77.171) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3890.19 via Frontend Transport; Thu, 4 Mar 2021 18:53:09 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 4 Mar 2021 10:53:09 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Thu, 4 Mar 2021 10:53:09 -0800
Envelope-to: maxz@xilinx.com,
 max.zhen@xilinx.com,
 michal.simek@xilinx.com,
 sonal.santan@xilinx.com,
 lizhi.hou@xilinx.com,
 stefanos@xilinx.com,
 robh@kernel.org,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 trix@redhat.com,
 mdf@kernel.org
Received: from [10.17.2.60] (port=54790)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lHt5x-0000Uu-22; Thu, 04 Mar 2021 10:53:09 -0800
Subject: Re: [PATCH V3 XRT Alveo 03/18] fpga: xrt: xclbin file helper
 functions
To:     Moritz Fischer <mdf@kernel.org>, Lizhi Hou <lizhi.hou@xilinx.com>
CC:     Tom Rix <trix@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-fpga@vger.kernel.org>, <maxz@xilinx.com>,
        <sonal.santan@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-4-lizhih@xilinx.com>
 <4628ef05-27d1-b92f-9126-27a1f810c608@redhat.com>
 <3b73400c-cca1-60af-4eea-ed85de77a977@xilinx.com>
 <c79176af-8d0c-2300-3e4a-dfa604f10a62@redhat.com>
 <55ed0169-085c-9706-3b17-23ea582c43c3@xilinx.com>
 <YD5WbLCdCTBALQiI@epycbox.lan>
From:   Lizhi Hou <lizhi.hou@xilinx.com>
Message-ID: <8d65e7bb-0ffe-dde1-8dce-527131e0bebe@xilinx.com>
Date:   Thu, 4 Mar 2021 10:53:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <YD5WbLCdCTBALQiI@epycbox.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c39671a7-d334-4599-0ff3-08d8df3ec16c
X-MS-TrafficTypeDiagnostic: DM6PR02MB3930:
X-Microsoft-Antispam-PRVS: <DM6PR02MB3930FBCE8C6C7FDE1F7737ECA1979@DM6PR02MB3930.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3VkABS6piJDPw48cFCKul6QQtLWSKOpidUygCFj1TrML0Ln5IjE2Ie7FjKVAFtqBxpwz226/quMU/IGVtatHkoGLeGD+OgAbaMvYcgxHwIokZXQGyt5HguOaQldtuYzhm9R273lJJbu9lvFwpr8G21ub1T2X7NWSS+TS21yx65kP6AdtE321S/wOAnrs3pyyUokh+PXBq9XS8GuRkHsGPAGQXtBL7cYQ7mXdWGy6c/oajF8F1HvejezT90BeyFQTLTdjVSAYFRVVvJRV5a9J0qRDzGoD5ePTTQRBdQ2FG5FTI7YGRr6+J2tApzEkRk5LXbSYkTIMbWnuoH/BRG0lGI2TH48qmgWEC8ESS3lugmoje3tCVh07zukSG9qtwrWMgFodMtdwEEEBAc1UjPGZVRcB154TWKOSEfoomI/yEMPuSL2oaJG0foxElgQYxkn+v+NQRUt09STaiXHFn83JyqpMflJQxChNuiCgvGszFK0WwwG8l8LsmlizpKhAxv8DxnTXRGFrTKgb1Xi6jEtveC+wSaO7vVGUBRXdhVn4m7VbkdizI39EW8T6DUpcHH01kz8RyFtCDeuPk3gA155+mxfEZGZ0tpCcxarJYjY8n08CQiaV8ZMMd+mHCIg4bh+v3sqdZZSq1Kn1TAqJErLTAJK8t7yOXXy+BRArwulCBH4T28EkEAkG7DVcp0Tp36s7P0EtZRx2Gu3m6zxFEAOycQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(46966006)(36840700001)(54906003)(26005)(82740400003)(31686004)(186003)(8676002)(478600001)(44832011)(9786002)(4326008)(110136005)(2616005)(5660300002)(426003)(31696002)(36756003)(107886003)(53546011)(7636003)(2906002)(8936002)(82310400003)(36860700001)(70206006)(47076005)(70586007)(356005)(336012)(36906005)(83380400001)(316002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 18:53:09.7576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c39671a7-d334-4599-0ff3-08d8df3ec16c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT016.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB3930
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Moritz,


On 03/02/2021 07:14 AM, Moritz Fischer wrote:
>
> On Mon, Mar 01, 2021 at 04:25:37PM -0800, Lizhi Hou wrote:
>> Hi Tom，
>>
>>
>> On 02/28/2021 08:54 AM, Tom Rix wrote:
>>> CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
>>>
>>>
>>> On 2/26/21 1:23 PM, Lizhi Hou wrote:
>>>> Hi Tom,
>>>>
>>>>
>>> snip
>>>
>>>>> I also do not see a pragma pack, usually this is set of 1 so the compiler does not shuffle elements, increase size etc.
>>>> This data structure is shared with other tools. And the structure is well defined with reasonable alignment. It is compatible with all compilers we have tested. So pragma pack is not necessary.
>>> You can not have possibly tested all the configurations since the kernel supports many arches and compilers.
>>>
>>> If the tested existing alignment is ok, pragma pack should be a noop on your tested configurations.
>>>
>>> And help cover the untested configurations.
>> Got it. I will add pragma pack(1).
> Please do not use pragma pack(), add __packed to the structs in
> question.
Ok, I will use __packed.

Thanks,
Lizhi
>
> - Moritz

